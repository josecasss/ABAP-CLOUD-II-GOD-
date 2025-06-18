@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 01 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZUNIT_CONVERSION_FJCM
  as select from /dmo/fsa_root_a
{
  key id                                          as Id,
      string_property                             as StringProperty,
      uom                                         as Uom,
      @Semantics.quantity.unitOfMeasure : 'Uom'
      field_with_quantity                         as OriginalQuantity,
      @Semantics.quantity.unitOfMeasure : 'ConvertedUnit'
      unit_conversion( quantity    => field_with_quantity,
                       source_unit => cast('KG' as abap.unit),
                       target_unit => cast('G' as abap.unit),
                       error_handling => 'SET_TO_NULL',
                       client => $session.client) as ConvertedQuantity,
      cast('G' as abap.unit)                      as ConvertedUnit
}

//Probe de A-W, pero parece que la unidad W no esta definido en el sistema
