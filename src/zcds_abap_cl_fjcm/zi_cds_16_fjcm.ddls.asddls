@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association Filter with path expresions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_16_fjcm
  as select from /dmo/travel
  association [0..*] to I_CurrencyText as _Currency on _Currency.Currency = $projection.Currency
//                                                   and _Currency.Language = $session.system_language
{
  key travel_id     as TravelId,
      agency_id     as AgencyId,
      @Semantics.amount.currencyCode: 'Currency'
      total_price   as TotalPrice,
      currency_code as Currency,
      _Currency[Language = $session.system_language ].CurrencyName
}
