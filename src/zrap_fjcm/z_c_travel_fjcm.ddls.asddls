@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption'
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true                   // ***TO ACTIVATE ADVANCED SEARCH FUNCTIONALITY***
@Metadata.allowExtensions: true            // Allow extensions to this view entity

define root view entity z_c_travel_fjcm // Agregar root por que estamos tratando del root
  provider contract transactional_query // This view is used for transactional queries
  as projection on z_r_travel_fjcm

{
  key     TravelUUID,

          TravelID,

          @Search.defaultSearchElement: true     // Default search element for the TravelID
          @Search.fuzzinessThreshold: 0.8       // Fuzziness threshold for better search results     *Umbral 0.0 .. 1.0 to allow searchs according to exact match
          @Search.ranking: #MEDIUM             //  Ranking for search results
          @ObjectModel.text.element: ['AgencyName'] // Text elements for better readability
          AgencyID,

          _Agency.Name              as AgencyName, // De la agency muestra el nombre concatenado

          @Search.defaultSearchElement: true     // Default search element for the CustomerID
          @Search.fuzzinessThreshold: 0.8       // Fuzziness threshold for better search results     *Umbral +++0.0 .. 1.0 to allow searchs according to exact match
          @Search.ranking: #MEDIUM             //  Ranking for search results
          @ObjectModel.text.element: ['CustomerName'] // Text elements for better readability
          CustomerID,

          _Customer.LastName        as CustomerName, // Del customer muestra el LastName concatenado

          //Validaciones como CAP Assert faciles //Para validaciones simples
          @Semantics.valueRange.minimum: '20260101'
          @Semantics.valueRange.maximum: '20261231'
          BeginDate,

          //Validaciones como CAP Assert faciles
          @Semantics.valueRange.minimum: '20260101'
          @Semantics.valueRange.maximum: '20261231'
          EndDate,

          //Validaciones como CAP Assert faciles
          @Semantics.valueRange.minimum: '0'
          @Semantics.valueRange.maximum: '100'
          @Semantics.amount.currencyCode: 'CurrencyCode'
          BookingFee,

          @Semantics.amount.currencyCode: 'CurrencyCode'
          TotalPrice,

          //SADL - Service Adaptation Description Languaje
          //Virtual Element
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_SADL_FJCM' // Clase que se encarga de calcular el valor del elemento virtual
  virtual PriceWithVAT      : /dmo/total_price,

          CurrencyCode,

          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #HIGH
          Description,

          @ObjectModel.text.element: ['OverallStatusText'] // To show the text representation of the status
          OverallStatus,

          _OverallStatus._Text.Text as OverallStatusText : localized, // Better way to do it so the system can handle the text depending on the language
          //    _OverallStatus._Text[1: Language = $session.system_language].Text as OverallStatusText, //Reduce cardinality to 1

          //          OverallStatusCriticality,

          //SADL - Service Adaptation Description Languaje
          @EndUserText.label: 'Status Criticality'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRT_ELEM_CRITICALITY_FJCM' // Clase que se encarga de calcular el valor del elemento virtual
  virtual StatusCriticality : /dmo/overall_status,

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

//Made it by template define view entity
// Concat y todo esas funciones se hacen en el root
