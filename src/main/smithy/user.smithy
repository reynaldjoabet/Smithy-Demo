$version: "2"

namespace com.running

use smithy.framework#ValidationException

resource User {
    identifiers: {
        id: UserId
    }
    create: SignUp
}

string UserId

@idempotent
@http(method: "PUT", uri: "/signup", code: 201)
operation SignUp {
    input: SignUpInput
    output: SignUpOutput
    errors: [
        SignUpError
        ValidationException
    ]
}

@input
structure SignUpInput {
    @required
    username: String

    @required
    password: String
}

@output
structure SignUpOutput {}

@error("server")
@httpError(500)
structure SignUpError {
    message: String
}

@readonly
@http(method: "GET", uri: "/login", code: 200)
operation Login {
    input: LoginInput
    output: LoginOutput
    errors: [
        LoginError
        ValidationException
    ]
}

@input
structure LoginInput {
    @httpHeader("username")
    username: String

    @httpHeader("password")
    password: String
}

@output
structure LoginOutput {}

@error("client")
@httpError(401)
structure LoginError {
    message: String
}
