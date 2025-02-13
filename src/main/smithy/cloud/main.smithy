$version: "2"

namespace com.cloud.main

//use aws.auth#sigv4
//use aws.api#service
//use aws.protocols#restJson1
use smithy.framework#ValidationException
use com.cloud.date_tracker#DateOuting
use com.cloud.date_tracker#GetLocationByPlaceId
use com.cloud.date_tracker#SearchForLocation
use com.cloud.date_tracker#GetConnectedUsers
use com.cloud.minecraft#ServerStatus
use com.cloud.auth#CreateUser
use com.cloud.auth#CreateUserInput
use com.cloud.auth#GenerateAuthenticationOptions
use com.cloud.auth#GenerateAuthenticationOptionsInput
use com.cloud.auth#GenerateRegistrationOptions
use com.cloud.auth#GenerateRegistrationOptionsInput
use com.cloud.auth#GetPublicKeys
use com.cloud.auth#JwksKey
use com.cloud.auth#JwksKeyList
use com.cloud.auth#KeyList
use com.cloud.auth#Logout
use com.cloud.auth#SiteAccessList
use com.cloud.auth#TransportsList
use com.cloud.auth#UserData
use com.cloud.auth#UserInfo
use com.cloud.auth#GetJwks
use com.cloud.minecraft#ServerDetails
use com.cloud.minecraft#StartServer
use com.cloud.minecraft#Status
use com.cloud.minecraft#StopServer
use com.cloud.auth#VerifyAuthentication
use com.cloud.auth#VerifyAuthenticationInput
use com.cloud.auth#VerifyRegistration
use com.cloud.auth#VerifyRegistrationInput

@title("Various API's to support services")

// Cross-origin resource sharing allows resources to be requested from external domains.
// Cors should be enabled for externally facing services and disabled for internally facing services.
// Enabling cors will modify the OpenAPI spec used to define your API Gateway endpoint.
// Uncomment the line below to enable cross-origin resource sharing
// I've manually implemented my own CORS api
// @cors(origin: "*" ,additionalAllowedHeaders: ["Content-Type", "content-type"] )
//@sigv4(name: "execute-api")
//@service(sdkId: "IronSpider")
// Can only have 1 service, so look into resources to have journal + MC paths https://awslabs.github.io/smithy/2.0/spec/service-types.html#service-resources
//Smithy defines a resource as an entity with an identity that has a set of operations.
// it prob makes more sense to have a resource for Journal, but MC is a set of operations, really.
@httpApiKeyAuth(
    name: "spider-access-token",
    in: "header"
)
// need to remove the ui's content type header for inputs with no body, so all of them.  
service IronSpider {
    version: "2018-05-10",
    resources: [DateOuting],
    operations: [
        // MC server
        ServerStatus,
        ServerDetails,
        StartServer,
        StopServer,
        //Auth
        CreateUser,
        GenerateRegistrationOptions,
        VerifyRegistration,
        GenerateAuthenticationOptions,
        VerifyAuthentication,
        // auth related 
        UserInfo,
        GetPublicKeys,
        GetJwks,
        Logout,

        // support the date trackerW
        SearchForLocation, 
        GetLocationByPlaceId,
        GetConnectedUsers
        ],
}

@httpError(500)
@error("server")
structure InternalServerError {
    message: String
}

@httpError(400)
@error("client")
structure BadRequestError {
    message: String
}
@httpError(401)
@error("client")
structure NeedDomainAccessError {
    message: String
}

@httpError(404)
@error("client")
structure NotFoundError {
    message:  String
}

