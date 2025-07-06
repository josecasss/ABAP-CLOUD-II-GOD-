class zcl_lab_18_animal_fjcm definition
  public
"  FINAL
  create public .
  public section.

    methods: walk returning value(rv_walk) type string.

  protected section.
  private section.
endclass.

class zcl_lab_18_animal_fjcm implementation.

  method walk.
    rv_walk = 'The animal is walking'.
  endmethod.

endclass.
