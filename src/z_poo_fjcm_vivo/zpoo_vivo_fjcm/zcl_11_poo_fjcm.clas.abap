class zcl_11_poo_fjcm definition inheriting from zcl_10_poo_fjcm  " Heredando de la clase a la cual se le hizo amiga
  public
  final
  create public .

  public section.
    methods:
      get_department.
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_11_POO_FJCM IMPLEMENTATION.


  method get_department.
    data(lo_friend) = new zcl_09_poo_fjcm( ).

    lo_friend->departemnt = 'Human Resources'.  "Accediendo al atributo privado de la clase amiga (La clases que heredan de la amiga tambien pueden acceder a sus atributos privados)

  endmethod.
ENDCLASS.
