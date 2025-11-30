CLASS zcl_priviledge_access_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRIVILEDGE_ACCESS_FJCM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM z363_20_fjcm WITH PRIVILEGED ACCESS
      FIELDS *
      INTO TABLE @DATA(lt_results)
      UP TO 50 ROWS.

    IF sy-subrc = 0.
      out->write( lt_results ).
    ELSE.
      out->write( 'No data' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
