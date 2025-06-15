@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Case'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_cds_02
  as select from /dmo/customer
{
  key customer_id as CustomerID,
      case country_code                   // Preguntamos por el codigo del pais en el campo country_code //Tienen que ser del mismo tipo las salidas si no usar un Cast
           when 'US' then concat( 'United States', concat_with_space( last_name , first_name, 2 ) ) //Tambien se puede concatenar, solo admite 2 elementos si no usar otro concat
           when 'DE' then concat( 'United States', last_name)
           when 'ES' then concat( 'United States', last_name)
           else 'Another Country Code'
           end    as Case1,



      case
      when country_code = 'US' or country_code = 'ES' then case title                          // Mas flexibilidad , case anidado
                                                            when 'Mr.' then 'US/ES - Mr.'
                                                            when 'Mr.' then 'US/ES - Mrs.'
                                                            else 'US/ES - Different Title'
                                                            end

      when title = 'Mr.' then last_name
      when cast( '20300101' as abap.dats ) < dats_add_days ( $session.system_date, -30, 'NULL') then 'Lowe Date' // Comparacion de Fechas, mas complejo
      else 'No condition applied'
      end         as Case2
}
