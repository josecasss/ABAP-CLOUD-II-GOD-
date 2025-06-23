@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_PARAM_ASSOC_FJCM
  with parameters
    pCarrier_id : /dmo/carrier_id
  as select from /dmo/flight as Flight
  association [0..1] to /dmo/carrier as _Carrier on _Carrier.carrier_id = $projection.Carrier_id
{
  key Flight.carrier_id    as Carrier_id,
  key Flight.connection_id as Connection_id,
  key Flight.flight_date   as Flight_date,
      _Carrier.name        as Carrier_name
}
where
  carrier_id = $parameters.pCarrier_id
