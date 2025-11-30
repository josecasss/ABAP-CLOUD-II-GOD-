class zcl_01_poo_fjcm definition
  public
  final
  create public .

  public section.                                                "Acceso desde cualquier parte del sistema

    types: begin of ty_flight,
             carrier_id    type /dmo/carrier_id,
             connection_id type /dmo/connection_id,
             flight_date   type /dmo/flight_date,
           end of ty_flight.

    constants: begin of constantes,
                 c1 type c length 6 value 'Logali',
                 c2 type c length 4 value 'Hola',
               end of constantes,

               c3 type c length 13 value 'ABAP CLOUD II'.

*    DATA: attr1 TYPE string.
*
*    CLASS-DATA: attr2 TYPE string.

    methods:
      set_attr1
        importing
          iv_attr type string,
*      get_attr1
*        EXPORTING
*          ev_attr TYPE string.
      get_attr1
        returning value(rv_attr) type string,

      get_flight
        importing iv_carrier_id    type /dmo/carrier_id
        returning value(rs_flight) type ty_flight.

    class-methods:
      set_attr2
        importing
          iv_attr type string,
      get_attr2
        exporting
          ev_attr type string.

  protected section.                                           "Acceso desde la clase y subclases(Herencia)

  private section.                                             "Acceso solo desde la clase y clase amiga(Concepto solo en ABAP)

    data: attr1 type string.

    class-data: attr2 type string.


ENDCLASS.



CLASS ZCL_01_POO_FJCM IMPLEMENTATION.


  method get_attr1.

*    ev_attr = attr1.
    rv_attr = attr1.

  endmethod.


  method get_attr2.

    ev_attr = attr2.

  endmethod.


  method get_flight.

    select single from /dmo/flight
    fields carrier_id,               "Solo los fields de mi tipo ty_flight
           connection_id,
           flight_date
     where carrier_id = @iv_carrier_id  "Where dinamico con @  HOST
      into @rs_flight.

  endmethod.


  method set_attr1.

    attr1 = iv_attr.

  endmethod.


  method set_attr2.

    attr2 = iv_attr.

  endmethod.
ENDCLASS.
