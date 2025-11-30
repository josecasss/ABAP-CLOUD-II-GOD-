class zcl_06_poo_fjcm definition inheriting from zcl_05_poo_fjcm
  public
  final
  create public .

  public section.
    methods:
      constructor,
      set_company redefinition,
      "get_country REDEFINITION,
      change_company,

      get_super_instance.

  protected section.
  private section.

    data: department type string.

ENDCLASS.



CLASS ZCL_06_POO_FJCM IMPLEMENTATION.


  method change_company.
    "me->company = 'IBM'.
  endmethod.


  method constructor.

    super->constructor( ).  "Llama al constructor de la superclase primero
    me->department = 'Finance'.

  endmethod.


  method set_company.
    rv_company = |{ super->set_company( 'IBM' ) }-{ me->department }|.  "Para metodos el super metodo da igual el orden
    super->set_company( 'IBM' ).
  endmethod.


  method get_super_instance.

  "  DATA(lo_instance) = NEW zcl_05_poo_fjcm( ).

  endmethod.
ENDCLASS.
