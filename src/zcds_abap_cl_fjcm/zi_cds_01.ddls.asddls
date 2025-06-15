@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS -Travel'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@objectModel: [  'AirlineID', 'ConnectionID', 'FlightDate' ]
define view entity zi_cds_01
  as select from /dmo/flight
{
  key carrier_id    as AirlineID,
  key connection_id as ConnectionID,
  key flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'Currency' // This annotation indicates that the field is a currency amount
      @EndUserText.label: 'Price'                // This annotation provides a label for the field
      price         as Price,
      currency_code as Currency,


      'USD'         as CurrencyDocument, // This is a constant value for the currency, which can be used in calculations or display purposes
      '20300101' as DateString,
      cast( '20300101' as abap.dats ) as DateDate, // Cast convierte el valor numérico a un tipo de fecha 
      
      1.2 as floatingPointElement,
      
      fltp_to_dec(1.2 as abap.dec( 4, 2 )) as DecimalElement, // Convertir un número decimal a un tipo de dato decimal ABAP
      
      cast( cast( 'E' as abap.lang) as sylangu preserving type ) as LanguageElement // Cast convierte el valor de tipo cadena a un tipo de lenguaje ABAP

}
