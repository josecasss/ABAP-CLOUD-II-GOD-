class zcl_21_poo_fjcm definition
  public
  final
  create public .

  public section.
    methods:
      set_card_num importing iv_card_num type string,
      get_card_num returning value(rv_card_num) type string.

  protected section.
  private section.
    data: card_num type string.

ENDCLASS.



CLASS ZCL_21_POO_FJCM IMPLEMENTATION.


  method set_card_num.
    me->card_num = iv_card_num.
  endmethod.


  method get_card_num.
    rv_card_num = me->card_num.
  endmethod.
ENDCLASS.
