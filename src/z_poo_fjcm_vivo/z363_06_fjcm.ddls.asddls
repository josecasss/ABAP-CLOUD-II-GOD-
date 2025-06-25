@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AVG - Type Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z363_06_FJCM as select from /dmo/travel
{
  key travel_id as travel_id,
      agency_id as agency_id,
      cast( total_price as abap.dec(16,2) ) as total_price, //Casteo del total price a dec
      currency_code as currency_code
    
}
