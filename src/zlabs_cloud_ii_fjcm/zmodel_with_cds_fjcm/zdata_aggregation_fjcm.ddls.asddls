@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 01 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDATA_AGGREGATION_FJCM
  as select from /dmo/booking
{
  currency_code                               as CurrencyCode,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  sum( cast(flight_price as abap.dec(16,2)) ) as SumFlightsPrice
}
group by
  currency_code
