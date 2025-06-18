@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text Category'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MASTER
}
@ObjectModel.resultSet.sizeCategory: #XS // 
define view entity zi_cds_11_fjcm
  as select from /dmo/oall_stat_t
{
     @ObjectModel.text.element: ['Text'] // Elemento de texto       
  key overall_status as OverallStatus,
      @Semantics.language: true          // 
  key language       as Language,
      @Semantics.text: true
      text           as Text
}
