class zcl_lab_26_flights_fjcm definition
  public
  final
  create public .

  public section.

    interfaces: zif_lab_01_flight_fjcm,
      zif_lab_02_customer_fjcm.

    aliases: get_conn_id for zif_lab_01_flight_fjcm~get_conn_id,
             set_conn_id for zif_lab_01_flight_fjcm~set_conn_id,
             get_customer for zif_lab_02_customer_fjcm~get_customer,
             get_airports for zif_lab_03_airports_fjcm~get_airports.

  protected section.
  private section.
endclass.

class zcl_lab_26_flights_fjcm implementation.

  method zif_lab_01_flight_fjcm~get_conn_id.
    rv_get_connid = zif_lab_01_flight_fjcm~comp_id.
  endmethod.

  method zif_lab_01_flight_fjcm~set_conn_id.
    zif_lab_01_flight_fjcm~comp_id = iv_set_connid.
  endmethod.

  method zif_lab_02_customer_fjcm~get_customer.

    select single from /dmo/customer
      fields first_name, last_name
      where customer_id = @iv_customer_id
      into @rt_customer_address.

  endmethod.

  method zif_lab_03_airports_fjcm~get_airports.

    select single from /dmo/airport
    fields *
    where airport_id = @iv_airport_id
    into @rt_airports_id.

  endmethod.

endclass.
