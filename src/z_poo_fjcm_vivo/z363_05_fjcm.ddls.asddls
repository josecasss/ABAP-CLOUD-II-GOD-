@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aggregations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z363_05_FJCM as select from Z363_06_FJCM //Consumiendo de la otra vista CDS

{
  key travel_id,
      agency_id,
//Cuando se hacen agregaciones obligado usar GROUP BY
      @Semantics.amount.currencyCode: 'CurrencyCode'  
      min( total_price ) as MinTotalPrice,   //Agregacion
      
      @Semantics.amount.currencyCode: 'CurrencyCode' 
      max( total_price ) as MaxTotalPrice,   //Agregacion
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      sum( total_price ) as SumTotalPrice,   //Agregacion
      
      count( distinct total_price ) as CountDistTotalPrice, // *Distint* Solo valores unicos, no duplicados
      
      count( * ) as CountAllTotalPrice,                     // (*) No distingue duplicados, cuenta todo 
         
      @Semantics.amount.currencyCode: 'CurrencyCode'
      avg( total_price as abap.dec(16,2) ) as AvgTotalPrice,   //Agregacion
      
      currency_code      as CurrencyCode
}
group by
  travel_id,
  agency_id,
  currency_code;   //Cuando se hacen agregacion obligado usar el group by
