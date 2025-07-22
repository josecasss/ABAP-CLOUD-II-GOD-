class zcl_virt_elem_fjcm definition
  public
  final
  create public .

  public section.
    " Implements the interface for reading virtual elements (CDS virtual elements in RAP)
    interfaces if_sadl_exit_calc_element_read.
  protected section.
  private section.
endclass.

class zcl_virt_elem_fjcm implementation.

  method if_sadl_exit_calc_element_read~get_calculation_info.

    " Check which entity is being processed (here, our RAP CDS entity)
    case iv_entity.

      when 'ZTRAVEL_C_FJCM'.

        " Loop through all requested virtual elements (fields that require calculation)
        loop at it_requested_calc_elements into data(ls_requested_calc_element).

          " If the consumer is requesting the PriceWithVAT virtual element...
          if ls_requested_calc_element = 'PRICEWITHVAT'.

            " ...inform the framework that we need the field TOTALPRICE from the original data,
            " since our calculation depends on it
            insert conv #( 'TOTALPRICE' ) into table et_requested_orig_elements.

          endif.

        endloop.

    endcase.

  endmethod.

  method if_sadl_exit_calc_element_read~calculate.

    " Prepare a local table to work with the original data (structure matches the CDS root entity)
    data: lt_original_data type standard table of ztravel_c_fjcm with default key.

    " Copy the original data into our local table, only matching fields by name
    lt_original_data = corresponding #( it_original_data ).

    " Loop over each row in the local table to calculate the virtual element
    loop at lt_original_data assigning field-symbol(<fs_orignal_data>).

      " For each record, calculate PriceWithVAT as TotalPrice * 1.21 (adds 21% VAT)
      <fs_orignal_data>-PriceWithVAT = <fs_orignal_data>-TotalPrice * '1.21'.

      " After calculation, assign the updated local table back to the output for the framework to return
      ct_calculated_data = CORRESPONDING #( lt_original_data ).

    endloop.

  endmethod.

endclass.

" This class implements the logic for calculating virtual elements in a RAP CDS entity.   *Es como un campo dinamico que se calcula en tiempo de ejecución, como un campo calculado en una base de datos relacional.*

