@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Definición de Vistas CDS Básicas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDATA_MODELING_FJCM
  as select from /dmo/customer
{
  key customer_id as CustomerId,
      first_name           as FirstName,
      last_name            as LastName,
      $session.client      as ClientField,
      $session.system_date as SystemDate,
      cast( customer_id as abap.int8 ) as CustomerId_fjcm,
      country_code          as CountryCode,
      
      case country_code
        when 'US' then 'United States of America'
        when 'DE' then 'Germany'
        else 'Other Country'
      end as CountryName
}
