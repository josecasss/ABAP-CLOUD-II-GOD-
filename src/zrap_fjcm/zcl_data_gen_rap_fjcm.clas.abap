class zcl_data_gen_rap_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_data_gen_rap_fjcm implementation.


  method if_oo_adt_classrun~main.
*Never use Delete is *DANGEROUS* in production code, this is just for testing purposes
    delete from ztravel_fjcm.               " Start with deleting existing entries even if the table is empty
    delete from ztravel_fjcmd.              " To dont have duplicates in the data generation

    insert ztravel_fjcm from (
               select from /dmo/travel
               fields uuid(  ) as travel_uuid, " Function to obtain the UUID
                      travel_id,
                      agency_id,
                      customer_id,
                      begin_date,
                      end_date,
                      booking_fee,
                      total_price,
                      currency_code,
                      description,
                      case status
                        when 'B' then 'A'  " BOOKED to ACTIVE
                        when 'P' then 'O'  " PENDING to OPEN
                        when 'N' then 'O'  " NEW to OPEN
                        else 'X'
                        end as overall_status,
                      createdby     as local_created_by,
                      createdat as aslocal_created_at,
                      lastchangedby as local_last_changed_by,
                      lastchangedat as local_last_changed_at
                            ).



  endmethod.
endclass.
