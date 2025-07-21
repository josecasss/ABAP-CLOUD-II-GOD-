class zcl_lab_27_factory_fjcm definition abstract
  public
"  FINAL
  create public .

  public section.

    methods: merchandise_output returning value(rv_merchandise_output) type string,
          production_line abstract returning value(rv_production_line) type string,
            input_products abstract returning value(rv_input_products) type string.

  protected section.
  private section.
endclass.



class zcl_lab_27_factory_fjcm implementation.

  method merchandise_output.
    rv_merchandise_output = 'merchandise_output' .
  endmethod.

endclass.
