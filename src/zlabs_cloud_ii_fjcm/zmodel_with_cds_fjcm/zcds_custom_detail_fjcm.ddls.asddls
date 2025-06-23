@EndUserText.label: 'LAB 03 CDS'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CUSTOM_DETAIL_FJCM'
define custom entity ZCDS_CUSTOM_DETAIL_FJCM
{
  key customer_id   : /dmo/customer_id;
      phone_number  : /dmo/phone_number;
      email_address : /dmo/email_address;

}
