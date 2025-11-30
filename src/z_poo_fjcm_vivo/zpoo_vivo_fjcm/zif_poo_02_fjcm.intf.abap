interface zif_poo_02_fjcm
  public .

  types: begin of ty_cust_name,
           first_name type string,
           last_name  type string,
         end of ty_cust_name.

  methods:
    get_cust_name
      importing
                iv_cust_id          type string
      returning value(rs_cust_name) type ty_cust_name.

endinterface.
