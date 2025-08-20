@Metadata.allowExtensions: true
@EndUserText.label: 'Attachments - Consumption Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true

define view entity Z_C_ATTACHMENT_INCIDENTS_FJCM
  as projection on Z_R_ATTACHMENT_INCIDENTS_FJCM  // Is not root view, but a child association 
{
  key AttachmentUUID,
      IncUUID,
      
      @Search.defaultSearchElement: true  // Permitir búsqueda por nombre de archivo
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      FileName,
      
      FileType,
      FileSize,
      MimeType,
      
      @Semantics.largeObject: {
        mimeType: 'MimeType',
        fileName: 'FileName',
        contentDispositionPreference: #ATTACHMENT
      }
      FileContent,
      
      UploadDate,
      UploadedBy,
      
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      
      /* Association */
      _Attachment : redirected to parent z_c_inct_fjcm
}

