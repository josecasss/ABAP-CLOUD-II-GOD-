class zcl_patch_express_fjcm definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_patch_express_fjcm implementation.


  method if_oo_adt_classrun~main.
  select from ZCDS_PUBLIC_ASSOC_FJCM as Travel
  fields Travel~Agency_id,
         Travel~Travel_id,
         \_AgencyMax-name as AgencyName
  where Travel~Agency_id = '070032'
  into table @DATA(lt_travel)
  up to 10 rows.

  out->write( name = 'Rows' data = lt_travel  ).

  endmethod.

endclass.
