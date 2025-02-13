$version: "2.0"

namespace com.minerva

//use aws.protocols#restJson1
// use aws.api#arn
// use aws.api#ArnNamespace
// use aws.api#arnReference
// use aws.api#clientDiscoveredEndpoint
// use aws.api#clientEndpointDiscovery
// use aws.api#clientEndpointDiscoveryId
// use aws.api#CloudFormationName
// use aws.api#controlPlane
// use aws.api#data
// use aws.api#dataPlane
// use aws.api#ResourceDelimiter
// use aws.api#service
// use aws.api#tagEnabled
// use aws.api#taggable
// use aws.api#TaggableApiConfig
// use aws.api#TagOperationReference
// use aws.auth#cognitoUserPools
// use aws.auth#sigv4
// use aws.auth#sigv4a
// use aws.auth#StringList
// use aws.auth#unsignedPayload
// use aws.customizations#s3UnwrappedXmlOutput
// use aws.protocols#awsJson1_0
// use aws.protocols#awsJson1_1
// use aws.protocols#awsQuery
// use aws.protocols#awsQueryCompatible
// use aws.protocols#awsQueryError
// use aws.protocols#ChecksumAlgorithm
// use aws.protocols#ChecksumAlgorithmSet
// use aws.protocols#ec2Query
// use aws.protocols#ec2QueryName
// use aws.protocols#httpChecksum
// use aws.protocols#HttpConfiguration
// use aws.protocols#restXml
//use aws.protocols#StringList
use smithy.framework#ValidationException
use smithy.framework#ValidationExceptionField
use smithy.api#addedDefault
use smithy.api#auth
use smithy.api#authDefinition
use smithy.api#AuthTraitReference
use smithy.api#BigDecimal
use smithy.api#BigInteger
use smithy.framework#ValidationExceptionFieldList
use alloy#simpleRestJson

@simpleRestJson
@httpBearerAuth
service DatasetService {
    version: "2023-12-03"
    resources: [Dataset]
    operations: [HealthCheck, Signin]
}

@readonly
@http(uri: "/health", method: "GET")
@auth([])
operation HealthCheck {
    input := {
        @required
        @httpHeader("x-message")
        message: String
    }
    output := {
        @required
        message: String
    }
    errors: [ValidationException, ServerError]
}

/// Signin to get a token.
@http(uri: "/signin", method: "POST")
@auth([])
operation Signin {
    input := {
        @required
        username: String
        @required
        password: String
    }
    output := {
        @required
        token: String
    }
    errors: [ValidationException, UnauthorizedError, ForbiddenError, ThrottlingError]
}