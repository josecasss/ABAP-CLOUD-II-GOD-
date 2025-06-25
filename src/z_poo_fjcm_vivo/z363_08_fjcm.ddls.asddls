@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quantity Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z363_08_fjcm
  with parameters
    pFromUnit : abap.unit(3),
    pToUnit   : abap.unit(3)
  as select from zqty_lgl
{
  key product                                      as Product,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity                                     as Quantity,
      unit                                         as Unit,
      @Semantics.quantity.unitOfMeasure: 'ConvertedUnit'
      unit_conversion( quantity    => quantity,
                       source_unit => $parameters.pFromUnit,
                       target_unit => $parameters.pToUnit,
                       error_handling => 'SET_TO_NULL',
                       client => $session.client ) as ConvertedQty,
      $parameters.pToUnit                          as ConvertedUnit
}
where
  unit = $parameters.pFromUnit;
