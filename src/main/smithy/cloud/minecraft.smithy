$version: "2"

namespace com.cloud.minecraft

use com.cloud.common#ValidatedOperation
use com.cloud.common#CommonHeaders
use com.cloud.main#InternalServerError
use com.cloud.main#BadRequestError
use com.cloud.main#NotFoundError
use smithy.framework#ValidationException


@readonly
@http(code: 200, method: "GET", uri: "/server/status")
operation ServerStatus with [ValidatedOperation] {
    output: ServerStatusOutput ,
    errors: [InternalServerError],
}

@readonly
@http(code: 200, method: "GET", uri: "/server/details")
operation ServerDetails {
    output: ServerDetailsOutput,
    errors: [ValidationException, InternalServerError]
}


@http(code: 200, method: "POST", uri: "/server/start")
operation StartServer {
    output: StartServerOutput,
    errors: [ValidationException, InternalServerError, BadRequestError],
}


@http(code:202, method: "POST", uri: "/server/stop")
operation StopServer {
    output: StopServerOutput,
    errors: [ValidationException, InternalServerError],
}



enum Status {
    PENDING = "Pending"
    RUNNING = "Running"
    SHUTTING_DOWN = "ShuttingDown"
    TERMINATED = "Terminated"
    STOPPING = "Stopping"
    STOPPED = "Stopped"
}

@output
structure ServerStatusOutput with [CommonHeaders]  {
    @required
    status: Status
}
@output
structure ServerDetailsOutput with [CommonHeaders] {
    domainName: String,
}
@output
structure StartServerOutput with [CommonHeaders] {
    serverStarted: Boolean,
}
@output
structure StopServerOutput with [CommonHeaders] {
    serverStopping: Boolean,
}