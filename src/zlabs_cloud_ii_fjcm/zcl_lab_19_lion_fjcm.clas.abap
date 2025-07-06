class zcl_lab_19_lion_fjcm definition inheriting from zcl_lab_18_animal_fjcm
  public
  final
  create public .
  public section.

    methods: walk redefinition.

  protected section.
  private section.
endclass.

class zcl_lab_19_lion_fjcm implementation.

  method walk.
    rv_walk = 'The lion walks'.
  endmethod.

endclass.
