class zcl_lab_20_person_fjcm definition
  public
"  CREATE PRIVATE. "Solo la misma clase puede crear instancias
create public.
  public section.
  protected section.

    data: name type string.

    methods: set_name final importing iv_name type string.

  private section.
endclass.

class zcl_lab_20_person_fjcm implementation.
  method set_name.

  endmethod.

endclass.
