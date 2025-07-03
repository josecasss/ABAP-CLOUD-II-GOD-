@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_c_travel_fjcm
provider contract transactional_query    // This view is used for transactional queries
  as projection on z_r_travel_fjcm
{
  key TravelUUID,
      TravelID,
      @ObjectModel.text.element: ['AgencyName'] // Text elements for better readability
      AgencyID,
      _Agency.Name as AgencyName,
      
      @ObjectModel.text.element: ['CustomerName'] // Text elements for better readability
      CustomerID,
      _Customer.LastName as CustomerName,
      
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      
      OverallStatus,
        _OverallStatus._Text.Text as OverallStatusText : localized, //
//      _OverallStatus._Text[1: Language = $session.system_language].Text as OverallStatusText, //Reduce cardinality to 1 
      
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
//In projection its not allowed to use functions for example concatwithspace, if its need it must be used in the ROOT VIEW ENTITY
