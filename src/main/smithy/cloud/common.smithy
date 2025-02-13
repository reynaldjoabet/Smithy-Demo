$version: "2"
namespace com.cloud.common

use smithy.framework#ValidationException
use com.cloud.main#NotFoundError
use com.cloud.main#BadRequestError
use aws.api#arn

@mixin
operation ValidatedOperation {
    errors: [ValidationException, BadRequestError, NotFoundError]
}


@mixin
structure CommonHeaders {
    @httpHeader("Server-Timing")
    serverTiming: String
}