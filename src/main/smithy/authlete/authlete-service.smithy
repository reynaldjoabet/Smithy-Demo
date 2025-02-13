$version: "2"

namespace authlete.services

use authlete.models#AuthorizationRequest
use authlete.models#AccessToken
use authlete.models#AccessTokens
use authlete.models#ApplicationType
use authlete.models#AttachmentType
use authlete.models#AttachmentTypes
use authlete.models#AuthorizationDetails
use authlete.models#AuthorizationDetailsElement
use authlete.models#AuthorizationDetailsElements
use authlete.models#AuthorizationFailRequest
use authlete.models#AuthorizationFailRequestReason
use authlete.models#AuthorizationFailResponse
use authlete.models#AuthorizationFailResponseAction
use authlete.models#AuthorizationIssueRequest
use authlete.models#AuthorizationIssueResponse
use authlete.models#AuthorizationIssueResponseAction
use authlete.models#AuthorizationResponse
use authlete.models#AuthorizationResponseAction
use authlete.models#AuthzDetails
use authlete.models#BackchannelAuthenticationCompleteRequest
use authlete.models#BackchannelAuthenticationCompleteRequestResult
use authlete.models#BackchannelAuthenticationCompleteResponse
use authlete.models#BackchannelAuthenticationCompleteResponseAction
use authlete.models#BackchannelAuthenticationFailRequest
use authlete.models#BackchannelAuthenticationFailRequestReason
use authlete.models#BackchannelAuthenticationFailResponse
use authlete.models#BackchannelAuthenticationFailResponseAction
use authlete.models#BackchannelAuthenticationIssueRequest
use authlete.models#BackchannelAuthenticationIssueResponse
use authlete.models#BackchannelAuthenticationIssueResponseAction
use authlete.models#BackchannelAuthenticationRequest
use authlete.models#BackchannelAuthenticationResponse
use authlete.models#BackchannelAuthenticationResponseAction
use authlete.models#ClaimType
use authlete.models#ClaimTypes
use authlete.models#Client
use authlete.models#ClientAuthenticationMethod
use authlete.models#ClientAuthMethod
use authlete.models#ClientAuthMethods
use authlete.models#ClientAuthorizationDeleteResponse
use authlete.models#ClientAuthorizationGetListResponse
use authlete.models#ClientAuthorizationUpdateResponse
use authlete.models#ClientExtension
use authlete.models#ClientExtensionRequestableScopesGetResponse
use authlete.models#ClientExtensionRequestableScopesUpdateRequest
use authlete.models#ClientFlagUpdateRequest
use authlete.models#ClientFlagUpdateResponse
use authlete.models#ClientGetListResponse
use authlete.models#ClientGrantedScopesDeleteResponse
use authlete.models#ClientGrantedScopesGetResponse
use authlete.models#ClientRegistrationDeleteRequest
use authlete.models#ClientRegistrationDeleteResponse
use authlete.models#ClientRegistrationDeleteResponseAction
use authlete.models#ClientRegistrationGetRequest
use authlete.models#ClientRegistrationGetResponse
use authlete.models#ClientRegistrationGetResponseAction
use authlete.models#ClientRegistrationRequest
use authlete.models#ClientRegistrationResponse
use authlete.models#ClientRegistrationResponseAction
use authlete.models#ClientRegistrationType
use authlete.models#ClientRegistrationTypes
use authlete.models#ClientRegistrationUpdateRequest
use authlete.models#ClientRegistrationUpdateResponse
use authlete.models#ClientRegistrationUpdateResponseAction
use authlete.models#Clients
use authlete.models#ClientSecretRefreshResponse
use authlete.models#ClientSecretUpdateRequest
use authlete.models#ClientSecretUpdateResponse
use authlete.models#ClientType
use authlete.models#DeliveryMode
use authlete.models#DeliveryModes
use authlete.models#DeviceAuthorizationRequest
use authlete.models#DeviceAuthorizationResponse
use authlete.models#DeviceAuthorizationResponseAction
use authlete.models#DeviceCompleteRequest
use authlete.models#DeviceCompleteRequestResult
use authlete.models#DeviceCompleteResponse
use authlete.models#DeviceCompleteResponseAction
use authlete.models#DeviceVerificationRequest
use authlete.models#DeviceVerificationResponse
use authlete.models#DeviceVerificationResponseAction
use authlete.models#Display
use authlete.models#Displays
use authlete.models#DynamicScope
use authlete.models#DynamicScopes
use authlete.models#FederationConfigurationResponse
use authlete.models#FederationConfigurationResponseAction
use authlete.models#FederationRegistrationRequest
use authlete.models#FederationRegistrationResponse
use authlete.models#FederationRegistrationResponseAction
use authlete.models#GMRequest
use authlete.models#GMResponse
use authlete.models#GMResponseAction
use authlete.models#Grant
use authlete.models#GrantManagementAction
use authlete.models#GrantScope
use authlete.models#GrantScopes
use authlete.models#GrantType
use authlete.models#GrantTypes
use authlete.models#Hsk
use authlete.models#HskCreateRequest
use authlete.models#HskGetListResponse
use authlete.models#HskGetListResponseAction
use authlete.models#HskGetResponse
use authlete.models#HskGetResponseAction
use authlete.models#Hsks
use authlete.models#InfoResponse
use authlete.models#IntrospectionRequest
use authlete.models#StandardIntrospectionRequest
use authlete.models#IntrospectionResponse
use authlete.models#IntrospectionResponseAction
use authlete.models#JoseVerifyRequest
use authlete.models#JoseVerifyResponse
use authlete.models#JweAlg
use authlete.models#JweEnc
use authlete.models#JwsAlg
use authlete.models#NamedUri
use authlete.models#NamedUris
use authlete.models#Pair
use authlete.models#Pairs
use authlete.models#Prompt
use authlete.models#Prompts
use authlete.models#Properties
use authlete.models#Property
use authlete.models#PushedAuthorizationRequest
use authlete.models#PushedAuthorizationResponse
use authlete.models#PushedAuthorizationResponseActionEnum
use authlete.models#PushedAuthReqRequest
use authlete.models#PushedAuthReqResponse
use authlete.models#PushedAuthReqResponseAction
use authlete.models#ResponseType
use authlete.models#ResponseTypes
use authlete.models#Result
use authlete.models#RevocationRequest
use authlete.models#RevocationResponse
use authlete.models#RevocationResponseAction
use authlete.models#Scope
use authlete.models#Scopes
use authlete.models#Service
use authlete.models#ServiceGetListResponse
use authlete.models#ServiceJwksGetResponse
use authlete.models#ServiceProfile
use authlete.models#ServiceProfiles
use authlete.models#Services
use authlete.models#Sns
use authlete.models#SnsCredentials
use authlete.models#SnsCredentialsList
use authlete.models#SnsList
use authlete.models#StandardIntrospectionResponse
use authlete.models#StandardIntrospectionResponseAction
use authlete.models#StringList
use authlete.models#SubjectType
use authlete.models#TaggedValue
use authlete.models#TaggedValues
use authlete.models#TokenCreateRequest
use authlete.models#TokenCreateResponse
use authlete.models#TokenCreateResponseAction
use authlete.models#TokenFailRequest
use authlete.models#TokenFailRequestReason
use authlete.models#TokenFailResponse
use authlete.models#TokenFailResponseAction
use authlete.models#TokenGetListResponse
use authlete.models#TokenInfo
use authlete.models#TokenIssueRequest
use authlete.models#TokenIssueResponse
use authlete.models#TokenIssueResponseAction
use authlete.models#TokenRequest
use authlete.models#TokenResponse
use authlete.models#TokenStatus
use authlete.models#TokenResponseAction
use authlete.models#TokenRevokeRequest
use authlete.models#TokenRevokeResponse
use authlete.models#TokenType
use authlete.models#TokenUpdateRequest
use authlete.models#TokenUpdateResponse
use authlete.models#TokenUpdateResponseAction
use authlete.models#TrustAnchor
use authlete.models#TrustAnchors
use authlete.models#UserCodeCharset
use authlete.models#UserInfoIssueRequest
use authlete.models#UserInfoIssueResponse
use authlete.models#UserInfoIssueResponseAction
use authlete.models#UserInfoRequest
use authlete.models#UserInfoResponse
use authlete.models#UserInfoResponseAction
use authlete.models#VerifiedClaims
use authlete.models#VerifiedClaimsValidationSchema
use authlete.models#TokenListResponse
use authlete.models#ServiceListResponse
use authlete.models#ServiceConfigurationRequest
use authlete.models#ClientListResponse
use authlete.models#ClientList


service AuthleteService{
   version: "2025-03-01"
    resources: [
// AuthorizationResource,
// TokenResource,
// ClientAuthorizationResource,
// IntrospectionResource,
// UserInfoResource,
// ServiceResource,
// ClientResource,
// ClientExtensionResource
    ]
    operations: [
       Revocation,

    ] 
}



/// Represents the Authorization API for authentication and authorization operations.
resource AuthorizationResource {
    operations: [
        Authorization,
        AuthorizationFail,
        AuthorizationIssue
    ]
}

/// Handles the authorization request.
@http(method: "POST", uri: "/api/{serviceId}/auth/authorization")
operation Authorization {
    input: AuthorizationInput,
    output: AuthorizationResponse
}

/// Handles a failed authorization attempt.
@http(method: "POST", uri: "/api/{serviceId}/auth/authorization/fail")
operation AuthorizationFail {
    input: AuthorizationFailInput,
    output: AuthorizationFailResponse
}

/// Issues a new authorization token.
@http(method: "POST", uri: "/api/{serviceId}/auth/authorization/issue")
operation AuthorizationIssue {
    input: AuthorizationIssueInput,
    output: AuthorizationIssueResponse
}

/// Input structure for the `Authorization` operation.
@input
structure AuthorizationInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: AuthorizationRequest
}

/// Input structure for the `AuthorizationFail` operation.
structure AuthorizationFailInput {
    @httpLabel
    @required
    serviceId: String,

    @httpPayload
    body: AuthorizationFailRequest
}

/// Input structure for the `AuthorizationIssue` operation.
structure AuthorizationIssueInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: AuthorizationIssueRequest
}



/// Resource for handling token-related operations.
resource TokenResource {
    operations: [
        Token,
        TokenCreate,
        TokenDelete,
        TokenFail,
        TokenIssue,
        TokenRevoke,
        TokenUpdate,
        GetTokenList
    ]
}

/// Retrieves a token.
@http(method: "POST", uri: "/api/{serviceId}/auth/token")
operation Token {
    input: TokenInput
    output: TokenResponse
}

/// Creates a new token.
@http(method: "POST", uri: "/api/{serviceId}/auth/token/create")
operation TokenCreate {
    input: TokenCreateInput
    output: TokenCreateResponse
}

/// Deletes a token.
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/auth/token/delete/{token}")
operation TokenDelete {
    input: TokenDeleteInput
    output: Unit
}

/// Handles token failures.
@http(method: "POST", uri: "/api/{serviceId}/auth/token/fail")
operation TokenFail {
    input: TokenFailInput
    output: TokenFailResponse
}

/// Issues a new token.
@http(method: "POST", uri: "/api/{serviceId}/auth/token/issue")
operation TokenIssue {
    input: TokenIssueInput
    output: TokenIssueResponse
}

/// Revokes a token.
@http(method: "POST", uri: "/api/{serviceId}/auth/token/revoke")
operation TokenRevoke {
    input: TokenRevokeInput
    output: TokenRevokeResponse
}

/// Updates a token.
@http(method: "POST", uri: "/api/{serviceId}/auth/token/update")
operation TokenUpdate {
    input: TokenUpdateInput
    output: TokenUpdateResponse
}

/// Retrieves a list of tokens with optional filters.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/auth/token/list")
operation GetTokenList {
    input: GetTokenListInput
    output: TokenListResponse
}

/// Input structure for the `Token` operation.
@input
structure TokenInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenRequest
}

/// Input structure for the `TokenCreate` operation.
@input
structure TokenCreateInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenCreateRequest
}

/// Input structure for the `TokenDelete` operation.
@input
structure TokenDeleteInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    token: String
}

/// Input structure for the `TokenFail` operation.
@input
structure TokenFailInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenFailRequest
}

/// Input structure for the `TokenIssue` operation.
@input
structure TokenIssueInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenIssueRequest
}

/// Input structure for the `TokenRevoke` operation.
@input
structure TokenRevokeInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenRevokeRequest
}

/// Input structure for the `TokenUpdate` operation.
@input
structure TokenUpdateInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: TokenUpdateRequest
}

/// Input structure for the `GetTokenList` operation with multiple filtering options.
@input
structure GetTokenListInput {
    @httpLabel
    @required
    serviceId: String
    
    @httpQuery("clientIdentifier")
    clientIdentifier: String
    @httpQuery("subject")
    subject: String
    @httpQuery("start")
    start: Integer
    @httpQuery("end")
    end: Integer
    @httpQuery("rangeGiven")
    rangeGiven: Boolean
    @httpQuery("tokenStatus")
    tokenStatus: TokenStatus
}



/// Issues a revocation request.
@http(method: "POST", uri: "/api/{serviceId}/auth/revocation")
operation Revocation {
    input: RevocationInput
    output: RevocationResponse
}

/// Input structure for the `Revocation` operation.
@input
structure RevocationInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: RevocationRequest
}

resource UserInfoResource {
  
    operations: [
        Userinfo,
        UserinfoIssue
    ]

}

/// Retrieves user information.
@http(method: "POST", uri: "/api/{serviceId}/auth/userinfo")
operation Userinfo {
    input: UserinfoInput
    output: UserInfoResponse
}

/// Issues user information with additional parameters.
@http(method: "POST", uri: "/api/{serviceId}/auth/userinfo/issue")
operation UserinfoIssue {
    input: UserinfoIssueInput
    output: UserInfoIssueResponse
}

/// Input structure for the `Userinfo` operation.
@input
structure UserinfoInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: UserInfoRequest
}

/// Input structure for the `UserinfoIssue` operation.
@input
structure UserinfoIssueInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: UserInfoIssueRequest
}


resource IntrospectionResource {

    // collectionOperations: [
    //     Introspection,
    //     StandardIntrospection
    // ]
    
    operations: [
      Introspection,
        StandardIntrospection
    ]
}

/// Performs introspection on an OAuth token.
@http(method: "POST", uri: "/api/{serviceId}/auth/introspection")
operation Introspection {
    input: IntrospectionInput
    output: IntrospectionResponse
}

/// Performs a standard introspection on an OAuth token.
@http(method: "POST", uri: "/api/{serviceId}/auth/introspection/standard")
operation StandardIntrospection {
    input: StandardIntrospectionInput
    output: StandardIntrospectionResponse
}

/// Input structure for the `Introspection` operation.
@input
structure IntrospectionInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: IntrospectionRequest
}

/// Input structure for the `StandardIntrospection` operation.
@input
structure StandardIntrospectionInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: StandardIntrospectionRequest
}


resource ServiceResource {
    
    operations: [
         CreateService,
         //CreateServie,
         DeleteService,
         GetService,
         GetServiceList,
         UpdateService,
         GetServiceJwks,
       GetServiceConfiguration
    ]
}

/// Creates a new service.
@http(method: "POST", uri: "/api/service/create")
operation CreateService {
    input: Service
    output: Service
}

// /// Deprecated operation to create a new service.
// @deprecated({message:"Use createService instead",since:"1.2"})
// @http(method: "POST", uri: "/api/service/create")
// operation CreateService {
//     input: CreateServiceInput
//     output: Service
// }

/// Deletes a service.
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/service/delete")
operation DeleteService {
    input: DeleteServiceInput
    output: Unit
}

/// Retrieves a service.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/service/get")
operation GetService {
    input: GetServiceInput
    output: Service
}

/// Retrieves a list of services.
@readonly
@http(method: "GET", uri: "/api/service/get/list")
operation GetServiceList {
    input: GetServiceListInput
    output: ServiceListResponse
}

/// Updates a service.
@idempotent
@http(method: "PUT", uri: "/api/{serviceId}/service/update")
operation UpdateService {
    input: UpdateServiceInput
    output: Service
}

/// Retrieves the service's JWKS.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/service/jwks/get")
operation GetServiceJwks {
    input: GetServiceJwksInput
    output: GetServiceJwksOutput
}

/// Output structure for the `GetServiceJwks` operation.
@output
structure GetServiceJwksOutput {
    jwks: String
}

/// Retrieves the service's configuration.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/service/configuration")
operation GetServiceConfiguration {
    input: GetServiceConfigurationRequest
    output: GetServiceConfigurationOutput
}

/// Output structure for the `GetServiceConfiguration` operation.
@output
structure GetServiceConfigurationOutput {
    configuration: String
}

/// Input structure for the `CreateService` operation.
// @input
// structure CreateServiceInput {
//     @httpPayload
//     body: Service
// }

/// Input structure for the `DeleteService` operation.
@input
structure DeleteServiceInput {
    @httpLabel
    @required
    serviceId: String
}

/// Input structure for the `GetService` operation.
@input
structure GetServiceInput {
    @httpLabel
    @required
    serviceId: String
}

/// Input structure for the `GetServiceList` operation.
@input
structure GetServiceListInput {
    @httpQuery("start")
    start: Integer
    @httpQuery("end")
    end: Integer
}

/// Input structure for the `UpdateService` operation.
@input
structure UpdateServiceInput {
    @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: Service
}

/// Input structure for the `GetServiceJwks` operation.
@input
structure GetServiceJwksInput {
    @httpLabel
    @required
    serviceId: String
      
    @httpQuery("pretty")  
    pretty: Boolean
     @httpQuery("includePrivateKeys") 
    includePrivateKeys: Boolean
}

/// Input structure for the `GetServiceConfiguration` operation.
@input
structure GetServiceConfigurationRequest {
    @httpLabel
    @required
    serviceId: String
    
    @httpQuery("pretty") 
    pretty: Boolean
    
     @httpQuery("patch") 
    patch: String
}




resource ClientResource {
  
    operations: [
         CreateClient,
        DynamicClientRegister,
        DynamicClientGet,
        DynamicClientUpdate,
         DynamicClientDelete,
         DeleteClient,
         GetClient,
        GetClientList,
         UpdateClient
    ]
    
}

/// Creates a new client.
@http(method: "POST", uri: "/api/{serviceId}/client/create")
operation CreateClient {
    input: CreateClientInput
    output: Client
}

/// Registers a dynamic client.
@http(method: "POST", uri: "/api/{serviceId}/client/registration")
operation DynamicClientRegister {
    input: DynamicClientRegisterInput
    output: ClientRegistrationResponse
}

/// Retrieves a dynamic client registration.
@http(method: "POST", uri: "/api/{serviceId}/client/registration/get")
operation DynamicClientGet {
    input: DynamicClientGetInput
    output: ClientRegistrationResponse
}

/// Updates a dynamic client registration.
@http(method: "POST", uri: "/api/{serviceId}/client/registration/update")
operation DynamicClientUpdate {
    input: DynamicClientUpdateInput
    output: ClientRegistrationResponse
}

/// Deletes a dynamic client registration.
@http(method: "POST", uri: "/api/{serviceId}/client/registration/delete")
operation DynamicClientDelete {
    input: DynamicClientDeleteInput
    output: ClientRegistrationResponse
}

/// Deletes a client by clientId (Long).
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/client/delete/{clientId}")
operation DeleteClient {
    input: DeleteClientInput
    output: Unit
}

/// Deletes a client by clientId (String).
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/client/delete/{clientId}")
operation DeleteClientByString {
    input: DeleteClientByStringInput
    output: Unit
}

/// Retrieves a client by clientId (Long).
@readonly
@http(method: "GET", uri: "/api/{serviceId}/client/get/{clientId}")
operation GetClient {
    input: GetClientInput
    output: Client
}

/// Retrieves a client by clientId (String).
@readonly
@http(method: "GET", uri: "/api/{serviceId}/client/get/{clientId}")
operation GetClientByString {
    input: GetClientByStringInput
    output: Client
}

/// Retrieves a list of clients.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/client/get/list")
operation GetClientList {
    input: GetClientListInput
    output: ClientListResponse
}

/// Updates a client.
@idempotent
@http(method: "PUT", uri: "/api/{serviceId}/client/update/{clientId}")
operation UpdateClient {
    input: UpdateClientInput
    output: Client
}

/// Input structure for the `CreateClient` operation.
@input
structure CreateClientInput {
     @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: Client
}

/// Input structure for the `DynamicClientRegister` operation.
@input
structure DynamicClientRegisterInput {
     @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: ClientRegistrationRequest
}

/// Input structure for the `DynamicClientGet` operation.
@input
structure DynamicClientGetInput {
     @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: ClientRegistrationRequest
}

/// Input structure for the `DynamicClientUpdate` operation.
@input
structure DynamicClientUpdateInput {
     @httpLabel
    @required
    serviceId: String

    @httpPayload
    body: ClientRegistrationRequest
}

/// Input structure for the `DynamicClientDelete` operation.
@input
structure DynamicClientDeleteInput {
     @httpLabel
    @required
    serviceId: String
    @httpPayload
    body: ClientRegistrationRequest
}

/// Input structure for the `DeleteClient` operation (Long clientId).
@input
structure DeleteClientInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: Long
}

/// Input structure for the `DeleteClientByString` operation (String clientId).
@input
structure DeleteClientByStringInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: String
}

/// Input structure for the `GetClient` operation (Long clientId).
@input
structure GetClientInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: Long
}

/// Input structure for the `GetClientByString` operation (String clientId).
@input
structure GetClientByStringInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: String
}

/// Input structure for the `GetClientList` operation.
@input
structure GetClientListInput {
    @httpLabel
    @required
    serviceId: String

    @httpQuery("developer")
    developer: String
    @httpQuery("start")
    start: Integer
    @httpQuery("end")
    end: Integer
    @httpQuery("rangeGiven")
    rangeGiven: Boolean
}

/// Input structure for the `UpdateClient` operation.
@input
structure UpdateClientInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: String

    @httpPayload
    body: Client
}


resource ClientExtensionResource {
    operations: [
        //GetRequestableScopes,
        //SetRequestableScopes,
        DeleteRequestableScopes,
        GetGrantedScopes,
        DeleteGrantedScopes
    ]
}

/// Fetch requestable scopes for a client.
// @http(method: "GET", uri: "/api/{serviceId}/client/extension/requestable_scopes/get/{clientId}")
// operation GetRequestableScopes {
//     input: GetRequestableScopesInput,
//     output: StringList
// }

// /// Set requestable scopes for a client.
// @http(method: "POST", uri: "/api/{serviceId}/client/extension/requestable_scopes/set/{clientId}")
// operation SetRequestableScopes {
//     input: SetRequestableScopesInput,
//     output: StringList
// }

/// Delete requestable scopes for a client.
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/client/extension/requestable_scopes/delete/{clientId}")
operation DeleteRequestableScopes {
    input: DeleteRequestableScopesInput,
    output: Unit
}

/// Fetch granted scopes for a client and a subject.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/client/extension/granted_scopes/get/{clientId}/{subject}")
operation GetGrantedScopes {
    input: GetGrantedScopesInput,
    output: GrantedScopesGetResponse
}

/// Delete granted scopes for a client and a subject.
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/client/extension/granted_scopes/delete/{clientId}/{subject}")
operation DeleteGrantedScopes {
    input: DeleteGrantedScopesInput,
    output: Unit
}

/// Input structure for GetRequestableScopes.
structure GetRequestableScopesInput {
    @httpLabel
    @required
    clientId: Long
}

/// Input structure for SetRequestableScopes.
structure SetRequestableScopesInput {
    @httpLabel
    @required
    clientId: Long

    @httpPayload
    scopes: StringList
}

/// Input structure for DeleteRequestableScopes.
structure DeleteRequestableScopesInput {
     @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: Long
}

/// Input structure for GetGrantedScopes.
structure GetGrantedScopesInput {
     @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: Long

    @httpLabel
    @required
    subject: String
}

/// Input structure for DeleteGrantedScopes.
structure DeleteGrantedScopesInput {
     @httpLabel
    @required
    serviceId: String

    @httpLabel
     @required
    clientId: Long

    @httpLabel
     @required
    subject: String
}

/// Response type for granted scopes.
structure GrantedScopesGetResponse {
    scopes: StringList
}


resource ClientAuthorizationResource {

    operations: [
        DeleteClientAuthorization,
        GetClientAuthorizationList,
        UpdateClientAuthorization
    ]
}

/// Delete the client authorization for a specific client and subject.
@idempotent
@http(method: "DELETE", uri: "/api/{serviceId}/client/authorization/delete/{clientId}/{subject}")
operation DeleteClientAuthorization {
    input: DeleteClientAuthorizationInput,
    output: Unit
}

/// Get the list of client authorizations.
@readonly
@http(method: "GET", uri: "/api/{serviceId}/client/authorization/list")
operation GetClientAuthorizationList {
    input: ClientAuthorizationGetListRequest,
    //output: AuthorizedClientListResponse
}

/// Update the client authorization for a specific client.
@idempotent
@http(method: "PUT", uri: "/api/{serviceId}/client/authorization/update/{clientId}")
operation UpdateClientAuthorization {
    input: ClientAuthorizationUpdateRequest,
    output: Unit
}

structure ClientAuthorizationGetListRequest{
     @httpLabel
    @required
    serviceId: String  
}
structure ClientAuthorizationUpdateRequest{
    @httpLabel
    @required
    serviceId: String

    @httpLabel
     @required
    clientId: Long
}
/// Input structure for DeleteClientAuthorization operation.
structure DeleteClientAuthorizationInput {
     @httpLabel
    @required
    serviceId: String

    @httpLabel
     @required
    clientId: Long

    @httpLabel
    @required
    subject: String
}



/// Refresh the client secret for a given client ID.
@http(method: "POST", uri: "/api/{serviceId}/client/secret/refresh/{clientId}")
operation RefreshClientSecret {
    input: RefreshClientSecretInput,
    output: ClientSecretRefreshResponse
}

/// Refresh the client secret for a given client identifier.
@http(method: "POST", uri: "/api/{serviceId}/client/secret/refresh/{clientIdentifier}")
operation RefreshClientSecretByIdentifier {
    input: RefreshClientSecretByIdentifierInput,
    output: ClientSecretRefreshResponse
}

/// Update the client secret for a given client ID.
@idempotent
@http(method: "PUT", uri: "/api/{serviceId}/client/secret/update/{clientId}")
operation UpdateClientSecret {
    input: UpdateClientSecretInput,
    output: ClientSecretUpdateResponse
}

/// Update the client secret for a given client identifier.
@idempotent
@http(method: "PUT", uri: "/api/{serviceId}/client/secret/update/{clientIdentifier}")
operation UpdateClientSecretByIdentifier {
    input: UpdateClientSecretByIdentifierInput,
    output: ClientSecretUpdateResponse
}

/// Verify JOSE (JSON Object Signing and Encryption).
@http(method: "POST", uri: "/api/{serviceId}/jose/verify")
operation VerifyJose {
    input: JoseVerifyRequestInput,
    output: JoseVerifyResponse
}

structure JoseVerifyRequestInput{
      @httpLabel
    @required
    serviceId: String
     @httpPayload
    body:JoseVerifyRequest
}

/// Input structure for RefreshClientSecret operation.
structure RefreshClientSecretInput {
      @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientId: Long
}

/// Input structure for RefreshClientSecretByIdentifier operation.
structure RefreshClientSecretByIdentifierInput {
      @httpLabel
    @required
    serviceId: String

    @httpLabel
    @required
    clientIdentifier: String
}

/// Input structure for UpdateClientSecret operation.
structure UpdateClientSecretInput {
    @httpLabel
    @required
    serviceId: String

    @httpLabel
     @required
    clientId: Long

    @httpPayload
    clientSecret: String
}

/// Input structure for UpdateClientSecretByIdentifier operation.
structure UpdateClientSecretByIdentifierInput {
      @httpLabel
    @required
    serviceId: String

    @httpLabel
     @required
    clientIdentifier: String

    @httpPayload
    clientSecret: String
}


