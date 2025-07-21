interface zif_lab_03_airports_fjcm
  public .

  methods: get_airports importing value(iv_airport_id)  type string
                        returning value(rt_airports_id) type /dmo/airport.

endinterface.
