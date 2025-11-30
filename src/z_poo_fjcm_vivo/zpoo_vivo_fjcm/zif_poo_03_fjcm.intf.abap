interface zif_poo_03_fjcm
  public .

  methods:
    get_airports
      importing
                iv_airport_id     type string
      returning value(rs_airport) type /dmo/airport.

endinterface.
