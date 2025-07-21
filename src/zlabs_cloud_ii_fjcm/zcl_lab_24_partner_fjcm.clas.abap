class zcl_lab_24_partner_fjcm definition
  public
"  FINAL
  create public .

  public section.

    methods: get_company_capital returning value(rv_company_capital) type string.
  protected section.
  private section.
endclass.

class zcl_lab_24_partner_fjcm implementation.

  method get_company_capital.
    data(company_capital) = new zcl_lab_23_company_fjcm( ).
    rv_company_capital = company_capital->capital.
  endmethod.
endclass.
