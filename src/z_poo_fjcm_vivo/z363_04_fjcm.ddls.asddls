@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//Mismo numero de elementos,alias, tipos de campos en las fuentes y misma cantidad de claves. 

define view entity Z363_04_FJCM
  as select from /dmo/travel
{
  key travel_id                  as TravelId,
      cast('' as abap.numc( 4 )) as BookingId //Asi solucionamos el problema de que BookingId no existe en Travel, con un CAST para que coincida con el tipo de BookingId
}

union select distinct from /dmo/booking // Union with Booking *Union distinct: "Combina resultados de dos o más consultas y elimina duplicados.

{
  key travel_id  as TravelId,
      booking_id as BookingId
}
