class lhc_Travel definition inheriting from cl_abap_behavior_handler.
  private section.

    "Parecido a enumeracion para no hacer hard code de los status del viaje
    constants:
      begin of c_travel_status,
        status_open     type c length 1 value 'O', " Open
        status_accepted type c length 1 value 'A', " Accepted
        status_rejected type c length 1 value 'X', " Rejected
      end of c_travel_status.

    methods get_instance_features for instance features
      importing keys request requested_features for Travel result result.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for Travel result result.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for Travel result result.

    methods acceptTravel for modify
      importing keys for action Travel~acceptTravel result result.

    methods deductDiscount for modify
      importing keys for action Travel~deductDiscount result result.

    methods reCaclTotalPrice for modify
      importing keys for action Travel~reCaclTotalPrice.

    methods rejectTravel for modify
      importing keys for action Travel~rejectTravel result result.

    methods calculateTotalPrice for determine on modify
      importing keys for Travel~calculateTotalPrice.

    methods setStatusToOpen for determine on modify
      importing keys for Travel~setStatusToOpen.

    methods setTravelNumber for determine on save
      importing keys for Travel~setTravelNumber.

    methods validateAgency for validate on save
      importing keys for Travel~validateAgency.

    methods validateCustomer for validate on save
      importing keys for Travel~validateCustomer.

    methods validateDateRange for validate on save
      importing keys for Travel~validateDateRange.

endclass.

class lhc_Travel implementation.

  method get_instance_features.
    "Se definiio en Behavior Definition features,instances y lo mismo para las acciones
    "Features para controlar la editabilidad de campos y habilitacion de acciones dependiendo condiciones

    read entities of z_r_travel_fjcm in local mode
    entity Travel
    fields ( OverallStatus )
    with corresponding #( keys )
    result data(travels)
    failed failed.  "Failed es para controlar errores

    result = value #( for travel in travels (
                                       %tky = travel-%tky
                                       %field-BookingFee      = cond #( when travel-OverallStatus = c_travel_status-status_accepted "Si un viaje esta aceptado, el campo BookingFee es de solo lectura, sino es editable
                                                                        then if_abap_behv=>fc-f-read_only
                                                                        else if_abap_behv=>fc-f-unrestricted )
                                       %action-acceptTravel   = cond #( when travel-OverallStatus = c_travel_status-status_accepted "Si un viaje esta aceptado, la accion de aceptar viaje se deshabilita, sino se habilita
                                                                        then if_abap_behv=>fc-o-disabled
                                                                        else if_abap_behv=>fc-o-enabled )
                                       %action-rejectTravel   = cond #( when travel-OverallStatus = c_travel_status-status_rejected "Si un viaje esta rechazado, la accion de rechazar viaje se deshabilita, sino se habilita
                                                                        then if_abap_behv=>fc-o-disabled
                                                                        else if_abap_behv=>fc-o-enabled )
                                       %action-deductDiscount = cond #( when travel-OverallStatus = c_travel_status-status_accepted "Si un viaje esta aceptado, la accion de deducir descuento se habilita, sino se deshabilita
                                                                          or travel-OverallStatus = c_travel_status-status_rejected
                                                                        then if_abap_behv=>fc-o-disabled
                                                                        else if_abap_behv=>fc-o-enabled )
       ) ).

  endmethod.

  method get_instance_authorizations.

    "Para el object page "Para este caso bloquearemos el update y delete para la agencia 70021

    data: update_requested type abap_bool,
          update_granted   type abap_bool,
          delete_requested type abap_bool,
          delete_granted   type abap_bool.

    read entities of z_r_travel_fjcm in local mode
    entity Travel
    fields ( AgencyID )
    with corresponding #( keys )
    result data(travels)
    failed failed.


    update_requested = cond #( when requested_authorizations-%update = if_abap_behv=>mk-on
                                 or requested_authorizations-%action-Edit = if_abap_behv=>mk-on
                               then abap_true
                               else abap_false ).

    delete_requested = cond #( when requested_authorizations-%delete = if_abap_behv=>mk-on
                               then abap_true
                               else abap_false ).

    data(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    loop at travels into data(travel).

      if travel-AgencyID is not initial.

        if update_requested eq abap_true.

          if lv_technical_name eq 'CB9980003145' and travel-AgencyID ne '70021'.

            update_granted = abap_true.

          else.

            update_granted = abap_false.

            append value #( %tky              = travel-%tky
                            %msg              = new zcl_message_rap_travel( textid    = zcl_message_rap_travel=>not_authorized_for_agencyID
                                                                            agency_id = travel-AgencyID
                                                                            severity  = if_abap_behv_message=>severity-error )
                            %element-AgencyID = if_abap_behv=>mk-on ) to reported-travel.

          endif.

        endif.

        if delete_requested eq abap_true.

          if lv_technical_name eq 'CB9980003145' and travel-AgencyID ne '70021'.

            delete_granted = abap_true.

          else.

            delete_granted = abap_false.

            append value #( %tky              = travel-%tky
                            %msg              = new zcl_message_rap_travel( textid    = zcl_message_rap_travel=>not_authorized_for_agencyID
                                                                            agency_id = travel-AgencyID
                                                                            severity  = if_abap_behv_message=>severity-error )
                            %element-AgencyID = if_abap_behv=>mk-on ) to reported-travel.

          endif.

        endif.

      else.

        if lv_technical_name eq 'CB9980003145'.

          update_granted = abap_true.

        endif.

        if update_granted = abap_false.

          append value #( %tky              = travel-%tky
                          %msg              = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>not_authorized
                                                                          severity = if_abap_behv_message=>severity-error )
                          %element-AgencyID = if_abap_behv=>mk-on ) to reported-travel.

        endif.

      endif.

      append value #( let upd_auth = cond #( when update_granted eq abap_true
                                             then if_abap_behv=>auth-allowed
                                             else if_abap_behv=>auth-unauthorized )
                          del_auth = cond #( when delete_granted eq abap_true
                                             then if_abap_behv=>auth-allowed
                                             else if_abap_behv=>auth-unauthorized )

                       in
                       %tky = travel-%tky
                       %update = upd_auth
                       %action-Edit = upd_auth
                       %delete = del_auth ) to result.

    endloop.

  endmethod.

  method get_global_authorizations.

    "Autorizaciones globales para el List page

    data(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ). "Para obtener el nombre tecnico del usuario logueado

    if requested_authorizations-%create eq if_abap_behv=>mk-on.

      if lv_technical_name eq 'CB9980003145'. "Si el usuario logeado es CB9980007474, se le permite crear viajes

        result-%create = if_abap_behv=>auth-allowed .

      else.

        result-%create = if_abap_behv=>auth-unauthorized.

        append value #( %msg    = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>not_authorized
                                                              severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) to reported-travel.

      endif.

    endif.

    "Logica para el update(Editar,Actualizar) y el boton edit en el list page
    if requested_authorizations-%update eq if_abap_behv=>mk-on or  "Si fuera por endpoint
       requested_authorizations-%action-Edit eq if_abap_behv=>mk-on. "Por boton Edit

      if lv_technical_name eq 'CB9980003145'.

        result-%update = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.

      else.

        result-%update = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        append value #( %msg    = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>not_authorized
                                                              severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) to reported-travel.

      endif.

    endif.

    "Logica para el delete y el boton delete en el list page
    if requested_authorizations-%delete eq if_abap_behv=>mk-on.

      if lv_technical_name eq 'CB9980003145'.

        result-%delete = if_abap_behv=>auth-allowed .

      else.

        result-%delete = if_abap_behv=>auth-unauthorized.

        append value #( %msg    = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>not_authorized
                                                              severity = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) to reported-travel.

      endif.

    endif.

  endmethod.

  method acceptTravel.

    "keys: Es una tabla que ya te da el framework con los IDs que el usuario seleccionó.

    "Modificando el estatus de entidad a las instancias(registros) seleccionados //En el DEBUG LO HACE 1 POR 1 PERO
    modify entities of z_r_travel_fjcm in local mode
    entity Travel "Alias que se le dio en el behavior definition
    update
    fields ( OverallStatus )
    with value #( for key in keys ( %tky          = key-%tky
                                    OverallStatus = c_travel_status-status_accepted ) ).


    "Leyendo las instancias de la entidad que seleccione leyendo todos sus campos y guardandolos en travels
    read entities of z_r_travel_fjcm  in local mode
    entity Travel
    all fields
    with corresponding #( keys )
    result data(travels).

    "Para refrescar pantalla de Fiori sin recargar toda la pagina, se hace un loop para devolver los registros modificados a la pantalla, en este caso el estatus cambiado a accepted
    "Result es lo que devuelve, loop dentro de la tabla de la lectura Travels y guardando cada registro en travel
    result = value #( for travel in travels ( %tky   = travel-%tky
                                              %param = travel ) ).

  endmethod.

  method deductDiscount.

    "Variable para almanecar los viajes a modificar
    data: travels_for_update type table for update z_r_travel_fjcm.

    "Validacion para el porcentaje tenga sentido
    data(keys_valid_discount) = keys.

    loop at keys_valid_discount assigning field-symbol(<fs_key_valid_discount>)
       where %param-discount_percent is initial
          or %param-discount_percent > 100
          or %param-discount_percent <= 0.

      append value #( %tky = <fs_key_valid_discount>-%tky ) to failed-travel.

      append value #( %tky                       = <fs_key_valid_discount>-%tky
                      %msg                       = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>discount_invalid
                                                                               severity = if_abap_behv_message=>severity-error ) "severity Si es error, warning
                      %op-%action-deductDiscount = if_abap_behv=>mk-on ) to reported-travel.

      data(lv_error) = abap_true.

    endloop.

    check lv_error ne abap_true.

    "Leyendo solo el Booking Fee
    read entities of z_r_travel_fjcm in local mode
    entity Travel
    fields ( BookingFee
             Description )
    with corresponding #( keys )
    result data(travels).

    data percentage type decfloat16.

    loop at travels assigning field-symbol(<fs_travel>).

      "Forma de leer y acceder al valor del parametro
      data(discount_percentage) = keys[ key id %tky = <fs_travel>-%tky ]-%param-discount_percent.
      data(test_field) = keys[ key id %tky = <fs_travel>-%tky ]-%param-test_field. "Para probar que se esta leyendo el valor del parametro correctamente

      "Logica del Booking Fee
      percentage = discount_percentage / 100.
      data(reduced_fee) = <fs_travel>-BookingFee * ( 1 - percentage ). "Calculo del nuevo valor con descuento

      "Append a la tabla travels_for_update y asignando el nuevo valor del Booking fee con el descuento hecho
      append value #( %tky        = <fs_travel>-%tky
                      BookingFee  = reduced_fee
                      Description = test_field ) to travels_for_update.

    endloop.

    "Modificando el campo BookingFee con el nuevo valor con descuento de las instancias seleccionados
    modify entities of z_r_travel_fjcm in local mode
           entity Travel
           update
           fields ( BookingFee
                    Description )
           with travels_for_update.

    "Obteniendo el valor actualizado de los viajes con descuento para refrescar la pantalla
    read entities of z_r_travel_fjcm in local mode
          entity Travel
          all fields
          with corresponding #( keys )
          result data(travels_with_dicount).

    "Lo que se se devuelve a la pantalla de Fiori
    result = value #( for travel in travels_with_dicount ( %tky   = travel-%tky
                                                           %param = travel ) ).

  endmethod.

  method reCaclTotalPrice. "Cuando se modifica el BookingFee o el CurrencyCode

  "Scenario
  "App para manejar viajes, cada viaje(Travel_id) tiene varios clientes, entonces tengo que
  "Sacar el precio total de cada viaje sumando el precio de cada vuelo mas el booking fee


  "IMPORTANTE AL CAMBIAR EL CURRENCY CODE NO FUNCIONA, VER DESPUES

    read entities of z_r_travel_fjcm in local mode
      entity Travel
      fields ( TravelID BookingFee CurrencyCode )
      with corresponding #( keys )
      result data(travels).

    delete travels where CurrencyCode is initial. "Descarto travels que no tienen currencyCode porque no se pueden calcular

    loop at travels assigning field-symbol(<fs_travel>).

      clear <fs_travel>-TotalPrice. "Para iniciar el calculo desde 0 cada vez

      " 3. Buscamos en la tabla de vuelos (los 'Hijos')
      " Sumamos el precio de todos los vuelos que pertenecen a este TravelID y moneda
      select single
        from /dmo/booking
        fields sum( flight_price )
        where travel_id = @<fs_travel>-TravelID
          and currency_code = @<fs_travel>-CurrencyCode "Para que tambien evalue la moneda
        into @data(lv_total_flights).

      " 4. Si encontramos vuelos, los sumamos al total del viaje
      if sy-subrc = 0 and lv_total_flights is not initial.
        <fs_travel>-TotalPrice += lv_total_flights.
      endif.

      <fs_travel>-TotalPrice += <fs_travel>-BookingFee. "Sumamos el BookingFee al TotalPrice del viaje

    endloop.

    " 5. Le decimos al sistema que actualice el campo TotalPrice con el nuevo valor
    modify entities of z_r_travel_fjcm in local mode
      entity Travel
        update fields ( TotalPrice )
        with corresponding #( travels ).

  endmethod.

  method rejectTravel.

    "Misma logica que acceptTravel pero cambiando el estatus a Rejected

    modify entities of z_r_travel_fjcm in local mode
    entity Travel "Alias que se le dio en el behavior definition
    update
    fields ( OverallStatus )
    with value #( for key in keys ( %tky          = key-%tky
                                    OverallStatus = c_travel_status-status_rejected ) ).


    "Leyendo los viajes de la entidad travel con todos sus campos y guardandolos en travels //"KEYS"
    read entities of z_r_travel_fjcm  in local mode
    entity Travel
    all fields
    with corresponding #( keys )
    result data(travels).

    "Result es lo que devuelve, loop dentro de la tabla de la lectura Travels y guardando cada registro en travel
    result = value #( for travel in travels ( %tky   = travel-%tky
                                              %param = travel ) ).

  endmethod.

  method calculateTotalPrice.


    modify entities of z_r_travel_fjcm in local mode
             entity Travel
             execute reCaclTotalPrice
             from corresponding #( keys ).

  endmethod.

  method setStatusToOpen."Determinacion para el Status "Este es on Modify osea al momento de cambiar o modificar(aparecera reflejado antes del on save)

    read entities of z_r_travel_fjcm in local mode
          entity Travel
          fields ( OverallStatus )
          with corresponding #( keys )
          result data(travels).

    delete travels where OverallStatus is not initial.

    check travels is not initial.

    modify entities of z_r_travel_fjcm in local mode
           entity Travel
           update fields ( OverallStatus )
           with value #( for travel in travels ( %tky          = travel-%tky
                                                 OverallStatus = c_travel_status-status_open ) ).

  endmethod.

  method setTravelNumber. "Determinaciones para el TravelID "Este es on Save osea al momento de guardar los cambios

    "Obtengo los TravelsID
    read entities of z_r_travel_fjcm in local mode
      entity Travel
      fields ( TravelID )
      with corresponding #( keys )
      result data(travels).

    "Limpio los que tengan TravelID
    delete travels where TravelID is not initial.
    "Checkeo si es quedaron viajes sin TravelID
    check travels is not initial.

    select single from ztravel_fjcm
    fields max( travel_id ) "Obtengo el maximo TravelID de la tabla de base de datos
    into @data(lv_max_travel_id).

    "Modifico para establecer el TravelID
    modify entities of z_r_travel_fjcm in local mode
    entity Travel
    update fields ( TravelID )
    with value #( for travel in travels index into i "Index into para tener un contador dentro del loop
                  ( %tky     = travel-%tky
                    TravelID = lv_max_travel_id + i ) ).

  endmethod.


  method validateAgency.

    "Failed es para bloquear estado transaccional
    "Reported es para mostrar mensajes

    "Lee el customerID
    read entities of z_r_travel_fjcm  in local mode
    entity Travel
    fields ( AgencyID )
    with corresponding #( keys )
    result data(travels).

    data agencies type sorted table of /dmo/agency with unique key client agency_id. "Se maneja client por el inner

    agencies = corresponding #( travels discarding duplicates mapping agency_id = AgencyID except * ).
    delete agencies where agency_id is initial.

    if agencies is not initial.

      select from /dmo/agency as ddbb
               inner join @agencies as http_req on ddbb~agency_id eq http_req~agency_id
               fields ddbb~agency_id
               into table @data(valid_agencies).

    endif.

    loop at travels into data(travel).

      append value #( %tky        = travel-%tky
                      %state_area = 'VALIDATE_AGENCY' ) to reported-travel.

      if travel-AgencyID is initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky              = travel-%tky
                        %state_area       = 'VALIDATE_AGENCY'
                        %msg              = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>enter_agency_id
                                                                        severity = if_abap_behv_message=>severity-error )
                        %element-AgencyID = if_abap_behv=>mk-on
                      ) to reported-travel.

      elseif travel-AgencyID is not initial and not line_exists( valid_agencies[ agency_id = travel-AgencyID ] ).

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky              = travel-%tky
                        %state_area       = 'VALIDATE_AGENCY'
                        %msg              = new zcl_message_rap_travel( textid    = zcl_message_rap_travel=>agency_unkown
                                                                        agency_id = travel-AgencyID
                                                                        severity  = if_abap_behv_message=>severity-error )
                        %element-AgencyID = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

    endloop.


  endmethod.

  method validateCustomer.

    "Failed es para bloquear estado transaccional
    "Reported es para mostrar mensajes

    read entities of z_r_travel_fjcm in local mode
           entity Travel
           fields ( CustomerID )
           with corresponding #( keys )
           result data(travels).

    data customers type sorted table of /dmo/customer with unique key client customer_id.

    customers = corresponding #( travels discarding duplicates mapping customer_id = CustomerID except * ).
    delete customers where customer_id is initial.

    if customers is not initial.

      select from /dmo/customer as ddbb
             inner join @customers as http_req on ddbb~customer_id eq http_req~customer_id
             fields ddbb~customer_id
             into table @data(valid_customers).

    endif.

    loop at travels into data(travel).

      append value #( %tky        = travel-%tky
                      %state_area = 'VALIDATE_CUSTOMER'
                    ) to reported-travel.

      if travel-CustomerID is initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky                = travel-%tky
                        %state_area         = 'VALIDATE_CUSTOMER'
                        %msg                = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>enter_customer_id
                                                                          severity = if_abap_behv_message=>severity-error )
                        %element-CustomerID = if_abap_behv=>mk-on
                      ) to reported-travel.

      elseif travel-CustomerID is not initial and not line_exists( valid_customers[ customer_id = travel-CustomerID ] ).

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky                = travel-%tky
                        %state_area         = 'VALIDATE_CUSTOMER'
                        %msg                = new zcl_message_rap_travel( textid      = zcl_message_rap_travel=>customer_unkown
                                                                          customer_id = travel-CustomerID
                                                                          severity    = if_abap_behv_message=>severity-error )
                        %element-CustomerID = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

    endloop.

  endmethod.

  method validateDateRange.

    "Failed es para bloquear estado transaccional
    "Reported es para mostrar mensajes

    read entities of z_r_travel_fjcm in local mode
             entity Travel
             fields ( BeginDate
                      EndDate )
             with corresponding #( keys )
             result data(travels).

    loop at travels into data(travel).

      "Logica para validar que la fecha no sea inicial osea vacia
      if travel-BeginDate is initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky               = travel-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>enter_begin_date
                                                                         severity = if_abap_behv_message=>severity-error )
                        %element-BeginDate = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

      "Logica para validar que la fecha no sea inicial osea vacia
      if travel-EndDate is initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky             = travel-%tky
                        %state_area      = 'VALIDATE_DATES'
                        %msg             = new zcl_message_rap_travel( textid   = zcl_message_rap_travel=>enter_end_date
                                                                       severity = if_abap_behv_message=>severity-error )
                        %element-EndDate = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

      "Logica para validar las fechas
      if travel-EndDate < travel-BeginDate and travel-BeginDate is not initial
                                           and travel-EndDate is not initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky               = travel-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = new zcl_message_rap_travel( textid     = zcl_message_rap_travel=>begin_date_bef_end_date
                                                                         begin_date = travel-BeginDate
                                                                         end_date   = travel-EndDate
                                                                         severity   = if_abap_behv_message=>severity-error )
                        %element-BeginDate = if_abap_behv=>mk-on
                        %element-EndDate   = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

      if travel-BeginDate < cl_abap_context_info=>get_system_date(  ) and travel-BeginDate is not initial.

        append value #( %tky = travel-%tky ) to failed-travel.

        append value #( %tky               = travel-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = new zcl_message_rap_travel( textid     = zcl_message_rap_travel=>begin_date_on_or_bef_sysdate
                                                                         begin_date = travel-BeginDate
                                                                         severity   = if_abap_behv_message=>severity-error )
                        %element-BeginDate = if_abap_behv=>mk-on
                      ) to reported-travel.

      endif.

    endloop.

  endmethod.

endclass.
