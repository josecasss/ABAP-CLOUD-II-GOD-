class zcl_lab_17_super_discount_fjcm definition inheriting from zcl_lab_15_flight_price_fjcm
  public
  final
  create public .

  public section.
    methods: add_price redefinition.
  protected section.
  private section.
endclass.

class zcl_lab_17_super_discount_fjcm implementation.

  method add_price.
    data(ls_super_discounted) = iv_add_price.
    ls_super_discounted-price *= '0.80'.
    mt_flights = value #( base mt_flights ( ls_super_discounted ) ).
  endmethod.

endclass.
