$version: "2"

namespace com.running

use smithy.framework#ValidationException

resource Athletes {
    identifiers: {
        athleteId: String
    }
    properties: {
        athlete: Athlete
    }
    read: GetAthlete
    collectionOperations: [
        GetAthleteFromUsername
    ]
}

structure Athlete {
    @required
    @resourceIdentifier("athleteId")
    athleteId: String

    user_id: String

    resource_state: Integer

    firstname: String

    lastname: String

    profile_medium: String

    profile: String

    city: String

    state: String

    country: String

    sex: String

    premium: Boolean

    summit: Boolean

    created_at: Timestamp

    updated_at: Timestamp

    follower_count: Integer

    friend_count: Integer

    measurement_preference: String

    ftp: Integer

    weight: Double
}

@readonly
@http(method: "GET", uri: "/getAthlete/{athleteId}", code: 200)
operation GetAthlete {
    input: GetAthleteInput
    output: GetAthleteOutput
    errors: [
        GetAthleteError
        ValidationException
    ]
}

structure GetAthleteInput for Athletes {
    @required
    @httpLabel
    $athleteId
}

structure GetAthleteOutput for Athletes {
    athlete: Athlete
}

@readonly
@http(method: "GET", uri: "/getAthlete", code: 200)
operation GetAthleteFromUsername {
    input: GetAthleteFromUsernameInput
    output: GetAthleteFromUsernameOutput
    errors: [
        GetAthleteError
        ValidationException
    ]
}

@input
structure GetAthleteFromUsernameInput {
    @required
    @httpQuery("username")
    username: String
}

@output
structure GetAthleteFromUsernameOutput for Athlete {
    athlete: Athlete
}

@error("server")
@httpError(500)
structure GetAthleteError {
    @required
    message: String
}
