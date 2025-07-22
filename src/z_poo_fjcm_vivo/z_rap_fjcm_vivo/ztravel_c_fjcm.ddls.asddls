@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true          // Enable advanced search on this entity
@Metadata.allowExtensions: true   // Allow extensions on this entity

define root view entity ztravel_c_fjcm
  provider contract transactional_query
  as projection on ztravel_r_fjcm // Root
{
  key     TravelUUID,
          TravelID,

          @Search.defaultSearchElement: true  // Default search element
          @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
          @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda*
          @ObjectModel.text.element: [ 'AgencyName'] // Asociated text element for search with their ID
          AgencyID,
          _Agency.Name              as AgencyName, // Associated text element for search *Cuando haga el matchcode aparecera el nombre de la agencia asociada para búsqueda*

          @Search.defaultSearchElement: true  // Default search element
          @Search.fuzzinessThreshold: 0.8     // Fuzziness threshold for search *Umbral de búsqueda*
          @Search.ranking: #MEDIUM            // Ranking for search *Importancia Clasificación de búsqueda*
          @ObjectModel.text.element: [ 'CustomerLastName'] // Asociated text element for search with their ID
          CustomerID,
          _Customer.LastName        as CustomerLastName, // Associated text element for search *Cuando haga el matchcode aparecera el nombre del cliente asociado para búsqueda*

          BeginDate,
          EndDate,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          BookingFee,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          TotalPrice,

          //SADL - Service Adaptation Description Language
          @EndUserText.label: 'VAT Included' // Label for the virtual field
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_FJCM' // This class contains the logic to calculate the VAT included in the total price
  virtual PriceWithVAT : /dmo/total_price, // Virtual field to calculate the total price with VAT *Campo virtual añadido al vuelo para calcular el precio total con IVA*

          CurrencyCode,
          Description,

          @ObjectModel.text.element:['OverallStatusText']
          OverallStatus,
          _OverallStatus._Text.Text as OverallStatusText : localized, // Localized The system manages the text for the status in different languages (: *Better practice*
          //_OverallStatus._Text[1:Language = $session.system_language].Text as OverallStatusText,      //The text is used for many languages so can change cardinally

          // Keep just these two audit fields
          @Semantics.systemDateTime.localInstanceLastChangedAt: true
          LocalLastChangedAt,
          @Semantics.systemDateTime.lastChangedAt: true
          LastChangedAt,

          /* Associations */
          _Agency,
          _Currency,
          _Customer,
          _OverallStatus
}

// Define Projection template

// Consumption Entity to project
