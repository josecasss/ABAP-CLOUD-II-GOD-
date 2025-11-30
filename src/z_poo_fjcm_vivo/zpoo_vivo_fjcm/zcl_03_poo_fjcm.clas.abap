class zcl_03_poo_fjcm definition
  public
  final
  create public .

  public section.

    class-data: log type string.

    methods:
      constructor.

    class-methods:
      class_constructor.

  protected section.
  private section.
ENDCLASS.



CLASS ZCL_03_POO_FJCM IMPLEMENTATION.


  method class_constructor.

    log = |Static constructor --> { log }|.

  endmethod.


  method constructor.

    log = |Instance constructor --> { log }|.

  endmethod.
ENDCLASS.
