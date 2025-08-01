@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 Customers Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_R_CUSTOMER_TRAVEL_FJCM as select from zcustomers_fjcm
association [0..1] to /DMO/I_Customer as _Customer on _Customer.CustomerID = $projection.CustomerID
{
    key customer_uuid as CustomerUUID,
    key customer_id as CustomerID,
    description as Description,
    @Semantics.user.createdBy: true
    local_created_by as LocalCreatedBy,
    @Semantics.systemDateTime.createdAt: true
    local_created_at as LocalCreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    _Customer // Make association public
}
