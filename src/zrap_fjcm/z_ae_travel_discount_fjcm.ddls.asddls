@EndUserText.label: 'Travel Discount - Abstract Entity'
define abstract entity z_ae_travel_discount_fjcm
//  with parameters parameter_name : parameter_type
{
    @EndUserText.label: 'Discount %'               // This is a label for the discount percentage field   *BUTTON*       
    discount_percent : /DMO/BT_DiscountPercentage; // Here i have a one button to introduce the discount percentage, its like forms
    
}




// Made it by the template Define abstract Entity with parameters, but in this case im not gonna use parameters
// Abstarct entity does not display data, but it can be used for forms, like popups to introduce the user to the data
