interface zif_lab_01_flight_fjcm
  public .
  data: conn_id type string.
  class-data: comp_id type string.

  methods: set_conn_id importing value(iv_set_connid) type string,
           get_conn_id returning value(rv_get_connid) type string.

  interfaces: zif_lab_03_airports_fjcm.

endinterface.
