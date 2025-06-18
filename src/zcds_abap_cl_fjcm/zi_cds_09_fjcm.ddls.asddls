@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Quantity Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_09_fjcm
  with parameters
    pFromUnit : abap.unit(3),
    PToUnit   : abap.unit(3)
  as select from zqty_fjcm
{
  key product                                   as Product,
      @Semantics.quantity.unitOfMeasure : 'OriginalUnit' // Anotacion de referencia a la unidad de medida original
      quantity                                  as OriginalQuantity,
      unit                                      as OriginalUnit,

      @Semantics.quantity.unitOfMeasure : 'ConvertedUnit'
      unit_conversion( quantity => quantity,        //Usar campos de nombres sin alias
                    source_unit => $parameters.pFromUnit,
                    target_unit => $parameters.PToUnit ,
                    error_handling => 'SET_TO_NULL',
                    client => $session.client ) as ConvertedQuantity,
      $parameters.PToUnit                       as ConvertedUnit

} where unit = $parameters.pFromUnit; // Condición para filtrar por unidad de origen

