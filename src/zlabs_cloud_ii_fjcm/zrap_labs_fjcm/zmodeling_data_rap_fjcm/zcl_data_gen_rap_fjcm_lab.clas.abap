class zcl_data_gen_rap_fjcm_lab definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_data_gen_rap_fjcm_lab implementation.


  method if_oo_adt_classrun~main.

    delete from zcustomers_fjcm.
    delete from zcustomers_d_fjc.

    insert zcustomers_fjcm from (
    select from /dmo/travel
    fields uuid( ) as customer_uuid,  "Function to obtain uuid
                      customer_id,
                      description,
                      createdby     as local_created_by,  " Mapping 'createdby' from /dmo/travel to 'local_created_by' in zcustomers_fjcm
                      createdat     as aslocal_created_at,
                      lastchangedby as local_last_changed_by,
                      lastchangedat as local_last_changed_at
                      where customer_id between 1 and 2000 ).

    if sy-subrc eq 0.
      out->write( |Travel.... { sy-dbcnt } rows inserted | ).
    endif.



  endmethod.
endclass.
