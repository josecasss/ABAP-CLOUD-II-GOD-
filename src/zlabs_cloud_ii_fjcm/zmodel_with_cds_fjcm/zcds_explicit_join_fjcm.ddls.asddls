@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LAB 02 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_EXPLICIT_JOIN_FJCM
  as select from /dmo/customer as Customer
  association [0..*] to /dmo/booking as _Booking on _Booking.customer_id = $projection.CustomerId
{
  key Customer.customer_id         as CustomerId,
      Customer.first_name          as FirstName,
      Customer.last_name           as LastName,
      _Booking[inner].booking_date as BookingDate

}


//  INNER JOIN: Lo usas cuando SOLO te interesan los que tienen relación en ambas tablas 
//  (por ejemplo, solo los clientes que tienen reservas).
//  LEFT OUTER JOIN: Lo usas cuando quieres ver todos los registros de la tabla principal, aunque no tengan relación 
// (por ejemplo, todos los clientes, aunque no tengan reservas; los campos de reservas salen vacíos).
