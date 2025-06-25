@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED // FOR HIERARCHY CDS
@EndUserText.label: 'CDS for Hierarchy'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z363_13_FJCM
  as select from zemployee_lgl
  association [0..1] to Z363_13_FJCM as _Manager on _Manager.Employee = $projection.Manager // 0..1 Some employees may not have a manager
{
  key employee as Employee,
      manager  as Manager,
      name     as Name,
      _Manager
}

//Asociation for Hierarchy with the same table to see the manager of the employee
