class zcl_10_poo_fjcm definition
  public

  create public .

  public section.
    methods:
      change_dapartment.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_10_POO_FJCM IMPLEMENTATION.


  method change_dapartment.
    data(lo_friend) = new zcl_09_poo_fjcm( ).

    lo_friend->departemnt = 'Manufacturing'.    "Acceso a los de la seccion privada
  endmethod.
ENDCLASS.
