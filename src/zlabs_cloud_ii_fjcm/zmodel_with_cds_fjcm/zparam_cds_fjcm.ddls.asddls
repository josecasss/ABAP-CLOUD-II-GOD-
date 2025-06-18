@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 01 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPARAM_CDS_FJCM 
with parameters
         pflight_date: abap.dats
         as select from /dmo/booking
     
{
 key travel_id as TravelId,
 key booking_id as BookingId,
 customer_id as CustomerId,
 $parameters.pflight_date as FlightDate
   
}
