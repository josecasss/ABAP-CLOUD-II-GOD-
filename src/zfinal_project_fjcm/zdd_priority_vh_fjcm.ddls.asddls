@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Incident Priorities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'PriorityCode'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@VDM.viewType: #COMPOSITE
@Search.searchable: true
define view entity zdd_priority_vh_fjcm
  as select from zdt_priority_fjc
{
      @ObjectModel.text.element:['PriorityDescription']
  key priority_code        as PriorityCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8                   // Umbral for fuzzy search
      @Semantics.text:true
      priority_description as PriorityDescription
}
