class lhc_Travel definition inheriting from cl_abap_behavior_handler.
  private section.

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

  method get_instance_features.
  endmethod.

  method get_instance_authorizations.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method acceptTravel.
  endmethod.

  method deductDiscount.
  endmethod.

  method reCalcTotalPrice.
  endmethod.

  method rejectTravel.
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
