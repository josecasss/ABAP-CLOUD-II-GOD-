class zcl_lab_16_price_discount_fjcm definition inheriting from zcl_lab_15_flight_price_fjcm
  public
"  FINAL
  create public .
  public section.

    methods: add_price redefinition.

  protected section.
  private section.
endclass.

class zcl_lab_16_price_discount_fjcm implementation.

  method add_price.
    data(ls_discounted) = iv_add_price.
    ls_discounted-price *= '0.90'.
    mt_flights = value #( base mt_flights ( ls_discounted ) ). " Agrega el precio con descuento
    " No llame al método padre para evitar que tambien se agrege el original precio
  endmethod.

endclass.
