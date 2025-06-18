@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Amount Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_08_fjcm
  with parameters
    pFromCurrency : abap.cuky, // Parametros de entrada
    PToCurrency   : abap.cuky  // Parametros de entrada

  as select from /dmo/travel
{
  key travel_id                                                    as TravelID,
      @Semantics.amount.currencyCode: 'OriginalCurrency'
      total_price                                                  as OriginalPrice,
      currency_code                                                as OriginalCurrency,
      @Semantics.amount.currencyCode: 'ConvertedCurrency'
      currency_conversion(  amount             => total_price, // Funcion para convertir moneda
                            source_currency    => $parameters.pFromCurrency, // Parametros de entrada
                            target_currency    => $parameters.PToCurrency,  // Convertir a USD "Otra notacion para el cast
                            exchange_rate_date => begin_date,
                            client             => $session.client,
                            error_handling      => 'SET_TO_NULL' ) as ConvertedPrice,
      $parameters.PToCurrency                                      as ConvertedCurrency
}
where
  currency_code = $parameters.pFromCurrency
