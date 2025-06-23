@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_PUBLIC_ASSOC_FJCM
  as select from /dmo/travel as Travel
  association [1..1] to ZCDS_AGENCY_MAX as _AgencyMax on _AgencyMax.AgencyId = $projection.Agency_id
{
  key Travel.agency_id as Agency_id,
  key Travel.travel_id as Travel_id,
      _AgencyMax
}
