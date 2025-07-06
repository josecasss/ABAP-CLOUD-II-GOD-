class zcl_lab_11_system_fjcm definition
  public
"  FINAL
  create public .

  public section.
    data: architecture type string value '64bits'.

    methods: get_architecture returning value(ev_architecture) type string.


  protected section.
  private section.
endclass.



class zcl_lab_11_system_fjcm implementation.
  method get_architecture.
    ev_architecture = me->architecture.
  endmethod.

endclass.
