class zcl_lab_15_flight_price_fjcm definition
  public
"  FINAL
  create public .
  public section.

    data: mt_flights type table of /dmo/flight.
    methods: add_price importing value(iv_add_price) type /dmo/flight.

  protected section.
  private section.
endclass.

class zcl_lab_15_flight_price_fjcm implementation.

  method add_price.
    append iv_add_price to me->mt_flights.
  endmethod.

endclass.
