@Metadata.allowExtensions: true
@EndUserText.label: 'Incidents - Consumption Entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true          // Enable advanced search on this entity

define root view entity z_c_inct_fjcm
  provider contract transactional_query
  as projection on z_r_incidents_fjcm
{
  key IncUUID,
      @Search.defaultSearchElement: true  // Default search element
      @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
      @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda
      IncidentID,
      @Search.defaultSearchElement: true  // Default search element
      @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
      @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda
      Title,
      @Search.defaultSearchElement: true  // Default search element
      @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
      @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda
      Description,
      Status,
      Priority,
      @Search.defaultSearchElement: true  // Default search element
      @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
      @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda
      CreationDate,
      @Search.defaultSearchElement: true  // Default search element
      @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
      @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda
      ChangedDate,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _History : redirected to composition child Z_C_INCT_H_FJCM, //Redirected composition association to the child entity,
      _Attachments : redirected to composition child Z_C_ATTACHMENT_INCIDENTS_FJCM  // 🆕 AGREGAR ESTA LÍNEA
}
