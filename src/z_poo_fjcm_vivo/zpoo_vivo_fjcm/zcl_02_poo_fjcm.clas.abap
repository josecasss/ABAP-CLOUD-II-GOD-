class zcl_02_poo_fjcm definition
  public
  final
  create public .

  public section.

    data: company type string read-only ."VALUE 'Logali' READ-ONLY.  "Read only no puede ser modificado desde fuera de la clase

    methods:
      constructor,

      set_attributes
        importing
                  iv_company       type string
                  iv_employee      type string optional  "Parametro opcional
        returning value(rv_string) type string.


  protected section.
  private section.

    data: employee type string.

ENDCLASS.



CLASS ZCL_02_POO_FJCM IMPLEMENTATION.


  method constructor.
    company = 'Logali'.
  endmethod.


  method set_attributes.
    me->company = iv_company.

    if iv_employee is supplied.  " Validacion de parametros .Si el parametro opcional fue provisto, entonces
      me->employee = iv_employee.
      rv_string = |{ me->company }-{ me->employee }|.
    else.
      rv_string = |{ me->company }|.
    endif.

  endmethod.
ENDCLASS.
