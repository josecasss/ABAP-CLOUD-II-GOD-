@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child Association Incident Attachments'
define view entity Z_R_ATTACHMENT_INCIDENTS_FJCM // Is not root view, but a child association 
  as select from zdt_attach_fjcm
  association to parent z_r_incidents_fjcm as _Attachment
    on $projection.IncUUID = _Attachment.IncUUID
{
  key attachment_uuid     as AttachmentUUID,
      inc_uuid           as IncUUID,
      file_name          as FileName,
      file_type          as FileType,
      file_size          as FileSize,
      mime_type          as MimeType,
      
      @Semantics.largeObject: {
        mimeType: 'MimeType',
        fileName: 'FileName',
        contentDispositionPreference: #ATTACHMENT
      }
      file_content       as FileContent,
      upload_date        as UploadDate,
      uploaded_by        as UploadedBy,
      @Semantics.user.createdBy: true
      local_created_by   as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at   as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at    as LastChangedAt,
      
      /* Association */
      _Attachment
}

