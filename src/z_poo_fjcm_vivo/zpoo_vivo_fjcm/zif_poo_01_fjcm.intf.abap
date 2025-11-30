interface zif_poo_01_fjcm
  public.


  class-data: comp_id type string.

  data: conn_id type string.

  methods:
    set_conn_id
      importing
        iv_conn_id type string,

    get_conn_id
      returning value(rv_conn_id) type string.

endinterface.
