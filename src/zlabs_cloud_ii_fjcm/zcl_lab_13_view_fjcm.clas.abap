class zcl_lab_13_view_fjcm definition
  public
"  FINAL
  create public .
  public section.

    methods: constructor importing value(iv_view_type) type string.

  protected section.
    data: view_type type string,
          box       type string.

  private section.
endclass.

class zcl_lab_13_view_fjcm implementation.
  method constructor.
    me->view_type = iv_view_type.
  endmethod.
endclass.
