CLASS zcl_12_poo_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      zif_poo_01_fjcm,
      zif_poo_02_fjcm,
      zif_poo_03_fjcm.

    ALIASES:
     get_conn_id FOR zif_poo_01_fjcm~get_conn_id,
     set_conn_id FOR zif_poo_01_fjcm~set_conn_id,
     get_customer FOR zif_poo_02_fjcm~get_cust_name.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_12_POO_FJCM IMPLEMENTATION.


  METHOD get_conn_id.
    rv_conn_id = me->zif_poo_01_fjcm~conn_id.
  ENDMETHOD.


  METHOD set_conn_id.
    me->zif_poo_01_fjcm~conn_id = iv_conn_id.
  ENDMETHOD.


  METHOD get_customer.

    IF iv_cust_id = '001'.
      rs_cust_name = VALUE #( first_name = 'Juan'
                              last_name = 'Lopez' ).
    ENDIF.

  ENDMETHOD.


  METHOD zif_poo_03_fjcm~get_airports.

    SELECT SINGLE FROM /dmo/airport
    FIELDS *
    WHERE airport_id = @iv_airport_id
    INTO @rs_airport.

  ENDMETHOD.
ENDCLASS.
