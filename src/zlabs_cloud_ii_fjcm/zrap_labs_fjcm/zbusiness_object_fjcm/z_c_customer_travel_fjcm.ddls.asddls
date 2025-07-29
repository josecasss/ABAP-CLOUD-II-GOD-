@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 Customers Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true //
@Metadata.allowExtensions: true
define root view entity Z_C_CUSTOMER_TRAVEL_FJCM
provider contract transactional_query 
  as projection on Z_R_CUSTOMER_TRAVEL_FJCM
{
  key CustomerUUID,

  @Search.defaultSearchElement: true     // Default search element for the CustomerID
  @Search.fuzzinessThreshold: 0.8       // Fuzziness threshold for better search results     *Umbral 0.0 .. 1.0 to allow searchs according to exact match
  @Search.ranking: #HIGH             //  Ranking for search results
  @ObjectModel.text.element: ['CustomerName'] // Text elements for better readability
  key CustomerID,
      _Customer.LastName    as CustomerName, //Asociation to Customer Last Name
      Description,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      _Customer._Country._Text.CountryName as CustomerCountry : localized, //Association to Customer Country Code
      /* Associations */
      _Customer
}
