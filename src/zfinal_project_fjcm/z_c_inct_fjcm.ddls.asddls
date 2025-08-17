@Metadata.allowExtensions: true
@EndUserText.label: 'Incidents - Consumption Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity z_c_inct_fjcm
  provider contract transactional_query
  as projection on z_r_incidents_fjcm
{
  key IncUUID,
      IncidentID,
      Title,
      Description,
      Status,
      Priority,
      CreationDate,
      ChangedDate,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _History : redirected to composition child Z_C_INCT_H_FJCM //Redirected composition association to the child entity
}
