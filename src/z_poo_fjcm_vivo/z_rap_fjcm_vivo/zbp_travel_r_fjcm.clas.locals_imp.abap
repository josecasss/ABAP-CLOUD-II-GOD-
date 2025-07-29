class lhc_Travel definition inheriting from cl_abap_behavior_handler.
  private section.

    constants:
      begin of travel_status,
        open     type c length 1 value 'O', " Open
        accepted type c length 1 value 'A', " Accepted
        rejected type c length 1 value 'X', " Rejected
      end of travel_status.

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

    methods reCalcTotalPrice for modify
      importing keys for action Travel~reCalcTotalPrice.

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

  method get_instance_features.  "

    read entities of ztravel_r_fjcm in local mode
    entity Travel
    fields ( OverallStatus )
    with corresponding #( keys )
    result data(travels)
    failed failed.

    result = value #( for travel in travels (
                                    %tky = travel-%tky
                                    %field-BookingFee = cond #( when travel-OverallStatus = travel_status-accepted   "Travel is accepted, the BookingFee is read-only
                                                                then if_abap_behv=>fc-f-read_only
                                                                else if_abap_behv=>fc-f-unrestricted )
                                    %action-acceptTravel = cond #( when travel-OverallStatus = travel_status-accepted "travel is accepted, the action button is disabled
                                                                   then if_abap_behv=>fc-o-disabled
                                                                   else if_abap_behv=>fc-o-enabled )
                                    %action-rejectTravel = cond #( when travel-OverallStatus = travel_status-rejected "Travel is rejected, the action button is disabled
                                                                   then if_abap_behv=>fc-o-disabled
                                                                   else if_abap_behv=>fc-o-enabled )
                                    %action-deductDiscount = cond #( when travel-OverallStatus = travel_status-accepted "Travel is accepted, the action discount is disabled
                                                                     then if_abap_behv=>fc-o-disabled
                                                                     else if_abap_behv=>fc-o-enabled )
    ) ).

  endmethod.

  method get_instance_authorizations.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method acceptTravel.

    "EML - Entity Manipulation Language
    modify entities of ztravel_r_fjcm in local mode   "Root entity
    entity Travel                                     "Alias Travel was defined in the behavior definition
    update
    fields ( OverallStatus )
    with value #( for key in keys ( %tky = key-%tky
                                    OverallStatus = travel_status-accepted ) ). " Set the OverallStatus to 'A' (Accepted)

    read entities of ztravel_r_fjcm in local mode
    entity Travel
    all fields
    with corresponding #( keys )
    result data(travels).

    RESUlT = value #( for travel in travels ( %tky = travel-%tky
                                              %param = travel ) ).

  endmethod.

  method deductDiscount.
  endmethod.

  method reCalcTotalPrice.
  endmethod.

  method rejectTravel.

    "EML - Entity Manipulation Language
    modify entities of ztravel_r_fjcm in local mode
    entity Travel
    update
    fields ( OverallStatus )
    with value #( for key in keys ( %tky = key-%tky
                                    OverallStatus = travel_status-rejected ) ).

    read entities of ztravel_r_fjcm in local mode
    entity Travel
    all fields
    with corresponding #( keys )
    result data(travels).

    RESUlt = value #( for travel in travels ( %tky = travel-%tky
                                              %param = travel ) ).

  endmethod.

  method calculateTotalPrice.
  endmethod.

  method setStatusToOpen.
  endmethod.

  method setTravelNumber.
  endmethod.

  method validateAgency.
  endmethod.

  method validateCustomer.
  endmethod.

  method validateDateRange.
  endmethod.

endclass.
