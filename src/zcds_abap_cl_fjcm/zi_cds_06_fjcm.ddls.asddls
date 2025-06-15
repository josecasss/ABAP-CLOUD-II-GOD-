@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aggregations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_06_fjcm
  as select from zi_cds_07_fjcm  // Consumimos de la vista zi_cds_07_fjcm donde ya manejamos el cast avg
{
//  key travel_id                   as TravelID,
//      agency_id                   as AgencyID,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      min(total_price)            as MinTotalPrice,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      max(total_price)            as MaxTotalPrice,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      sum(total_price)            as SumTotalPrice,
      count(distinct total_price) as CountDistTotalPrice,
      count(* )                   as CountAllTotalPrice,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      avg( total_price as abap.dec(16,2)) as AvgTotalPrice,



      currency_code               as CurrencyCode
}
group by
//  travel_id, //Usar nombres de campo en vez de alias
//  agency_id,
  currency_code;
