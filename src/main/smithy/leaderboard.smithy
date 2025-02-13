$version: "2"

namespace leaderboard

use alloy#simpleRestJson

// use aws.protocols#restJson1
use smithy.framework#ValidationException

/// Provides access to leaderboards and top scores
@simpleRestJson
service ElasticLeaderboardService {
    version: "2020-10-16"
    resources: [
        Leaderboard
    ]
}

resource Leaderboard {
    identifiers: {
        id: LeaderboardId
    }
    properties: {
        name: String
        maxEntries: MaxEntries
    }
    create: CreateLeaderboard
    read: GetLeaderboard
    update: UpdateLeaderboard
    delete: DeleteLeaderboard
    list: ListLeaderboards
    operations: [
        SubmitScoreEvent
    ]
}

@length(min: 4, max: 64)
string LeaderboardId

@range(min: 1, max: 32)
integer MaxEntries

/// Create a new leaderboard
@http(method: "POST", uri: "/leaderboards")
operation CreateLeaderboard {
    input: CreateLeaderboardInput
    output: CreateLeaderboardOutput
    errors: [
        ValidationException
    ]
}

@input
structure CreateLeaderboardInput {
    @required
    name: String

    @default(10)
    maxEntries: MaxEntries

    @idempotencyToken
    token: String
}

@output
structure CreateLeaderboardOutput {
    @required
    id: LeaderboardId
}

/// List the available leaderboards
@readonly
@paginated(inputToken: "nextToken", outputToken: "nextToken", pageSize: "maxResults")
@http(method: "GET", uri: "/leaderboards")
operation ListLeaderboards {
    input := {
        @httpQuery("nextToken")
        nextToken: String

        @httpQuery("maxResults")
        maxResults: Integer
    }

    output := {
        leaderboards: LeaderboardSummaryList
        nextToken: String
    }
}

list LeaderboardSummaryList {
    member: LeaderboardSummary
}

structure LeaderboardSummary for Leaderboard {
    $id
    $name
    $maxEntries
}

// ###################################################################################
/// Log a new high score for a user
@http(method: "POST", uri: "/leaderboards/{id}/scores")
operation SubmitScoreEvent {
    input := for Leaderboard {
        @required
        @httpLabel
        $id

        @required
        @notProperty
        scoreEvent: ScoreEvent
    }

    errors: [
        NotFoundError
        ValidationException
    ]
}

@httpError(404)
@error("client")
structure NotFoundError {
    message: String
}

integer GameScore

structure ScoreEvent {
    user: String
    score: GameScore
}

/// Get detailed information about a specific leaderboard including it's high scores
@readonly
@http(method: "GET", uri: "/leaderboards/{id}")
operation GetLeaderboard {
    input := for Leaderboard {
        @required
        @httpLabel
        $id
    }

    output := for Leaderboard {
        $name

        $maxEntries

        @notProperty
        highScores: ScoreEventList
    }

    errors: [
        ValidationException
        NotFoundError
    ]
}

list ScoreEventList {
    member: ScoreEvent
}

/// Update a leaderboard's configuration
@http(method: "PUT", uri: "/leaderboards/{id}")
@idempotent
operation UpdateLeaderboard {
    input := for Leaderboard {
        @required
        @httpLabel
        $id

        $name
    }

    errors: [
        NotFoundError
        ValidationException
    ]
}

/// Delete a leaderboard
@idempotent
@http(method: "DELETE", uri: "/leaderboards/{id}")
operation DeleteLeaderboard {
    input := for Leaderboard {
        @required
        @httpLabel
        $id
    }

    errors: [
        NotFoundError
        ValidationException
    ]
}
