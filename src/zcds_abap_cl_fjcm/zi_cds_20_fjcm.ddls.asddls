@EndUserText.label: 'Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_QUERY_PROV_FJCM'
define custom entity ZI_CDS_20_FJCM //Tabla customizada para el CDS, viene de un select from a CDS view

{
  key travel_id   : /dmo/travel_id;
      agency_id   : /dmo/agency_id;
      customer_id : /dmo/customer_id;
}
