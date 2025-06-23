@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 03 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_FLIGHT_HIERA_FJCM
  as select from /dmo/travel as Travel
  association [1..1] to ZCDS_FLIGHT_HIERA_FJCM as _Agency on _Agency.Agency_Id = $projection.Agency_Id and
                                                  _Agency.Customer_ID = $projection.Customer_ID
{
  key Travel.agency_id   as Agency_Id,
      Travel.customer_id as Customer_ID,
      _Agency
}
