class zcl_07_poo_fjcm definition
  public
  create public .

  public section.
    methods:
      walk returning value(rv_walk) type string.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_07_POO_FJCM IMPLEMENTATION.


  method walk.
    rv_walk = 'The animal walks'.
  endmethod.
ENDCLASS.
