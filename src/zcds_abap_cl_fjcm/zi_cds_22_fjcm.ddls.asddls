@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Hierarchy'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CDS_22_FJCM
  as select from zemployee_lgl
  association [0..1] to ZI_CDS_22_FJCM as _Manager on _Manager.Employee = $projection.Manager //Asociacion con la misma CDS 
{
  key employee as Employee,
      manager  as Manager,
      name     as Name,
      _Manager
}
