interface zif_lab_02_customer_fjcm
  public .

  types: begin of ty_cust_address,
           firstname type string,
           lastname  type string,
         end of ty_cust_address.

  methods: get_customer importing value(iv_customer_id)      type string
                        returning value(rt_customer_address) type ty_cust_address.

endinterface.
