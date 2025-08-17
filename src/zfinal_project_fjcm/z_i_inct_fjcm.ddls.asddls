@Metadata.allowExtensions: true
@EndUserText.label: 'Incidents - Consumption Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity Z_I_INCT_FJCM
    provider contract transactional_interface  // Contract for transactional interface RE USE
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
      _History 
}

// Interface view for reusability
