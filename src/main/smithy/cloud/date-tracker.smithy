$version: "2"

namespace com.cloud.date_tracker

use com.cloud.common#ValidatedOperation
use com.cloud.common#CommonHeaders
use com.cloud.picture#Picture
use com.cloud.main#NotFoundError
use alloy#simpleRestJson


resource DateOuting {
    identifiers: { dateId: String },
    resources: [Picture]
    //TODO: Decide if i should be putting the properties in here, or just specifying them in the API's via the Data object?
    // pros of Data: easy to add values,
    // cons : don't get smithy validations? idk if thats trues
    // properties: {
        

    // location: String,

    // pictures: PictureList,

    // note: String,
    // success: Boolean,
    //     // outing: DateData
    // },
    read: GetDate,
    create: CreateDate,
    
    update: UpdateDate,
    delete: DeleteDate,
    list: ListDates,
}


@references([{resource: DateOuting
 ids: {
            dateId: "id"
        }
} ])
structure DateInfo {
    /// Unique identifier for the date
    @required
    // Represents an date with various data fields
    //@resourceIdentifier("dateId")
    id: String,

    @required
    title: String,
    /// Location of the date
    @required
    location: String,

    @required
    coordinates: Coordinates,

    @required
    @timestampFormat("date-time")
    date: Timestamp

    @required
    @documentation("The person who threw the date")
    dateThrower: String

    @required
    userId: String

    /// Additional notes about the date
    note: String,

    /// Id of the picture associated with the date
    pictureId: String,
}

structure Coordinates {
    lat: String,
    long: String
    alt: String,
}

// CRUD Operations
@readonly
@http(method: "GET", uri: "/v1/dates/{dateId}")
operation GetDate with [ValidatedOperation] {
    input: GetDateInput,
    output: GetDateOutput,
}

@input
structure GetDateInput {
    @required
    @httpLabel
    dateId: String
}

@output
structure GetDateOutput for DateOuting with [CommonHeaders] {
    @required
    @httpPayload
    outing: DateInfo,
}

@idempotent
@http(method: "POST", uri: "/v1/dates")
operation CreateDate with [ValidatedOperation] {
    input: CreateDateInput,
    output: CreateDateOutput,
    
}

structure CreateDateInput {
    @required
    location: String,
    @required
    title: String,
    @required
    note: String,
    @required
    coordinates: Coordinates

    @required
    dateThrower: String,
    @timestampFormat("date-time")
    date: Timestamp
}

structure CreateDateOutput with [CommonHeaders] {
    @required
    @httpPayload
    outing: DateInfo,
}

@idempotent
@http(method: "PUT", uri: "/v1/dates/{dateId}")
operation UpdateDate with [ValidatedOperation] {
    input: UpdateDateInput,
    output: UpdateDateOutput,
    
}

structure UpdateDateInput {
    @required
    @httpLabel
    dateId: String,
    location: String,
    title: String,
    note: String,
    coordinates: Coordinates,
    dateThrower: String,
    @timestampFormat("date-time")
    date: Timestamp,
}

structure UpdateDateOutput with [CommonHeaders] {
    @required
    @httpPayload
    outing: DateInfo,
}

@idempotent
@http(method: "DELETE", uri: "/v1/dates/{dateId}")
operation DeleteDate with [ValidatedOperation]{
    input: DeleteDateInput,
    output: DeleteDateOutput,

}

structure DeleteDateInput {
    @required
    @httpLabel
    dateId: String,
}

structure DeleteDateOutput {
    @required
    success: Boolean,
}

@readonly
@paginated(inputToken: "nextToken", outputToken: "nextToken", pageSize: "pageSize")
@http(method: "GET", uri: "/v1/dates")
operation ListDates with [ValidatedOperation] {
    input: ListDatesInput,
    output: ListDatesOutput,
}
@input
structure ListDatesInput {
    @httpQuery("nextToken")
    nextToken: String,
    @httpQuery("pageSize")
    pageSize: Integer,
}
@output
structure ListDatesOutput with [CommonHeaders] {
    @required
    items: DateList,
    nextToken: String,
}

list DateList {
    member: DateInfo
}
@readonly
@http(method: "GET", uri: "/v1/connected-users")
operation GetConnectedUsers with [ValidatedOperation] {
    // input: GetConnectedUsersInput,
    output: GetConnectedUsersOutput
}

// @input 
// structure GetConnectedUsersInput {

// }

@output
structure GetConnectedUsersOutput {
    @required
    users: ConnectedUsersList
}
list ConnectedUsersList {
    member: ConnectedUser
}
structure ConnectedUser {
    @required
    displayName: String,
    @required
    userId: String,
}

@http(method: "POST", uri: "/v1/locations")
operation SearchForLocation with [ValidatedOperation] {
    input: SearchForLocationInput
    output: SearchForLocationOutput
}
@input
structure SearchForLocationInput {
    @required
    searchText: String
    biasPosition: Coordinates
}

@output
structure SearchForLocationOutput with [CommonHeaders] {
    @required
    results: SearchResultsList
}

list SearchResultsList {
    member: SearchResult
}
structure SearchResult {
    text: String,
    placeId: String
}

@readonly
@http(method: "GET", uri: "/v1/locations/{placeId}")
operation GetLocationByPlaceId with [ValidatedOperation]{
    input: GetLocationByPlaceIdInput
    output: GetLocationByPlaceIdOutput
    
}
@input
structure GetLocationByPlaceIdInput {
    @httpLabel
    @required
    placeId: String
}
@output
structure GetLocationByPlaceIdOutput {
    place: Place
}
structure Place {
    @required
    label: String,
    typeOfPlace: String,
    @required
    coordinates: Coordinates
}