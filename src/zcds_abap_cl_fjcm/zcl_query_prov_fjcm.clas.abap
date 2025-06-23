class zcl_query_prov_fjcm definition
  public
  final
  create public .

  public section.
    interfaces if_rap_query_provider . "Interface for RAP Query Provider del cds custom
  protected section.
  private section.
endclass.



class zcl_query_prov_fjcm implementation.

  method if_rap_query_provider~select.  " Method to handle the select operation for RAP Query Provider

    data lt_results type table of zi_cds_20_fjcm.

    try.

        if io_request->is_data_requested( ).

          data(lv_top) = io_request->get_paging( )->get_page_size( ).
          data(lv_skip) = io_request->get_paging( )->get_offset( ).

          select from /dmo/travel
                 fields travel_id, agency_id, customer_id
                 order by travel_id ascending
                 into table @lt_results
                 offset @lv_skip       " Skipping the first @lv_skip rows
                 up to @lv_top rows.   " Limiting the number of rows returned

          if sy-subrc = 0.
            io_response->set_total_number_of_records( lines( lt_results ) ).
            io_response->set_data( lt_results ).

          endif.

        endif.

      catch cx_rap_query_response_set_twic into data(lx_exc).

    endtry.



  endmethod.

endclass.
