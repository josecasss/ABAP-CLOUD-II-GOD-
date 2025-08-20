@EndUserText.label: 'Parameters for Change Status'
define abstract entity z_ae_change_status_fjcm
{
@EndUserText.label: 'Change Status'
@Consumption.valueHelpDefinition: [ {
    entity.name: 'zdd_status_vh_fjcm',   // Value help for status
    entity.element: 'StatusCode',        // Help Element in value help
    useForValidation: true               // For validation
  } ]
    status : zde_status_fjcm;    
@EndUserText.label: 'Add Observation Text'
    Text : abap.char(60);
}
