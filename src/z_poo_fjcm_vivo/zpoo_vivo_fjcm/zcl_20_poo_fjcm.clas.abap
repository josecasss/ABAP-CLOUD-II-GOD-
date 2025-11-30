class zcl_20_poo_fjcm definition
  public
  final
  create public .

  public section.
    methods:
      assign_company importing io_company      type ref to zif_poo_04_fjcm  "Refrencia a interface
                     returning value(rv_plant) type string.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_20_POO_FJCM IMPLEMENTATION.


  method assign_company.
    rv_plant = |PLant was assigned to...{ io_company->define_company( ) }|.
  endmethod.
ENDCLASS.
