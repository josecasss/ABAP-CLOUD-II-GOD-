@Metadata.allowExtensions: true
@EndUserText.label: 'Incidents History - Consumption Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity Z_C_INCT_H_FJCM
  as projection on z_dd_inct_h_fjcm
{
  key HisUUID,
  key IncUUID,
      HisID,
      PreviousStatus,
      NewStatus,
      Text,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Incidents : redirected to parent z_c_inct_fjcm  //Redirected association to the parent entity
}
