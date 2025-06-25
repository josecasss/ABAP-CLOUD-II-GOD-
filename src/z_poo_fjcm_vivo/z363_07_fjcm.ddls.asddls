@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Amount Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z363_07_fjcm
  with parameters
    pFromCurrency : abap.cuky, //Parameter to convert from a currency
    pToCurrency   : abap.cuky  //Parameter to convert the currency

  as select from /dmo/travel
{
  key travel_id                                                  as TravelId,
      @Semantics.amount.currencyCode: 'OriginalCurrency'
      total_price                                                as OriginalPrice,
      currency_code                                              as OriginalCurrency,
      @Semantics.amount.currencyCode: 'ConvertedCurrency'
      currency_conversion( amount             => total_price, // Column of the original price from the source
                           source_currency    => $parameters.pFromCurrency,
                           target_currency    => $parameters.pToCurrency,
                           exchange_rate_date => begin_date, // Column of the exchange rate date from the source to set the conversion date
                           error_handling     => 'SET_TO_NULL'  ) as ConvertedPrice,   //Columna del precio convertido  "Set to null error handling, if the conversion fails set to null
      $parameters.pToCurrency                                    as ConvertedCurrency //Columna de la moneda convertida

}
where
  currency_code = $parameters.pFromCurrency; // Filter the source data based on the parameter pFromCurrency
