class zcl_22_poo_fjcm definition
  public
  final
  create public .

  public section.
    methods:
      set_credit_card importing io_credit_card type ref to zcl_21_poo_fjcm,         "Se hacen assoaciones mediante referencia entre clases
      get_credit_card returning value(ro_credit_card) type ref to zcl_21_poo_fjcm.
  protected section.
  private section.
    data: credit_card type ref to zcl_21_poo_fjcm.

ENDCLASS.



CLASS ZCL_22_POO_FJCM IMPLEMENTATION.


  method get_credit_card.
    ro_credit_card = me->credit_card.
  endmethod.


  method set_credit_card.
    me->credit_card = io_credit_card.
  endmethod.
ENDCLASS.
