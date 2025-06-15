@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_05_fjcm
  as select from /dmo/travel
{
  key travel_id as TravelID,
  cast('' as abap.numc(4)) as BookingID // Campo ficticio para la union y hacer cast para coincidir con el tipo de BookingID
}

union select distinct from /dmo/booking // Union de tablas *Para la projeccion Tienen que tener el mismo número de columnas, nombres y tipos de datos
                                        // Select distinct para evitar duplicados
{
  key travel_id  as TravelID,
      booking_id as BookingID
}


//Resolver problemas de union de las fuentes
