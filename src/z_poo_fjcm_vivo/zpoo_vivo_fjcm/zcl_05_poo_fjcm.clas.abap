class zcl_05_poo_fjcm definition
  public
*  FINAL
  create public.   " Aca tiene que ver el acceso a crear la instancia, si es public , protected (Misma clase e hijas) o private (Solo la misma clase o amigas)

  public section.

    methods:
      constructor,
      set_company importing iv_company        type string
                  returning value(rv_company) type string,
      get_country final.   "Este metodo no puede ser redefinido en clases hijas

    class-methods: get_instance returning value(ro_instance) type ref to zcl_05_poo_fjcm.

  protected section.
    "DATA: company TYPE string.
  private section.
    data: company type string.
ENDCLASS.



CLASS ZCL_05_POO_FJCM IMPLEMENTATION.


  method set_company.
    if me->company is initial.  "Validacion si la variable company esta vacia
      me->company = iv_company.
    endif.
    rv_company = me->company.
  endmethod.


  method constructor.
    me->company = 'Logali'.
  endmethod.


  method get_country.

  endmethod.


  method get_instance.

    ro_instance = new zcl_05_poo_fjcm( ).  "Crear una instancia de la clase

  endmethod.
ENDCLASS.
