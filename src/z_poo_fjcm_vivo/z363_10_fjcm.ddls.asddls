@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z363_10_fjcm

  as select from /dmo/travel as Travel

  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId   
  association [1..1] to /dmo/agency   as _Agency   on _Agency.agency_id = $projection.AgencyId
{
  key travel_id   as TravelId,
      agency_id   as AgencyId,
      customer_id as CustomerId,
      _Customer, //Publish association _Customer *Display all the columns of the association _Customer, in case i need just one column, use _Customer.ColumnName*
      _Agency
}

// Association Display just in case is need it to show more information 
// "ON DEMAND" Just if its need it Optimize performance by using the association   
// The association is like left outer join

// INNER JOIN: Returns only rows with matching values in both tables (intersection).
// LEFT OUTER JOIN: Returns all rows from the left table, and matching rows from the right table if available; non-matching right-side columns are set to NULL.      
