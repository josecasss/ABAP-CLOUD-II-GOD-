@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Case'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #C,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_01_fjcm
  as select from /dmo/customer
{
  key customer_id as CustomerId,
      first_name  as FirstName,
      last_name   as LastName,
      title       as Title,
      street      as Street,

      case country_code // Tienen que ser el mismo tipo en cada salida del case
           when 'US' then concat( 'United States of America -', concat(first_name, last_name) ) //Funcion concatenar,
           when 'DE' then concat( 'Germany -', first_name)
           when 'ES' then case title
                          when 'Mr.'  then concat( 'Spain - Mr.', first_name)
                          when 'Mrs.' then concat( 'Spain - Mrs.', first_name)
                          else 'ES- Different Title - '
                          end
           else 'Other Country Code'
           end    as ElementCase // Nombre del campo del case

}
