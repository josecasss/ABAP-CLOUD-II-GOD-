class zcl_gen_data_project_fjcm definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

    methods :
      constructor importing out type ref to if_oo_adt_classrun_out,
      clean_tables,
      generate_priorities,
      generate_statuses,
      generate_incidents.

  protected section.

  private section.

    data: out type ref to if_oo_adt_classrun_out.

endclass.


class zcl_gen_data_project_fjcm implementation.

  method constructor.

    me->out = out.

  endmethod.

  method clean_tables. " Deletes all data from persistence tables

    delete from zdt_inct_h_fjcm.
    delete from zdt_inct_fjcm.
    delete from zdt_status_fjcm.
    delete from zdt_priority_fjc.

    out->write( |All persistence tables have been cleared.| ).
  endmethod.

  method generate_priorities. "Generates reference data for incident priorities *CATALOG*

    data lt_priority type table of zdt_priority_fjc.
    lt_priority = value #( ( priority_code = 'H' priority_description = 'High' )
                           ( priority_code = 'M' priority_description = 'Medium' )
                           ( priority_code = 'L' priority_description = 'Low' ) ).

    insert zdt_priority_fjc from table @lt_priority.

    if sy-subrc eq 0.
      out->write( |Priorities inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( 'Error inserting priority Catalog' ).
    endif.
  endmethod.

  method generate_statuses. "Generates reference data for incident statuses *CATALOG*

    data lt_status type table of zdt_status_fjcm.
    lt_status = value #( ( status_code = 'OP' status_description = 'Open' )
                         ( status_code = 'IP' status_description = 'In Progress' )
                         ( status_code = 'PE' status_description = 'Pending' )
                         ( status_code = 'CO' status_description = 'Completed' )
                         ( status_code = 'CL' status_description = 'Closed' )
                         ( status_code = 'CN' status_description = 'Canceled' ) ).

    insert zdt_status_fjcm from table @lt_status.

    if sy-subrc eq 0.
      commit work.
      out->write( |Statuses inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( ' Error inserting status catalog' ).
    endif.
  endmethod.

  method generate_incidents. "Generates sample incident data

    data: lv_incident_id type zdt_inct_fjcm-incident_id,
          lt_incidents   type table of zdt_inct_fjcm.

    try.
        lt_incidents = value #(
          ( inc_uuid              = cl_system_uuid=>create_uuid_x16_static( )
            incident_id           = lv_incident_id + 1
            title                 = 'Network Outage'
            description           = 'Widespread network issue affecting all users.'
            status                = 'OP'
            priority              = 'H'
            creation_date         = cl_abap_context_info=>get_system_date( )
            changed_date          = cl_abap_context_info=>get_system_date( )
            local_created_by      = sy-uname
            local_last_changed_by = sy-uname
            last_changed_at       = cl_abap_context_info=>get_system_time( )
          )
          ( inc_uuid              = cl_system_uuid=>create_uuid_x16_static( )
            incident_id           = lv_incident_id + 2
            title                 = 'Printer not working'
            description           = 'Assitant cannot print from his workstation.'
            status                = 'IP'
            priority              = 'L'
            creation_date         = cl_abap_context_info=>get_system_date( )
            changed_date          = cl_abap_context_info=>get_system_date( )
            local_created_by      = sy-uname
            local_last_changed_by = sy-uname
            last_changed_at       = cl_abap_context_info=>get_system_time( )
          )
        ).
      catch cx_uuid_error.
        "handle exception
    endtry.

    insert zdt_inct_fjcm from table @lt_incidents.
    if sy-subrc eq 0.
      out->write( |Incidents inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( |Error inserting incident data. Check foreign key constraints.| ).
    endif.
  endmethod.

  method if_oo_adt_classrun~main.

  endmethod.

endclass.
