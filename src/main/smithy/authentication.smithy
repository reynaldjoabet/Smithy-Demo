$version: "2"

namespace com.running

use smithy.framework#ValidationException

resource Authentication {
    operations: [
        IsAuthenticated
        Authenticate
        ExchangeToken
    ]
}

@readonly
@http(method: "GET", uri: "/isAuthenticated/{username}", code: 200)
operation IsAuthenticated {
    input: IsAuthenticatedInput
    output: IsAuthenticatedOutput
    errors: [
        AuthorizationError
        AuthenticationError
        ValidationException
    ]
}

structure IsAuthenticatedInput {
    @required
    @httpLabel
    username: String
}

structure IsAuthenticatedOutput {
    @required
    isAuthenticated: Boolean
}

@readonly
@http(method: "GET", uri: "/authenticate/{username}", code: 200)
operation Authenticate {
    input: AuthenticationInput
    output: AuthenticationOutput
    errors: [
        AuthorizationError
        AuthenticationError
        ValidationException
    ]
}

structure AuthenticationInput {
    @required
    @httpLabel
    username: String
}

structure AuthenticationOutput {
    @required
    authUrl: String
}

@error("server")
@httpError(500)
structure AuthenticationError {
    @required
    message: String
}

@readonly
@http(method: "GET", uri: "/exchangeToken/{username}")
operation ExchangeToken {
    input: ExchangeTokenInput
    output: ExchangeTokenOutput
    errors: [
        AuthorizationError
        ValidationException
    ]
}

structure ExchangeTokenInput {
    @httpLabel
    @required
    username: String

    @httpQuery("state")
    @required
    state: String

    @httpQuery("code")
    @required
    code: String

    @httpQuery("scope")
    @required
    scope: Scope
}

list Scope {
    member: String
}

structure ExchangeTokenOutput {
    @httpHeader("Location")
    content: String

    @httpResponseCode
    responseCode: Integer
}
