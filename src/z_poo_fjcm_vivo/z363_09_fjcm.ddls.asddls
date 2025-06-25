@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Join'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z363_09_fjcm
  as select from /dmo/travel  as Travel
    inner join   /dmo/booking as Booking on Booking.travel_id = Travel.travel_id  // Inner Join combine 2 columns just with coincidence values

{
  key Travel.travel_id   as TravelID,
  key Booking.booking_id as BookingID
}
