@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity z_dd_inct_h_fjcm
  as select from zdt_inct_h_fjcm
  association to parent z_r_incidents_fjcm as _Incidents on $projection.IncUUID = _Incidents.IncUUID // Association to Incident
{
  key his_uuid              as HisUUID,
  key inc_uuid              as IncUUID,
      his_id                as HisID,
      previous_status       as PreviousStatus,
      new_status            as NewStatus,
      text                  as Text,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      //  Associations
      _Incidents
}
