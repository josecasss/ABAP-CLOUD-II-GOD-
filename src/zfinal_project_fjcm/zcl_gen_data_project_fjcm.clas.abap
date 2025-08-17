class zcl_gen_data_project_fjcm definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
    interfaces zif_gen_data_ii_fjcm.

    " To Call the methods easier (:
    aliases: clean_tables for zif_gen_data_ii_fjcm~clean_tables,
             generate_priorities for zif_gen_data_ii_fjcm~generate_priorities,
             generate_statuses for zif_gen_data_ii_fjcm~generate_statuses,
             generate_incidents for zif_gen_data_ii_fjcm~generate_incidents.

  private section.

    methods: get_default_priorities exporting et_priorities type zif_gen_data_ii_fjcm~tt_priority,
             get_default_statuses exporting et_statuses type zif_gen_data_ii_fjcm~tt_status,
             get_default_incidents exporting et_incidents type zif_gen_data_ii_fjcm~tt_incident.

endclass.

class zcl_gen_data_project_fjcm implementation.

  method clean_tables. " Deletes all data from persistence tables

    delete from zdt_inct_h_fjcm.
    delete from zdt_inct_fjcm.
    delete from zdt_status_fjcm.
    delete from zdt_priority_fjc.

    out->write( |All persistence tables have been cleared.| ).

  endmethod.

  method generate_priorities. "Generates data for incident priorities *CATALOG*

    insert zdt_priority_fjc from table @it_priorities.

    if sy-subrc = 0.
      out->write( |Priorities inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( 'Error inserting priority Catalog' ).
    endif.

  endmethod.

  method generate_statuses. "Generates reference data for incident statuses *CATALOG*

    insert zdt_status_fjcm from table @it_statuses.

    if sy-subrc = 0.
      out->write( |Statuses inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( 'Error inserting status catalog' ).
    endif.

  endmethod.

  method generate_incidents. "Generates sample incident data

    insert zdt_inct_fjcm from table @it_incidents.

    if sy-subrc = 0.
      out->write( |Incidents inserted: { sy-dbcnt } rows.| ).
    else.
      out->write( 'Error inserting incident data.' ).
    endif.

  endmethod.

  method get_default_priorities.

    et_priorities = value #( ( priority_code = 'H' priority_description = 'High' )
                             ( priority_code = 'M' priority_description = 'Medium' )
                             ( priority_code = 'L' priority_description = 'Low' ) ).
  endmethod.

  method get_default_statuses.

    et_statuses = value #( ( status_code = 'OP' status_description = 'Open' )
                           ( status_code = 'IP' status_description = 'In Progress' )
                           ( status_code = 'PE' status_description = 'Pending' )
                           ( status_code = 'CO' status_description = 'Completed' )
                           ( status_code = 'CL' status_description = 'Closed' )
                           ( status_code = 'CN' status_description = 'Canceled' ) ).
  endmethod.

  method get_default_incidents.

    data lv_incident_id type zdt_inct_fjcm-incident_id.

    try.
        et_incidents = value #( (   inc_uuid              = cl_system_uuid=>create_uuid_x16_static( )
                                    incident_id           = lv_incident_id + 1
                                    title                 = 'Network Outage'
                                    description           = 'Widespread network issue affecting all users.'
                                    status                = 'OP'
                                    priority              = 'H'
                                    creation_date         = cl_abap_context_info=>get_system_date( )
                                    changed_date          = cl_abap_context_info=>get_system_date( )
                                    local_created_by      = cl_abap_context_info=>get_user_technical_name( )
                                    local_last_changed_by = cl_abap_context_info=>get_user_technical_name( )
                                    last_changed_at       = cl_abap_context_info=>get_system_time( ) )

                                  ( inc_uuid              = cl_system_uuid=>create_uuid_x16_static( )
                                    incident_id           = lv_incident_id + 2
                                    title                 = 'Printer not working'
                                    description           = 'Assistant cannot print from his workstation.'
                                    status                = 'IP'
                                    priority              = 'L'
                                    creation_date         = cl_abap_context_info=>get_system_date( )
                                    changed_date          = cl_abap_context_info=>get_system_date( )
                                    local_created_by      = cl_abap_context_info=>get_user_technical_name( )
                                    local_last_changed_by = cl_abap_context_info=>get_user_technical_name( )
                                    last_changed_at       = cl_abap_context_info=>get_system_time( ) ) ).

      catch cx_uuid_error.
        " handle exception
        clear et_incidents.
    endtry.

  endmethod.

  method if_oo_adt_classrun~main.

    data: lt_priorities type zif_gen_data_ii_fjcm~tt_priority,
          lt_statuses   type zif_gen_data_ii_fjcm~tt_status,
          lt_incidents  type zif_gen_data_ii_fjcm~tt_incident.

    me->clean_tables( out ).

    me->get_default_priorities( importing et_priorities = lt_priorities ).
    me->generate_priorities( out = out it_priorities = lt_priorities ).

    me->get_default_statuses( importing et_statuses = lt_statuses ).
    me->generate_statuses( out = out it_statuses = lt_statuses ).

    me->get_default_incidents( importing et_incidents = lt_incidents ).
    me->generate_incidents( out = out it_incidents = lt_incidents ).

  endmethod.

endclass.
