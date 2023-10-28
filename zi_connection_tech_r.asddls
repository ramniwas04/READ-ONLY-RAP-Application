@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View CDS Data Model'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
    }
@Search.searchable: true
define view entity ZI_Connection_Tech_r
  as select from /dmo/connection as Connection
  association [1..*] to ZI_Flight_TECH_R  as _Flight  on  $projection.CarrierId    = _Flight.CarrierId
                                                      and $projection.ConnectionId = _Flight.ConnectionId
  association [1]    to ZI_Carrier_TECH_R as _Airline on  $projection.CarrierId = _Airline.CarrierId
{
      @UI.facet: [{ id: 'Connection',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Connection Detail' },
                   { id: 'Flight',
                    purpose: #STANDARD,
                    type: #LINEITEM_REFERENCE,
                    position: 20,
                    label: 'Flights',
                    targetElement: '_Flight'
                     }
                    ]

      @UI.lineItem: [{ position: 10 , label: 'Airline'}]
      @UI.identification: [{ position: 10 }]
      @ObjectModel.text.association: '_Airline'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 30, label: 'Departure Airport ID'}]
      @UI.identification: [{ position: 30, label: 'Departure Airport ID' }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZI_airport_tech_VH',
          element: 'AirportId'
      } }]
      airport_from_id as AirportFromId,
      @UI.lineItem: [{ position: 40 }]
      @UI.selectionField: [{ position: 20 }]
      @UI.identification: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: {
          name: 'ZI_airport_tech_VH',
          element: 'AirportId'
      } }]
      @EndUserText.label: 'Destination Airport ID'
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      @UI.identification: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, label: 'Arrival Time'}]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI.identification: [{ position: 70 }]
      distance        as Distance,
      distance_unit   as DistanceUnit,
      //      Association --->
      @Search.defaultSearchElement: true
      _Flight,
      @Search.defaultSearchElement: true
      _Airline
}




















/*
@UI.headerInfo:typeNamePlural:'name'.
This annotation is an entity annotation because it concerns the whole entity rather than a specific element.

@Ui.lineItem: [{ position: 10, label: '' }]
The value's number does not represent an absolute measure and works as a relative value to the positions of
the other elements instead. Hence, the elements are arranged in ascending order with regard to the annotation value.

@UI.lineItem.label: label. In particular, you can label element with names containing spaces.
The label is displayed in the column header of the list report.

To include selection fields for the key elements in the header, use the annotation @UI.selectionField.position:decfloat
on the respective elements.
*/
