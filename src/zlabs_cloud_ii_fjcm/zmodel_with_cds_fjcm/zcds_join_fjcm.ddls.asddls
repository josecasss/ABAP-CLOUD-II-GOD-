@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_JOIN_FJCM
  as select from /dmo/booking as booking
    inner join   /dmo/flight  as flight on  booking.carrier_id    = flight.carrier_id
                                        and booking.connection_id = flight.connection_id
                                        and booking.flight_date   = flight.flight_date
{

  key booking.booking_id   as BookingId,
  key flight.flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight.price         as Price,
      flight.currency_code as CurrencyCode

}
