@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//Mismo numeros y tipos de campos en las fuentes, misma cantidad de claves

define view entity Z363_04_FJCM
  as select from /dmo/travel
{
  key travel_id                  as TravelId,
      cast('' as abap.numc( 4 )) as BookingId //Asi solucionamos el problema de que BookingId no existe en Travel
}

union select distinct from /dmo/booking // Union with Booking

{
  key travel_id  as TravelId,
      booking_id as BookingId
}
