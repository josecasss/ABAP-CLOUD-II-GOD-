@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 Customers Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_CUSTOMER_TRAVEL_FJCM
  provider contract transactional_interface
  as projection on Z_R_CUSTOMER_TRAVEL_FJCM // Projection of the root entity Z_r_CUSTOMER_TRAVEL_FJCM

{
  key CustomerUUID,
  key CustomerID,
      Description,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      /* Associations */
      _Customer
}
