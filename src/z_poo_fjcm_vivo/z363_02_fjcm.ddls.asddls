@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Session Variables'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z363_02_FJCM as select from /dmo/customer
{
 key customer_id as CustomerID,                     // Key field for customer
     $session.client as ClientField,                // Client field from session
     $session.system_date as SystemDate,            // System date from session
     $session.system_language as SystemLanguage,    // System language from session
     $session.user as UserField,                    // User field from session
     $session.user_date as UserDate,                // User date from session
     $session.user_timezone as UserTimezone         // User timezone from session
     
//     $session.bs_instance_id as BSInstanceID,
//     $session.bs_zone_id as BSZoneID   
}
