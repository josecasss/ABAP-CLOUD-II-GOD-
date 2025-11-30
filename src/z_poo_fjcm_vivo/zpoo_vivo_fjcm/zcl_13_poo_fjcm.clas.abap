class zcl_13_poo_fjcm definition abstract   "Clase Abstracta
  public
*  FINAL
  create public .

  public section.

    methods:
      merchandise_output abstract                     "Metodo abstracto para que las clases hijas lo redefinan
        returning value(rv_merchandise) type string,

      production_line  abstract
        returning value(rv_production) type string,

      input_products
        returning value(rv_input) type string.

  protected section.
  private section.
ENDCLASS.



CLASS ZCL_13_POO_FJCM IMPLEMENTATION.


  method input_products.
    rv_input = 'Input products'.
  endmethod.
ENDCLASS.
