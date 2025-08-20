@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Incidents - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_r_incidents_fjcm
  as select from zdt_inct_fjcm
  composition [0..*] of z_dd_inct_h_fjcm as _History // Asociation Composition to history CDS Entity
  composition [0..*] of Z_R_ATTACHMENT_INCIDENTS_FJCM as _Attachments // Asociation Composition to Attachments CDS Entity
  
{
  key inc_uuid              as IncUUID,
      incident_id           as IncidentID,
      title                 as Title,
      description           as Description,
      status                as Status,
      priority              as Priority,
      creation_date         as CreationDate,
      changed_date          as ChangedDate,

      //AUDIT FIELDS
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      //LOCAL Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      //TOTAL Etag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _History, // Make association public
      _Attachments
}
