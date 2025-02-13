$version: "2"

namespace com.weather

/// Provides weather forecasts.
@paginated(inputToken: "nextToken", outputToken: "nextToken", pageSize: "pageSize")
service WeatherService {
    version: "2006-03-01"
    resources: [
        City
    ]
    operations: [
        GetCurrentTime,
        StreamingOperation,
        PublishMessages,
        SubscribeToMovements
    ]
}

resource City {
    identifiers: { cityId: CityId }
    properties: { coordinates: CityCoordinates }
    read: GetCity
    list: ListCities
    resources: [
        Forecast
    ]
}

resource Forecast {
    identifiers: { cityId: CityId }
    properties: { chanceOfRain: Float }
    read: GetForecast
}

// "pattern" is a trait.
@pattern("^[A-Za-z0-9 ]+$")
string CityId

@readonly
operation GetCity {
    input := for City {
        // "cityId" provides the identifier for the resource and
        // has to be marked as required.
        @required
        $cityId
    }

    output := for City {
        // "required" is used on output to indicate if the service
        // will always provide a value for the member.
        @required
        @notProperty
        name: String

        @required
        $coordinates
    }

    errors: [
        NoSuchResource
    ]
}

// This structure is nested within GetCityOutput.
structure CityCoordinates {
    @required
    latitude: Float

    @required
    longitude: Float
}

// "error" is a trait that is used to specialize
// a structure as an error.
@error("client")
structure NoSuchResource {
    @required
    resourceType: String
}

// The paginated trait indicates that the operation may
// return truncated results.
@readonly
@paginated(items: "items")
operation ListCities {
    input := {
        nextToken: String
        pageSize: Integer
    }

    output := {
        nextToken: String

        @required
        items: CitySummaries
    }
}

// CitySummaries is a list of CitySummary structures.
list CitySummaries {
    member: CitySummary
}

// CitySummary contains a reference to a City.
@references([
    {
        resource: City
    }
])
structure CitySummary {
    @required
    cityId: CityId

    @required
    name: String
}

@readonly
operation GetCurrentTime {
    output := {
        @required
        time: Timestamp
    }
}

@readonly
operation GetForecast {
    input := for Forecast {
        // "cityId" provides the only identifier for the resource since
        // a Forecast doesn't have its own.
        @required
        $cityId
    }

    output := for Forecast {
        $chanceOfRain
    }
}

// data streaming
@readonly
operation StreamingOperation {
    input := {}
    output := {
        @httpPayload
        output: StreamingBlob = ""
    }
}

@streaming
blob StreamingBlob


// event streaming
operation PublishMessages {
    input: PublishMessagesInput
}

@input
structure PublishMessagesInput {
    room: String
    messages: PublishEvents
}

@streaming
union PublishEvents {
    message: Message
    leave: LeaveEvent
}

structure Message {
    message: String
}

structure LeaveEvent {}

operation SubscribeToMovements {
    input: SubscribeToMovementsInput,
    output: SubscribeToMovementsOutput
}

@input
structure SubscribeToMovementsInput {}

@output
structure SubscribeToMovementsOutput {
    movements: MovementEvents
}

@streaming
union MovementEvents {
    up: Movement
    down: Movement
    left: Movement
    right: Movement
    throttlingError: ThrottlingError
}

structure Movement {
    velocity: Float
}

/// An example error emitted when the client is throttled
/// and should terminate the event stream.
@error("client")
@retryable(throttling: true)
structure ThrottlingError {}

@error("client")
@httpError(400)
structure ValidationException {
    @required
    message: String
}

@error("client")
@httpError(403)
structure AccessDeniedException {
    @required
    message: String
}

@error("client")
@httpError(404)
structure ResourceNotFoundException {
    @required
    message: String
}

@error("server")
@httpError(500)
@retryable
structure InternalServerError {
    @required
    message: String
}