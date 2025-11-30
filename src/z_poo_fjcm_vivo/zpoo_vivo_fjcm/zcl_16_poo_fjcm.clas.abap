class zcl_16_poo_fjcm definition inheriting from zcl_15_poo_fjcm
  public
  final
  create public .

  public section.
    methods: airplane_type redefinition.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_16_POO_FJCM IMPLEMENTATION.


  method airplane_type.
    rv_airplane_type = 'Cargo Plane'.
  endmethod.
ENDCLASS.
