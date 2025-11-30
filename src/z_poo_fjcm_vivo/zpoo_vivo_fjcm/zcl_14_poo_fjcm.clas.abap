class zcl_14_poo_fjcm definition inheriting from zcl_13_poo_fjcm  "Heredando de clase abstracta y por ende todos sus metodos obligatoriamente
  public
  final
  create public .

  public section.
    methods:
      merchandise_output redefinition,
      production_line redefinition.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_14_POO_FJCM IMPLEMENTATION.


  method merchandise_output.
    rv_merchandise = 'Merchandise output'.
  endmethod.


  method production_line.
    rv_production = 'Production line'.
  endmethod.
ENDCLASS.
