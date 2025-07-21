class zcl_lab_25_collaborator_fjcm definition inheriting from zcl_lab_24_partner_fjcm
  public
  final
  create public .

  public section.

    methods: get_capital returning value(rv_capital) type string.

  protected section.
  private section.
endclass.

class zcl_lab_25_collaborator_fjcm implementation.

  method get_capital.

    data(lo_capital) = new zcl_lab_23_company_fjcm( ).

    rv_capital = lo_capital->capital.

  endmethod.

endclass.
