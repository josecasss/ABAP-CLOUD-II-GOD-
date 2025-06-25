@EndUserText.label: 'Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_363_QUERY_FJCM' //Implementation class for the query with logic 
define custom entity z363_11_fjcm

{
  key travel_id   : /dmo/travel_id;
      agency_id   : /dmo/agency_id;
      customer_id : /dmo/customer_id;

}


// Its like define a structure, but with a key
// Then must be exposed in the service Odata definition
