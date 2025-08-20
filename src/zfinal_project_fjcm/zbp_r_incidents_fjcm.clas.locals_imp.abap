class lhc_Incident definition inheriting from cl_abap_behavior_handler.
  public section.

    constants: begin of mc_status,
                 open        type zde_status_fjcm value 'OP',
                 in_progress type zde_status_fjcm value 'IP',
                 pending     type zde_status_fjcm value 'PE',
                 completed   type zde_status_fjcm value 'CO',
                 closed      type zde_status_fjcm value 'CL',
                 canceled    type zde_status_fjcm value 'CN',
               end of mc_status.

  private section.

    methods setDefaultValues for determine on modify
      importing keys for Incidents~setDefaultValues.

    methods get_instance_features for instance features
      importing keys request requested_features for Incidents result result.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for Incidents result result.

    methods changeStatus for modify
      importing keys for action Incidents~ChangeStatus result result.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for Incidents result result.

    methods setdefaulthistory for determine on save
      importing keys for incidents~setdefaulthistory.
    methods sethistory for modify
      importing keys for action incidents~sethistory.

    methods get_history_index exporting ev_incuuid      type sysuuid_x16
                              returning value(rv_index) type zdt_inct_h_fjcm-his_id.

endclass.

class lhc_Incident implementation.

method setDefaultValues.
** Read root entity entries
    read entities of z_r_incidents_fjcm in local mode
     entity Incidents
     fields ( CreationDate
              Status ) with corresponding #( keys )
     result data(incidents).

** NUEVA VALIDACIÓN: Verificar fecha futura ANTES de eliminar registros
    data(lv_current_date) = cl_abap_context_info=>get_system_date( ).

    " Validar fechas futuras en los registros que SÍ tienen fecha
    loop at incidents into data(ls_incident) where CreationDate is not initial.
      if ls_incident-CreationDate > lv_current_date.

        " Mostrar mensaje de error
        append value #(
          %tky = ls_incident-%tky
          %msg = new zcl_incidents_messages_fjcm(
            textid = zcl_incidents_messages_fjcm=>future_date_not_allowed
            incident_id = |{ ls_incident-IncidentID }|
            severity = if_abap_behv_message=>severity-error
          )
          %element-CreationDate = if_abap_behv=>mk-on
          %state_area = 'VALIDATE_DATE'
        ) to reported-incidents.

      endif.
    endloop.

** This important for logic
    delete incidents where CreationDate is not initial.

    check incidents is not initial.

** Get Last index from Incidents
    select from zdt_inct_fjcm
      fields max( incident_id ) as max_inct_id
      where incident_id is not null
      into @data(lv_max_inct_id).

    if lv_max_inct_id is initial.
      lv_max_inct_id = 1.
    else.
      lv_max_inct_id += 1.
    endif.

** Modify status in Root Entity
    modify entities of z_r_incidents_fjcm in local mode
      entity Incidents
      update
      fields ( IncidentID
               CreationDate
               Status )
      with value #(  for incident in incidents ( %tky = incident-%tky
                                                 IncidentID = lv_max_inct_id
                                                 CreationDate = cl_abap_context_info=>get_system_date( )
                                                 Status       = mc_status-open )  ).
endmethod.

  method get_instance_features.
    data lv_history_index type i.
    read entities of z_r_incidents_fjcm in local mode
       entity Incidents
         fields ( Status )
         with corresponding #( keys )
       result data(incidents)
       failed failed.

** Disable changeStatus for Incidents Creation
    data(lv_create_action) = lines( incidents ).
    if lv_create_action eq 1.
      lv_history_index = get_history_index( importing ev_incuuid = incidents[ 1 ]-IncUUID ).
    else.
      lv_history_index = 1.
    endif.

    result = value #( for incident in incidents
                          ( %tky                   = incident-%tky
                            %action-ChangeStatus   = cond #( when incident-Status = mc_status-completed or
                                                                  incident-Status = mc_status-closed    or
                                                                  incident-Status = mc_status-canceled  or
                                                                  lv_history_index = 0
                                                             then if_abap_behv=>fc-o-disabled
                                                             else if_abap_behv=>fc-o-enabled )

                            %assoc-_History       = cond #( when incident-Status = mc_status-completed or
                                                                 incident-Status = mc_status-closed    or
                                                                 incident-Status = mc_status-canceled  or
                                                                 lv_history_index = 0
                                                            then if_abap_behv=>fc-o-disabled
                                                            else if_abap_behv=>fc-o-enabled )
                          ) ).
  endmethod.

  method changeStatus.
* Declaration of necessary variables
    data: lt_updated_root_entity type table for update z_r_incidents_fjcm,
          lt_association_entity  type table for create z_r_incidents_fjcm\_History,
          lv_status              type zde_status_fjcm,
          lv_text                type zdt_inct_h_fjcm-text,
          lv_exception           type string,
          lv_error               type c,
          ls_incident_history    type zdt_inct_h_fjcm,
          lv_max_his_id          type zdt_inct_h_fjcm-his_id,
          lv_wrong_status        type zde_status_fjcm.

** Iterate through the keys records to get parameters for validations
    read entities of z_r_incidents_fjcm in local mode
         entity Incidents
         all fields with corresponding #( keys )
         result data(incidents)
         failed failed.

** Get parameters
    loop at incidents assigning field-symbol(<incident>).
** Get Status
      lv_status = keys[ key id %tky = <incident>-%tky ]-%param-status.

**  It is not possible to change the pending (PE) to Completed (CO) or Closed (CL) status
      if <incident>-Status eq mc_status-pending and lv_status eq mc_status-closed or
         <incident>-Status eq mc_status-pending and lv_status eq mc_status-completed.
** Set authorizations
        append value #( %tky = <incident>-%tky ) to failed-incidents.

        lv_wrong_status = lv_status.
* Customize error messages
        append value #( %tky = <incident>-%tky
                        %msg = new zcl_incidents_messages_fjcm(
                          textid = zcl_incidents_messages_fjcm=>status_invalid
                          status = |{ lv_wrong_status }|
                          severity = if_abap_behv_message=>severity-error
                        )
                        %state_area = 'VALIDATE_COMPONENT'
                      ) to reported-incidents.
        lv_error = abap_true.
        exit.
      endif.

      append value #( %tky = <incident>-%tky
                      ChangedDate = cl_abap_context_info=>get_system_date( )
                      Status = lv_status ) to lt_updated_root_entity.

** Get Text
      lv_text = keys[ key id %tky = <incident>-%tky ]-%param-text.

      lv_max_his_id = get_history_index(
                  importing
                    ev_incuuid = <incident>-IncUUID ).

      if lv_max_his_id is initial.
        ls_incident_history-his_id = 1.
      else.
        ls_incident_history-his_id = lv_max_his_id + 1.
      endif.

      ls_incident_history-new_status = lv_status.
      ls_incident_history-text = lv_text.

      try.
          ls_incident_history-inc_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        catch cx_uuid_error into data(lo_error).
          lv_exception = lo_error->get_text(  ).
      endtry.

      if ls_incident_history-his_id is not initial.
*
        append value #( %tky = <incident>-%tky
                        %target = value #( (  HisUUID = ls_incident_history-inc_uuid
                                              IncUUID = <incident>-IncUUID
                                              HisID = ls_incident_history-his_id
                                              PreviousStatus = <incident>-Status
                                              NewStatus = ls_incident_history-new_status
                                              Text = ls_incident_history-text ) )
                                               ) to lt_association_entity.
      endif.
    endloop.
    unassign <incident>.

** The process is interrupted because a change of status from pending (PE) to Completed (CO) or Closed (CL) is not permitted.
    check lv_error is initial.

** Modify status in Root Entity
    modify entities of z_r_incidents_fjcm in local mode
    entity Incidents
    update  fields ( ChangedDate
                     Status )
    with lt_updated_root_entity.

    free incidents. " Free entries in incidents

    modify entities of z_r_incidents_fjcm in local mode
     entity Incidents
     create by \_History fields ( HisUUID
                                  IncUUID
                                  HisID
                                  PreviousStatus
                                  NewStatus
                                  Text )
        auto fill cid
        with lt_association_entity
     mapped mapped
     failed failed
     reported reported.

** Read root entity entries updated
    read entities of z_r_incidents_fjcm in local mode
    entity Incidents
    all fields with corresponding #( keys )
    result incidents
    failed failed.

** Update User Interface
    result = value #( for incident in incidents ( %tky = incident-%tky
                                                  %param = incident ) ).
  endmethod.

  method setDefaultHistory.
** Execute internal action to update Flight Date
    modify entities of z_r_incidents_fjcm in local mode
    entity Incidents
    execute setHistory
       from corresponding #( keys ).
  endmethod.

  method get_history_index.
** Fill history data
    select from zdt_inct_h_fjcm
      fields max( his_id ) as max_his_id
      where inc_uuid eq @ev_incuuid and
            his_uuid is not null
      into @rv_index.
  endmethod.

  method setHistory.
** Declaration of necessary variables
    data: lt_updated_root_entity type table for update z_r_incidents_fjcm,
          lt_association_entity  type table for create z_r_incidents_fjcm\_History,
          lv_exception           type string,
          ls_incident_history    type zdt_inct_h_fjcm,
          lv_max_his_id          type zdt_inct_h_fjcm-his_id.

** Iterate through the keys records to get parameters for validations
    read entities of z_r_incidents_fjcm in local mode
         entity Incidents
         all fields with corresponding #( keys )
         result data(incidents).

** Get parameters
    loop at incidents assigning field-symbol(<incident>).
      lv_max_his_id = get_history_index( importing ev_incuuid = <incident>-IncUUID ).

      if lv_max_his_id is initial.
        ls_incident_history-his_id = 1.
      else.
        ls_incident_history-his_id = lv_max_his_id + 1.
      endif.

      try.
          ls_incident_history-inc_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        catch cx_uuid_error into data(lo_error).
          lv_exception = lo_error->get_text(  ).
      endtry.

      if ls_incident_history-his_id is not initial.
        append value #( %tky = <incident>-%tky
                        %target = value #( (  HisUUID = ls_incident_history-inc_uuid
                                              IncUUID = <incident>-IncUUID
                                              HisID = ls_incident_history-his_id
                                              NewStatus = <incident>-Status
                                              Text = 'First Incident' ) )
                                               ) to lt_association_entity.
      endif.
    endloop.
    unassign <incident>.

    free incidents. " Free entries in incidents

    modify entities of z_r_incidents_fjcm in local mode
     entity Incidents
     create by \_History fields ( HisUUID
                                  IncUUID
                                  HisID
                                  PreviousStatus
                                  NewStatus
                                  Text )
        auto fill cid
        with lt_association_entity.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method get_instance_authorizations.
  endmethod.

endclass.
