@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flexible Exchange USD '
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSALES_CONVERTED_USER
  with parameters
    pTargetCurrency : abap.cuky //Parametros flexibles para la moneda deseada en este caso USD
  as select from /dmo/booking
{
  key travel_id as TravelId,
  key booking_id as BookingId,
  
  currency_code               as CurrencyCode,

  @Semantics.amount.currencyCode: 'CurrencyCode'
  flight_price                as OriginalPrice,

  @Semantics.amount.currencyCode: 'TargetCurrency'
  currency_conversion(
    amount             => flight_price,
    source_currency    => currency_code,              // ← Usa la moneda real del registro
    target_currency    => $parameters.pTargetCurrency, // ← Parámetro flexible
    exchange_rate_date => $session.system_date,
    client             => $session.client,
    error_handling     => 'SET_TO_NULL'
  )                           as FlightPriceUsd,

  $parameters.pTargetCurrency as TargetCurrency
}
