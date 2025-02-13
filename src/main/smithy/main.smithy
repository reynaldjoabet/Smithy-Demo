$version: "2"

namespace com.running

use alloy#simpleRestJson
use smithy.framework#ValidationException

// @service(sdkId: "Running")
@simpleRestJson
@cors({})
@httpBasicAuth
@auth([httpBasicAuth])
service RunningService {
    version: "2023-08-13"
    operations: [
        Login
        Ping
    ]
    resources: [
        Authentication
        Athletes
        Activities
        User
    ]
}

@readonly
@http(method: "GET", uri: "/ping", code: 200)
operation Ping {
    input: PingInput
    output: PingOutput
    errors: [
        ValidationException
    ]
}

@input
structure PingInput {}

@output
structure PingOutput {
    message: String
}

@error("client")
@httpError(401)
structure AuthorizationError {
    message: String
}
