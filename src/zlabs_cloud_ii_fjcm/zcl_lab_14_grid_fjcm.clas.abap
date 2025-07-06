class zcl_lab_14_grid_fjcm definition inheriting from zcl_lab_13_view_fjcm
  public
  final
  create public .

  public section.

    methods: constructor   importing value(iv_view_type) type string
                                     value(iv_box)       type string.

  protected section.
  private section.
endclass.

class zcl_lab_14_grid_fjcm implementation.

  method constructor.

    super->constructor( iv_view_type = iv_view_type ).
    box = iv_box.

  endmethod.

endclass.
