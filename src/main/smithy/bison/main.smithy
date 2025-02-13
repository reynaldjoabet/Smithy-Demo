$version: "2.0"

namespace com.bison
use alloy#simpleRestJson
//use aws.protocols#restJson1
use smithy.framework#ValidationException

@simpleRestJson
@cors({
    additionalAllowedHeaders: ["Content-Type"]
    additionalExposedHeaders: ["X-Bison-Version", "X-Amzn-ErrorType"]
})
@title("Rank members of the herd")
service BisonRates {
    version: "2022-07-07"
    operations: [
        CreateBison
        ListBison
    ]
    errors: [
        AccessDeniedException
        BadRequestException
        GatewayTimeoutException
        InternalFailureException
        NotAcceptableException
        NotImplementedException
        RequestTooLargeException
        ResourceConflictException
        ResourceNotFoundException
        SerializationException
        ServiceUnavailableException
        UnknownOperationException
        UnsupportedMediaTypeException
        ValidationException
    ]
}

@length(min: 20, max: 30)
@pattern("^[A-Z0-9]+$")
string BisonId

string ServiceVersion

@length(min: 5, max: 60)
@pattern("^[A-Za-z][A-Za-z0-9 ]*[A-Za-z0-9]?$")
string Name

@range(min: 1, max: 100)
integer HerdRank

list BisonTags {
    member: BisonTag
}

structure BisonTag {
    key: String
    value: String
}
