$version: "2"

namespace authlete.models

structure AccessToken {
    /// The hash of the access token.
    accessTokenHash: String

    /// The timestamp at which the access token will expire.
    accessTokenExpiresAt: Timestamp

    /// The hash of the refresh token.
    refreshTokenHash: String

    /// The timestamp at which the refresh token will expire.
    refreshTokenExpiresAt: Timestamp

    /// The timestamp at which the access token was first created.
    createdAt: Timestamp

    /// The timestamp at which the access token was last refreshed using the refresh token.
    lastRefreshedAt: Timestamp

    /// The ID of the client associated with the access token.
    clientId: Integer

    /// The subject (= unique user ID) associated with the access token.
    subject: String

    grantType: GrantType

    /// The scopes associated with the access token.
    scopes: StringList

    /// The properties associated with the access token.
    properties: Properties
}

/// The application type. The value of this property affects the validation steps for a redirect URI.
/// See the description about `redirectUris` property for more details.
enum ApplicationType {
    WEB,
    NATIVE,
    NULL
}

/// Supported attachment types. This property corresponds to the `attachments_supported` server metadata
/// which was added by the third implementer\'s draft of OpenID Connect for Identity Assurance 1.0.
enum AttachmentType {
    EMBEDDED,
    EXTERNAL
}

/// The authorization details. This represents the value of the `authorization_details` request parameter
/// in the preceding device authorization request which is defined in "OAuth 2.0 Rich Authorization Requests".
structure AuthorizationDetails {
    /// Elements of this authorization details.
    elements: AuthorizationDetailsElements
}

structure AuthorizationDetailsElement {
    /// The type of this element. From "OAuth 2.0 Rich Authorization Requests": "The type of authorization data as a string.
    /// This field MAY define which other elements are allowed in the request and will be used."
    @required
    type: String

    /// The resources and/or resource servers. This property may be `null`. From "OAuth 2.0 Rich Authorization Requests":
    /// "An array of strings representing the location of the resource or resource server."
    locations: StringList

    /// The actions. From "OAuth 2.0 Rich Authorization Requests": "An array of strings representing the kinds of actions to be taken at the resource.
    /// The values of the strings are determined by the deployment."
    actions: StringList

    /// From "OAuth 2.0 Rich Authorization Requests": "An array of strings representing the kinds of data being requested from the resource."
    /// This property may be `null`.
    dataTypes: StringList

    /// The identifier of a specific resource. From "OAuth 2.0 Rich Authorization Requests": "A string identifier indicating a specific resource available at the API."
    /// This property may be `null`.
    identifier: String

    /// The types or levels of privilege. From "OAuth 2.0 Rich Authorization Requests": "An array of strings representing the types or levels of privilege being requested at the resource."
    /// This property may be `null`.
    privileges: StringList

    /// The RAR request in the JSON format excluding the pre-defined attributes such as `type` and `locations`.
    /// The content and semantics are specific to the deployment and the use case implemented.
    otherFields: String
}

/// The request for authorization failure.
structure AuthorizationFailRequest {
    /// The ticket issued from Authlete `/auth/authorization` API.
    @required
    ticket: String

    /// The reason of the failure of the authorization request. For more details, see [NO_INTERACTION] in the description of `/auth/authorization` API.
    @required
    reason: AuthorizationFailRequestReason

    /// The custom description about the authorization failure.
    description: String
}
 /// The reasons for authorization failure.
enum AuthorizationFailRequestReason {
    UNKNOWN,
    NOT_LOGGED_IN,
    MAX_AGE_NOT_SUPPORTED,
    EXCEEDS_MAX_AGE,
    DIFFERENT_SUBJECT,
    ACR_NOT_SATISFIED,
    DENIED,
    SERVER_ERROR,
    NOT_AUTHENTICATED,
    ACCOUNT_SELECTION_REQUIRED,
    CONSENT_REQUIRED,
    INTERACTION_REQUIRED,
    INVALID_TARGET
}   


/// The response for authorization failure.
structure AuthorizationFailResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: AuthorizationFailResponseAction

    /// The content that the authorization server implementation is to return to the client application.
    /// Its format varies depending on the value of `action` parameter.
    responseContent: String

}
    /// The possible actions for authorization failure.
    enum AuthorizationFailResponseAction {
        INTERNAL_SERVER_ERROR,
        BAD_REQUEST,
        LOCATION,
        FORM
    }


structure AuthorizationIssueRequest {
    /// The ticket issued from Authlete `/auth/authorization` API.
    @required
    ticket: String

    /// The subject (= a user account managed by the service) who has granted authorization to the client application.
    @required
    subject: String

    /// The time when the authentication of the end-user occurred. Its value is the number of seconds from `1970-01-01`.
    authTime: Integer

    /// The Authentication Context Class Reference performed for the end-user authentication.
    acr: String

    /// The claims of the end-user (= pieces of information about the end-user) in JSON format.
    claims: String

    /// Extra properties to associate with an access token and/or an authorization code.
    properties: Properties

    /// Scopes to associate with an access token and/or an authorization code.
    /// If a non-empty string array is given, it replaces the scopes specified by the original authorization request.
    scopes: StringList

    /// The value of the `sub` claim to embed in an ID token.
    /// If this request parameter is `null` or empty, the value of the `subject` request parameter is used as the value of the `sub` claim.
    sub: String

    /// JSON that represents additional JWS header parameters for ID tokens that may be issued based on the authorization request.
    idtHeaderParams: String

    /// Claim key-value pairs that are used to compute transformed claims.
    claimsForTx: String

    /// The claims that the user has consented for the client application to know.
    consentedClaims: StringList

    /// The authorization details.
    authorizationDetails: AuthzDetails

    /// Additional claims that are added to the payload part of the JWT access token.
    jwtAtClaims: String

    /// The representation of an access token that may be issued as a result of the Authlete API call.
    accessToken: String
}

//@private()
list StringList {
    member: String
}

/// The response for authorization issue.
structure AuthorizationIssueResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: AuthorizationIssueResponseAction

    /// The content that the authorization server implementation is to return to the client application.
    /// Its format varies depending on the value of `action` parameter.
    responseContent: String

    /// The newly issued access token.
    /// Note that an access token is issued from an authorization endpoint only when `response_type` contains token.
    accessToken: String

    /// The datetime at which the newly issued access token will expire.
    /// The value is represented in milliseconds since the Unix epoch (1970-01-01).
    accessTokenExpiresAt: Long

    /// The duration of the newly issued access token in seconds.
    accessTokenDuration: Integer

    /// The newly issued ID token.
    /// Note that an ID token is issued from an authorization endpoint only when `response_type` contains `id_token`.
    idToken: String

    /// The newly issued authorization code.
    /// Note that an authorization code is issued only when `response_type` contains code.
    authorizationCode: String

    /// The newly issued access token in JWT format.
    /// If the service is not configured to issue JWT-based access tokens, this property is always set to `null`.
    jwtAccessToken: String

}
    /// The possible actions for authorization issue response.
    enum AuthorizationIssueResponseAction {
        INTERNAL_SERVER_ERROR,
        BAD_REQUEST,
        LOCATION,
        FORM
    }


/// The request for authorization.
structure AuthorizationRequest {
    /// OAuth 2.0 authorization request parameters which are the request parameters that the OAuth 2.0 authorization endpoint of the authorization server implementation received from the client application.
    @required
    parameters: String
}


/// The response for authorization.
structure AuthorizationResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: AuthorizationResponseAction

    /// The client information.
    client: Client

    /// The display information.
    display: Display

    /// The maximum authentication age.
    maxAge: Integer

    /// The service information.
    service: Service

    /// The scopes that the client application requests.
    scopes: Scopes

    /// The locales that the client application presented as candidates to be used for UI.
    uiLocales: StringList

    /// End-user's preferred languages and scripts for claims.
    claimsLocales: StringList

    /// The list of claims that the client application requests to be embedded in the ID token.
    claims: StringList

    /// Indicates whether the authentication of the end-user must be one of the ACRs (Authentication Context Class References) listed in `acrs` parameter.
    acrEssential: Boolean

    /// `true` if the value of the `client_id` request parameter included in the authorization request is the client ID alias. `false` if the value is the original numeric client ID.
    clientIdAliasUsed: Boolean

    /// The list of ACRs (Authentication Context Class References) one of which the client application requests to be satisfied for the authentication of the end-user.
    acrs: StringList

    /// The subject (= unique user ID managed by the authorization server implementation) that the client application expects to grant authorization.
    subject: String

    /// A hint about the login identifier of the end-user.
    loginHint: String

    /// The list of values of prompt request parameter.
    prompts: Prompts

    /// The lowest prompt value.
    lowestPrompt: Prompt

    /// The payload part of the request object.
    requestObjectPayload: String

    /// The value of the `id_token` property in the claims request parameter or in the claims property in a request object.
    idTokenClaims: String

    /// The value of the `userinfo` property in the `claims` request parameter or in the `claims` property in a request object.
    userInfoClaims: String

    /// The resources specified by the `resource` request parameters or by the `resource` property in the request object.
    resources: StringList

    /// The authorization details.
    authorizationDetails: AuthzDetails

    /// The `purpose` request parameter.
    purpose: String

    /// The content that the authorization server implementation is to return to the client application.
    responseContent: String

    /// A ticket issued by Authlete to the service implementation.
    ticket: String

    /// The dynamic scopes which the client application requested by the scope request parameter.
    dynamicScopes: DynamicScopes

    /// The grant management action.
    gmAction: GrantManagementAction

    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String

    /// The grant information.
    grant: Grant

    /// The subject identifying the user who has given the grant identified by the `grant_id` request parameter of the device authorization request.
    grantSubject: String

    /// Names of claims that are requested indirectly by "transformed claims".
    requestedClaimsForTx: StringList

    /// Names of verified claims that will be referenced when transformed claims are computed.
    requestedVerifiedClaimsForTx: VerifiedClaims

    /// The value of the `transformed_claims` property in the `claims` request parameter of an authorization request or in the `claims` property in a request object.
    transformedClaims: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean
}
    /// The possible actions for authorization response.
    enum AuthorizationResponseAction {
        INTERNAL_SERVER_ERROR,
        BAD_REQUEST,
        LOCATION,
        FORM,
        NO_INTERACTION,
        INTERACTION
    }



/// The authorization details.
/// This represents the value of the `authorization_details` request parameter in the preceding device authorization request which is defined in "OAuth 2.0 Rich Authorization Requests".
structure AuthzDetails {
    /// Elements of this authorization details.
    elements: AuthorizationDetailsElements
}

/// The request to complete backchannel authentication.
structure BackchannelAuthenticationCompleteRequest {
    /// The ticket issued by Authlete's `/backchannel/authentication` API.
    @required
    ticket: String

    /// The result of the end-user authentication and authorization.
    @required
    result: BackchannelAuthenticationCompleteRequestResult

    /// The subject (= unique identifier) of the end-user.
    @required
    subject: String

    /// The value of the sub claim that should be used in the ID token.
    sub: String

    /// The time at which the end-user was authenticated. Its value is the number of seconds from `1970-01-01`.
    authTime: Integer

    /// The reference of the authentication context class which the end-user authentication satisfied.
    acr: String

    /// Additional claims which will be embedded in the ID token.
    claims: String

    /// The extra properties associated with the access token.
    properties: Properties

    /// Scopes to replace the scopes specified in the original backchannel authentication request with.
    scopes: StringList

    /// JSON that represents additional JWS header parameters for ID tokens.
    idtHeaderParams: String

    /// The description of the error. If this optional request parameter is given, its value is used as the value of the `error_description` property, but it is used only when the result is not `AUTHORIZED`.
    errorDescription: String

    /// The URI of a document which describes the error in detail. This corresponds to the `error_uri` property in the response to the client.
    errorUri: String

    /// The claims that the user has consented for the client application to know.
    consentedClaims: StringList

    /// Additional claims that are added to the payload part of the JWT access token.
    jwtAtClaims: String

    /// The representation of an access token that may be issued as a result of the Authlete API call.
    accessToken: String
}

    /// The possible results for backchannel authentication completion.
enum BackchannelAuthenticationCompleteRequestResult {
        TRANSACTION_FAILED,
        ACCESS_DENIED,
        AUTHORIZED
    }

structure BackchannelAuthenticationCompleteResponse {
    
    /// The code which represents the result of the API call.
    resultCode: String,

    /// A short message which explains the result of the API call.
    resultMessage: String,

    /// The next action that the authorization server implementation should take.
    action: BackchannelAuthenticationCompleteResponseAction,

    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String,

    /// The client ID of the client application that has made the backchannel authentication request.
    clientId: Integer,

    /// The client ID alias of the client application that has made the backchannel authentication request.
    clientIdAlias: String,

    /// `true` if the value of the client_id request parameter included in the backchannel authentication request is the client ID alias. `false` if the value is the original numeric client ID.
    clientIdAliasUsed: Boolean,

    /// The name of the client application which has made the backchannel authentication request.
    clientName: String,

    /// The delivery mode.
    deliveryMode: DeliveryMode,

    /// The client notification endpoint to which a notification needs to be sent. This corresponds to the `client_notification_endpoint` metadata of the client application.
    clientNotificationEndpoint: String,

    /// The client notification token which needs to be embedded as a Bearer token in the Authorization header in the notification. This is the value of the `client_notification_token` request parameter.
    clientNotificationToken: String,

    /// The newly issued authentication request ID.
    authReqId: String,

    /// The issued access token.
    accessToken: String,

    /// The issued refresh token.
    refreshToken: String,

    /// The issued ID token.
    idToken: String,

    /// The duration of the access token in seconds.
    accessTokenDuration: Integer,

    /// The duration of the refresh token in seconds.
    refreshTokenDuration: Integer,

    /// The duration of the ID token in seconds.
    idTokenDuration: Integer,

    /// The issued access token in JWT format.
    jwtAccessToken: String,

    /// The resources specified by the `resource` request parameters or by the `resource` property in the request object.
    resources: StringList,

    /// The authorization details.
    authorizationDetails: AuthzDetails,

    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs,

    /// The attributes of the client.
    clientAttributes: Pairs,

    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String,

    /// The entity ID of the client.
    clientEntityId: String,

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}
    enum BackchannelAuthenticationCompleteResponseAction {
    SERVER_ERROR,
    NO_ACTION,
    NOTIFICATION
}


/// The request to fail backchannel authentication.
structure BackchannelAuthenticationFailRequest {
    /// The ticket which should be deleted on a call of Authlete's `/backchannel/authentication/fail` API.
    @required
    ticket: String

    /// The reason of the failure of the backchannel authentication request.
    @required
    reason: BackchannelAuthenticationFailRequestReason

    /// The description of the error. This corresponds to the `error_description` property in the response to the client.
    errorDescription: String

    /// The URI of a document which describes the error in detail. If this optional request parameter is given, its value is used as the value of the `error_uri` property.
    errorUri: String
}
    /// The possible reasons for the failure of the backchannel authentication request.
    enum BackchannelAuthenticationFailRequestReason {
        ACCESS_DENIED,
        EXPIRED_LOGIN_HINT_TOKEN,
        INVALID_BINDING_MESSAGE,
        INVALID_TARGET,
        INVALID_USER_CODE,
        MISSING_USER_CODE,
        SERVER_ERROR,
        UNAUTHORIZED_CLIENT,
        UNKNOWN_USER_ID
    }




/// The response for a failed backchannel authentication.
structure BackchannelAuthenticationFailResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: BackchannelAuthenticationFailResponseAction

    /// The content that the authorization server implementation is to return to the client application.
    responseContent: String

}
    /// The possible actions for a failed backchannel authentication response.
    enum BackchannelAuthenticationFailResponseAction {
        INTERNAL_SERVER_ERROR,
        BAD_REQUEST,
        FORBIDDEN
    }


/// The request to issue a backchannel authentication.
structure BackchannelAuthenticationIssueRequest {
    /// The ticket issued from Authlete's `/backchannel/authentication` API.
    @required
    ticket: String
}

/// The response for issuing a backchannel authentication.
structure BackchannelAuthenticationIssueResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: BackchannelAuthenticationIssueResponseAction

    /// The content that the authorization server implementation is to return to the client application.
    responseContent: String

    /// The newly issued authentication request ID.
    authReqId: String

    /// The duration of the issued authentication request ID in seconds.
    expiresIn: Integer

    /// The minimum amount of time in seconds that the client must wait for between polling requests to the token endpoint.
    interval: Integer
}
    /// The possible actions for a backchannel authentication issue response.
enum BackchannelAuthenticationIssueResponseAction {
    INTERNAL_SERVER_ERROR,
    INVALID_TICKET,
    OK
}



/// The request for a backchannel authentication.
structure BackchannelAuthenticationRequest {
    /// Parameters of a backchannel authentication request which are the request parameters that the backchannel authentication endpoint of the OpenID provider implementation received from the client application.
    @required
    parameters: String

    /// The client ID extracted from Authorization header of the backchannel authentication request from the client application. If the backchannel authentication endpoint of the OpenID provider implementation did not receive an Authorization header, this property is null.
    clientId: String

    /// The client secret extracted from Authorization header of the backchannel authentication request from the client application. If the backchannel authentication endpoint of the OpenID provider implementation did not receive an Authorization header, this property is null.
    clientSecret: String

    /// The client certification used in the TLS connection between the client application and the backchannel authentication endpoint of the OpenID provider.
    clientCertificate: String

    /// The client certificate path presented by the client during client authentication. Each element is a string in PEM format.
    clientCertificatePath: String
}

structure BackchannelAuthenticationResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: BackchannelAuthenticationResponseAction

    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String

    /// The client ID of the client application that has made the backchannel authentication request.
    clientId: Integer

    /// The client ID alias of the client application that has made the backchannel authentication request.
    clientIdAlias: String

    /// `true` if the value of the client_id request parameter included in the backchannel authentication request is the client ID alias. `false` if the value is the original numeric client ID.
    clientIdAliasUsed: Boolean

    /// The name of the client application which has made the backchannel authentication request.
    clientName: String

    /// The scopes requested by the backchannel authentication request. Basically, this property holds the value of the `scope` request parameter in the backchannel authentication request. However, it may have different values depending on the settings on the server side.
    scopes: Scopes

    /// The names of the claims which were requested indirectly via some special scopes. See [5.4. Requesting Claims using Scope Values](https://openid.net/specs/openid-connect-core-1_0.html#ScopeClaims).
    claimNames: StringList

    /// The client notification token included in the backchannel authentication request.
    clientNotificationToken: String

    /// The list of ACR values requested by the backchannel authentication request. Basically, this property holds the value of the `acr_values` request parameter in the backchannel authentication request. However, it may have different values depending on the settings on the server side.
    acrs: StringList

    /// The type of the hint for end-user identification which was included in the backchannel authentication request.
    hintType: String

    /// The value of the hint for end-user identification.
    hint: String

    /// The value of the `sub` claim contained in the ID token hint included in the backchannel authentication request.
    sub: String

    /// The binding message included in the backchannel authentication request.
    bindingMessage: String

    /// The user code included in the backchannel authentication request.
    userCode: String

    /// The flag which indicates whether a user code is required. `true` when both the `backchannel_user_code_parameter` metadata of the client and the `backchannel_user_code_parameter_supported` metadata of the authorization server are `true`.
    userCodeRequired: Boolean

    /// The requested expiry for the authentication request ID (`auth_req_id`).
    requestedExpiry: Integer

    /// The request context of the backchannel authentication request. It is the value of the request_context claim in the signed authentication request and its format is JSON.
    requestContext: String

    /// The warnings raised during processing the backchannel authentication request.
    warnings: StringList

    /// The ticket which is necessary to call Authlete's `/auth/token/fail` API or `/auth/token/issue` API. This parameter has a value only if the value of `grant_type` request parameter is `pass`.
    ticket: String

    /// The resources specified by the `resource` request parameters or by the `resource` property in the request object. If both are given, the values in the request object should be set. See "Resource Indicators for OAuth 2.0" for details.
    resources: StringList

    /// The authorization details associated with the backchannel authentication request.
    authorizationDetails: AuthzDetails

    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs

    /// The attributes of the client.
    clientAttributes: Pairs

    /// The dynamic scopes which the client application requested by the scope request parameter.
    dynamicScopes: DynamicScopes

    /// The delivery mode of the backchannel authentication request.
    deliveryMode: DeliveryMode

    /// The grant management action of the backchannel authentication request. The `grant_management_action` request parameter is defined in [Grant Management for OAuth 2.0](https://openid.net/specs/fapi-grant-management-1_0.html).
    gmAction: GrantManagementAction

    /// The value of the `grant_id` request parameter of the device authorization request. The `grant_id` request parameter is defined in [Grant Management for OAuth 2.0](https://openid.net/specs/fapi-grant-management-1_0.html).
    grantId: String

    /// The grant associated with the backchannel authentication request.
    grant: Grant

    /// The subject identifying the user who has given the grant identified by the `grant_id` request parameter of the device authorization request. Authlete 2.3 and newer versions support [OIDC Federation](https://openid.net/specs/openid-connect-federation-1_0.html).
    grantSubject: String

    /// The entity ID of the client.
    clientEntityId: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}

/// The possible actions for a backchannel authentication response.
enum BackchannelAuthenticationResponseAction {
    INTERNAL_SERVER_ERROR,
    BAD_REQUEST,
    UNAUTHORIZED,
    USER_IDENTIFICATION
}


enum ClaimType {
    NORMAL,
    AGGREGATED,
    DISTRIBUTED
}


structure Client {
    /// The sequential number of the client. The value of this property is assigned by Authlete.
    @required
    clientNumber: Integer

    /// The sequential number of the service of the client application. The value of this property is assigned by Authlete.
    @required
    serviceNumber: Integer

    /// The developer of the client application.
    developer: String

    /// The name of the client application. This property corresponds to `client_name` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    clientName: String

    /// Client names with language tags. If the client application has different names for different languages, this property can be used to register the names.
    clientNames: TaggedValues

    /// The description about the client application.
    description: String

    /// Descriptions about the client application with language tags. If the client application has different descriptions for different languages, this property can be used to register the descriptions.
    descriptions: TaggedValues

    /// The client ID. The value of this property is assigned by Authlete.
    @required
    clientId: Integer

    /// The client secret. A random 512-bit value encoded by base64url (86 letters). The value of this property is assigned by Authlete. Note that Authlete issues a client secret even to a "public" client.
    @required
    clientSecret: String

    /// The alias of the client ID. Note that the client ID alias is recognized only when this client's `clientIdAliasEnabled` property is set to `true` AND the service's `clientIdAliasEnabled` property is also set to true.
    clientIdAlias: String

    /// The flag to indicate whether the client ID alias is enabled or not. Note that a service also has `clientIdAliasEnabled` property. If the service's `clientIdAliasEnabled` property is set to false, this property's value is ignored.
    clientIdAliasEnabled: Boolean

    /// The type of the client application.
    clientType: ClientType

    /// The application type of the client application.
    applicationType: ApplicationType

    /// The URL pointing to the logo image of the client application. This property corresponds to `logo_uri` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    logoUri: String

    /// Logo image URLs with language tags. If the client application has different logo images for different languages, this property can be used to register URLs of the images.
    logoUris: TaggedValues

    /// An array of email addresses of people responsible for the client application. This property corresponds to `contacts` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    contacts: StringList

    /// The flag to indicate whether this client uses TLS client certificate bound access tokens.
    tlsClientCertificateBoundAccessTokens: Boolean

    /// The flag to indicate whether this client has been registered dynamically. For more details, see [RFC 7591].
    dynamicallyRegistered: Boolean

    /// The unique identifier string assigned by the client developer or software publisher used by registration endpoints to identify the client software to be dynamically registered.
    softwareId: String

    /// The version identifier string for the client software identified by the software ID. This property corresponds to the `software_version` metadata defined in [2. Client Metadata].
    softwareVersion: String

    /// The hash of the registration access token for this client.
    registrationAccessTokenHash: String

    /// The time at which this client was created. The value is represented as milliseconds since the UNIX epoch (1970-01-01).
    createdAt: Timestamp

    /// The time at which this client was last modified. The value is represented as milliseconds since the UNIX epoch (1970-01-01).
    modifiedAt: Timestamp

    /// A string array of grant types which the client application declares that it will restrict itself to using. This property corresponds to `grant_types` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    grantTypes: GrantTypes

    /// A string array of response types which the client application declares that it will restrict itself to using. This property corresponds to `response_types` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    responseTypes: ResponseTypes

    /// Redirect URIs that the client application uses to receive a response from the authorization endpoint. Requirements for a redirect URI are as follows.
    redirectUris: StringList

    /// The JWS algorithm that the client uses for signing authorization requests.
    authorizationSignAlg: JwsAlg

    /// The JWE algorithm that the client uses for encrypting authorization requests.
    authorizationEncryptionAlg: JweAlg

    /// The JWE encryption method that the client uses for encrypting authorization requests.
    authorizationEncryptionEnc: JweEnc

    /// The authentication method that the client uses at the token endpoint.
    tokenAuthMethod: ClientAuthMethod

    /// The JWS algorithm that the client uses for signing JWTs at the token endpoint.
    tokenAuthSignAlg: JwsAlg

    /// The key ID of a JWK containing a self-signed certificate of this client.
    selfSignedCertificateKeyId: String

    /// The string representation of the expected subject distinguished name of the certificate this client will use in mutual TLS authentication.
    tlsClientAuthSubjectDn: String

    /// The string representation of the expected DNS subject alternative name of the certificate this client will use in mutual TLS authentication.
    tlsClientAuthSanDns: String

    /// The string representation of the expected URI subject alternative name of the certificate this client will use in mutual TLS authentication.
    tlsClientAuthSanUri: String

    /// The string representation of the expected IP address subject alternative name of the certificate this client will use in mutual TLS authentication.
    tlsClientAuthSanIp: String

    /// The string representation of the expected email address subject alternative name of the certificate this client will use in mutual TLS authentication.
    tlsClientAuthSanEmail: String

    /// The flag to indicate whether this client is required to use the pushed authorization request endpoint. This property corresponds to the `require_pushed_authorization_requests` client metadata.
    parRequired: Boolean

    /// The flag to indicate whether authorization requests from this client are always required to utilize a request object by using either `request` or `request_uri` request parameter.
    requestObjectRequired: Boolean

    /// The JWS algorithm that the client uses for signing request objects.
    requestSignAlg: JwsAlg

    /// The JWE algorithm that the client uses for encrypting request objects.
    requestEncryptionAlg: JweAlg

    /// The JWE encryption method that the client uses for encrypting request objects.
    requestEncryptionEnc: JweEnc

    /// An array of URLs each of which points to a request object. Authlete requires that URLs used as values for `request_uri` request parameter be pre-registered.
    requestUris: StringList

    /// The default maximum authentication age in seconds. This value is used when an authorization request from the client application does not have `max_age` request parameter.
    defaultMaxAge: Integer

    /// The default ACRs (Authentication Context Class References). This value is used when an authorization request from the client application has neither `acr_values` request parameter nor `acr` claim.
    defaultAcrs: StringList

    /// The JWS algorithm that the client uses for signing ID tokens.
    idTokenSignAlg: JwsAlg

    /// The JWE algorithm that the client uses for encrypting ID tokens.
    idTokenEncryptionAlg: JweAlg

    /// The JWE encryption method that the client uses for encrypting ID tokens.
    idTokenEncryptionEnc: JweEnc

    /// The flag to indicate whether this client requires `auth_time` claim to be embedded in the ID token. This property corresponds to `require_auth_time` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    authTimeRequired: Boolean

    /// The subject type of the client application.
    subjectType: SubjectType

    /// The value of the sector identifier URI. This represents the `sector_identifier_uri` client metadata which is defined in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    sectorIdentifierUri: String

    /// The sector identifier host component as derived from either the `sector_identifier_uri` or the registered redirect URI. If no `sector_identifier_uri` is registered and multiple redirect URIs are used, this property is set to the host component of the redirect URI.
    @required
    derivedSectorIdentifier: String

    /// The URL pointing to the JWK Set of the client application. The content pointed to by the URL is JSON which complies with the format described in [JSON Web Key (JWK), 5. JWK Set Format].
    jwksUri: String

    /// The content of the JWK Set of the client application. The format is described in [JSON Web Key (JWK), 5. JWK Set Format]. The JWK Set must contain exactly one key.
    jwks: String

    /// The JWS algorithm that the client uses for signing userinfo responses.
    userInfoSignAlg: JwsAlg

    /// The JWE algorithm that the client uses for encrypting userinfo responses.
    userInfoEncryptionAlg: JweAlg

    /// The JWE encryption method that the client uses for encrypting userinfo responses.
    userInfoEncryptionEnc: JweEnc

    /// The URL which a third party can use to initiate a login by the client application. This property corresponds to `initiate_login_uri` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    loginUri: String

    /// The URL pointing to the "Terms Of Service" page. This property corresponds to `tos_uri` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    tosUri: String

    /// URLs of "Terms Of Service" pages with language tags. If the client application has different "Terms Of Service" pages for different languages, this property can be used to register the URLs.
    tosUris: TaggedValues

    /// The URL pointing to the page which describes the policy as to how end-user's profile data is used. This property corresponds to `policy_uri` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    policyUri: String

    /// URLs of policy pages with language tags. If the client application has different policy pages for different languages, this property can be used to register the URLs.
    policyUris: TaggedValues

    /// The URL pointing to the home page of the client application. This property corresponds to `client_uri` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    clientUri: String

    /// Home page URLs with language tags. If the client application has different home pages for different languages, this property can be used to register the URLs.
    clientUris: TaggedValues

    /// The backchannel token delivery mode. This property corresponds to the `backchannel_token_delivery_mode` metadata. The backchannel token delivery mode is defined in the specification of "CIBA".
    bcDeliveryMode: String

    /// The backchannel client notification endpoint. This property corresponds to the `backchannel_client_notification_endpoint` metadata. The backchannel token delivery mode is defined in the specification of "CIBA".
    bcNotificationEndpoint: String

    /// The JWS algorithm that the client uses for signing backchannel authentication requests.
    bcRequestSignAlg: JwsAlg

    /// The boolean flag to indicate whether a user code is required when this client makes a backchannel authentication request. This property corresponds to the `backchannel_user_code_parameter` metadata.
    bcUserCodeRequired: Boolean

    /// The attributes of this client.
    attributes: Pairs

    /// The client extension.
    extension: ClientExtension

    /// The authorization details types that this client may use as values of the `type` field in `authorization_details`. This property corresponds to the `authorization_details_types` metadata.
    authorizationDetailsTypes: StringList

    /// The custom client metadata in JSON format. Standard specifications define client metadata as necessary.
    customMetadata: String

    /// The flag indicating whether encryption of the request object is required when the request object is passed through the front channel. This flag does not affect the processing of request objects at the pushed authorization request endpoint.
    frontChannelRequestObjectEncryptionRequired: Boolean

    /// The flag indicating whether the JWE alg of encrypted request object must match the `request_object_encryption_alg` client metadata. The `request_object_encryption_alg` client metadata itself is defined in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    requestObjectEncryptionAlgMatchRequired: Boolean

    /// The flag indicating whether the JWE enc of encrypted request object must match the `request_object_encryption_enc` client metadata. The `request_object_encryption_enc` client metadata itself is defined in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
    requestObjectEncryptionEncMatchRequired: Boolean

    /// The digest algorithm that this client requests the server to use when it computes digest values.
    digestAlgorithm: String

    /// If `Enabled` is selected, an attempt to issue a new access token invalidates existing access tokens that are associated with the same combination of subject and client.
    singleAccessTokenPerSubject: Boolean

    /// The flag to indicate whether the use of Proof Key for Code Exchange (PKCE) is always required for authorization requests by Authorization Code Flow.
    pkceRequired: Boolean

    /// The flag to indicate whether `S256` is always required as the code challenge method whenever [PKCE (RFC 7636)] is used. If this flag is set to `true`, `plain` is not allowed as the code challenge method.
    pkceS256Required: Boolean

    /// The flag to indicate whether the client is expected to sign requests to the resource server. If this flag is set to `true`, introspection requests and userinfo requests will be checked for a signature.
    rsRequestSigned: Boolean

    /// If the DPoP is required for this client.
    dpopRequired: Boolean

    /// The flag indicating whether this client was registered by the "automatic" client registration of OIDC Federation.
    automaticallyRegistered: Boolean

    /// The flag indicating whether this client was registered by the "explicit" client registration of OIDC Federation.
    explicitlyRegistered: Boolean

    /// The key ID of a JWK containing the public key used by this client to sign requests to the resource server.
    rsSignedRequestKeyId: String

    /// The client registration types that the client has declared it may use.
    clientRegistrationTypes: ClientRegistrationTypes

    /// The human-readable name representing the organization that manages this client. This property corresponds to the `organization_name` client metadata that is defined in OpenID Connect Federation 1.0.
    organizationName: String

    /// The URI of the endpoint that returns this client's JWK Set document in the JWT format. This property corresponds to the `signed_jwks_uri` client metadata defined in OpenID Connect Federation 1.0.
    signedJwksUri: String

    /// The entity ID of this client.
    entityId: String

    /// The entity ID of the trust anchor of the trust chain that was used when this client was registered or updated by the mechanism defined in OpenID Connect Federation 1.0.
    trustAnchorId: String

    /// The trust chain that was used when this client was registered or updated by the mechanism defined in OpenID Connect Federation 1.0.
    trustChain: StringList

    /// The expiration time of the trust chain that was used when this client was registered or updated by the mechanism defined in OpenID Connect Federation 1.0. The value is represented as milliseconds since the UNIX epoch (1970-01-01).
    trustChainExpiresAt: Timestamp

    /// The time at which the trust chain was updated by the mechanism defined in OpenID Connect Federation 1.0.
    trustChainUpdatedAt: Timestamp
}

/// The client authentication method that the client application declares that it uses at the token endpoint. 
/// This property corresponds to `token_endpoint_auth_method` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
enum ClientAuthMethod {
    NONE,
    CLIENT_SECRET_BASIC,
    CLIENT_SECRET_POST,
    CLIENT_SECRET_JWT,
    PRIVATE_KEY_JWT,
    TLS_CLIENT_AUTH,
    SELF_SIGNED_TLS_CLIENT_AUTH
}

/// The client authentication method that the client application declares that it uses at the token endpoint.
/// This property corresponds to `token_endpoint_auth_method` in [OpenID Connect Dynamic Client Registration 1.0, 2. Client Metadata].
enum ClientAuthenticationMethod {
    NONE,
    CLIENT_SECRET_BASIC,
    CLIENT_SECRET_POST,
    CLIENT_SECRET_JWT,
    PRIVATE_KEY_JWT,
    TLS_CLIENT_AUTH,
    SELF_SIGNED_TLS_CLIENT_AUTH
}

structure ClientAuthorizationDeleteResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The client ID.
    clientId: Integer
    /// The API key of the service.
    serviceApiKey: Integer
    /// The subject of the user.
    subject: String
    /// The timestamp at which this record was modified.
    modifiedAt: Timestamp
    /// The scopes granted to the client application by the last authorization process.
    latestGrantedScopes: StringList
    /// The scopes granted to the client application by all the past authorization processes.
    mergedGrantedScopes: StringList
}

structure ClientAuthorizationGetListResponse {
    /// Start index of search results (inclusive).
    start: Integer
    /// End index of search results (exclusive).
    end: Integer
    /// Unique ID of a client developer.
    developer: String
    /// Unique user ID of an end-user.
    subject: String
    /// Unique ID of a client developer.
    totalCount: Integer
    /// An array of clients.
    clients: Clients
}


structure ClientAuthorizationUpdateResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
}


/// Response from the client list API.
structure ClientListResponse {
    /// The start index (inclusive) for the result set of the query.
    @required
    start: Integer

    /// The end index (exclusive) for the result set of the query.
    @required
    end: Integer

    /// The developer of the targeted client applications.
    developer: String

    /// The total count of client applications.
    @required
    totalCount: Integer

    /// The client list extracted from the database.
    @required
    clients: ClientList
}

/// Client representation (referenced in the ClientListResponse).
list ClientList {
    member: Client
}

structure ClientExtension {
    /// The set of scopes that the client application is allowed to request.
    requestableScopes: StringList
    /// The flag to indicate whether "Requestable Scopes per Client" is enabled or not.
    requestableScopesEnabled: Boolean
    /// The value of the duration of access tokens per client in seconds.
    accessTokenDuration: Integer
    /// The value of the duration of refresh tokens per client in seconds.
    refreshTokenDuration: Integer
    /// The flag indicating whether the client is explicitly given permission to make token exchange requests (RFC 8693).
    tokenExchangePermitted: Boolean
}

structure ClientExtensionRequestableScopesGetResponse {
    /// List of requestable scopes for the client.
    requestableScopes: StringList
}
structure ClientExtensionRequestableScopesUpdateRequest {
    /// The set of scopes that the client application is allowed to request.
    requestableScopes: StringList
}

structure ClientFlagUpdateRequest {
    /// The flag value to be set.
    clientLocked: Boolean
}

structure ClientFlagUpdateResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
}

structure ClientGetListResponse {
    /// The developer of the client applications. If the request did not contain `developer` request parameter, this property is set to `null`.
    developer: String
    /// Start index (inclusive) of the result set of the query.
    start: Integer
    /// End index (exclusive) of the result set of the query.
    end: Integer
    /// Total number of clients that belong to the service. This doesn’t mean the number of clients contained in the response.
    totalCount: Integer
    /// An array of clients.
    clients: Clients
}

structure ClientGrantedScopesDeleteResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
}

structure ClientGrantedScopesGetResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The API key of the service.
    serviceApiKey: Integer
    /// The client ID.
    clientId: Integer
    /// The subject (= unique identifier) of the user who has granted authorization to the client.
    subject: String
    /// The scopes granted to the client application by the last authorization process by the user (who is identified by the subject). `null` means that there is no record about granted scopes. An empty set means that no scopes were granted.
    latestGrantedScopes: StringList
    /// The scopes granted to the client application by all the past authorization processes. Note that revoked scopes are not included.
    mergedGrantedScopes: StringList
    /// The timestamp in milliseconds since Unix epoch at which this record was modified.
    modifiedAt: Integer
}

structure ClientRegistrationDeleteRequest {
    /// Client ID.
    clientId: String
    /// Client registration access token.
    token: String
}

structure ClientRegistrationDeleteResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: ClientRegistrationDeleteResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String
    /// The client information.
    client: Client
}
    enum ClientRegistrationDeleteResponseAction {
    INTERNAL_SERVER_ERROR,
    BAD_REQUEST,
    DELETED,
    UNAUTHORIZED
}



structure ClientRegistrationGetRequest {
    /// Client ID.
    clientId: String
    /// Client registration access token.
    token: String
}

structure ClientRegistrationGetResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String
    /// The client information.
    client: Client
}
    /// The next action that the authorization server implementation should take.
    enum ClientRegistrationGetResponseAction {
        INTERNAL_SERVER_ERROR,
        BAD_REQUEST,
        OK,
        UNAUTHORIZED
    }


structure ClientRegistrationRequest {
    /// Client metadata in JSON format that complies with [RFC 7591](https://datatracker.ietf.org/doc/html/rfc7591) (OAuth 2.0 Dynamic Client Registration Protocol).
    json: String
    /// The client registration access token. Used only for GET, UPDATE, and DELETE requests.
    token: String
    /// The client's identifier. Used for GET, UPDATE, and DELETE requests.
    clientId: String
}

structure ClientRegistrationResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: ClientRegistrationResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String
    /// The client information.
    client: Client

}
    enum ClientRegistrationResponseAction {
    INTERNAL_SERVER_ERROR,
    BAD_REQUEST,
    CREATED
}


//Values for the `client_registration_types` RP metadata and the  `client_registration_types_supported` OP metadata that are defined in  [OpenID Connect Federation 1.0](https://openid.net/specs/openid-connect-federation-1_0
enum ClientRegistrationType {
    /// Automatic client registration type.
    AUTOMATIC,
    /// Explicit client registration type.
    EXPLICIT
}

structure ClientRegistrationUpdateRequest {
    /// Client ID.
    clientId: String
    /// Client registration access token.
    token: String
    /// Client metadata in JSON format that complies with [RFC 7591](https://datatracker.ietf.org/doc/html/rfc7591) (OAuth 2.0 Dynamic Client Registration Protocol).
    json: String
}

structure ClientRegistrationUpdateResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: ClientRegistrationUpdateResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String
    /// The client information.
    client: Client

}

  enum ClientRegistrationUpdateResponseAction {
    INTERNAL_SERVER_ERROR,
    BAD_REQUEST,
    UPDATED,
    UNAUTHORIZED
}


structure ClientSecretRefreshResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The new client secret.
    newClientSecret: String
    /// The old client secret.
    oldClientSecret: String
}

structure ClientSecretUpdateRequest {
    /// The new value of the client secret. Valid characters for a client secret are `A-Z`, `a-z`, `0-9`, `-`, and `_`. The maximum length of a client secret is 86.
    clientSecret: String
}

structure ClientSecretUpdateResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The new client secret.
    newClientSecret: String
    /// The old client secret.
    oldClientSecret: String
}

///The client type, either `CONFIDENTIAL` or `PUBLIC`. See [RFC 6749, 2.1. Client Types](https://datatracker.ietf.org/doc/html/rfc6749#section-2.1) for details. 
enum ClientType {
    /// Public client type.
    PUBLIC,
    /// Confidential client type.
    CONFIDENTIAL
}

enum DeliveryMode {
    /// Delivery mode for Ping.
    PING,
    /// Delivery mode for Poll.
    POLL,
    /// Delivery mode for Push.
    PUSH
}

structure DeviceAuthorizationRequest {
    /// Parameters of a device authorization request which are the request parameters that the device authorization endpoint of the authorization server implementation received from the client application.
    parameters: String
    /// The client ID extracted from Authorization header of the device authorization request from the client application. If the device authorization endpoint of the authorization server implementation did not receive `Authorization` header, this property will be `null`.
    clientId: String
    /// The client secret extracted from `Authorization` header of the device authorization request from the client application. If the device authorization endpoint of the authorization server implementation did not receive `Authorization` header, this property will be `null`.
    clientSecret: String
    /// The client certificate used in the TLS connection between the client application and the device authorization endpoint of the authorization server.
    clientCertificate: String
    /// The client certificate path presented by the client during client authentication. Each element is a string in PEM format.
    clientCertificatePath: String
}

structure DeviceAuthorizationResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: DeviceAuthorizationResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String
    /// The client ID of the client application that has made the device authorization request.
    clientId: Integer
    /// The client ID alias of the client application that has made the device authorization request.
    clientIdAlias: String
    /// `true` if the value of the client_id request parameter included in the device authorization request is the client ID alias. `false` if the value is the original numeric client ID.
    clientIdAliasUsed: Boolean
    /// The name of the client application which has made the device authorization request.
    clientName: String
    /// The client authentication method that should be performed at the device authorization endpoint.
    clientAuthMethod: String
    /// The scopes requested by the device authorization request.
    scopes: Scopes
    /// The names of the claims which were requested indirectly via some special scopes.
    claimNames: StringList
    /// The list of ACR values requested by the device authorization request.
    acrs: StringList
    /// The device verification code. This corresponds to the `device_code` property in the response to the client.
    deviceCode: String
    /// The end-user verification code. This corresponds to the `user_code` property in the response to the client.
    userCode: String
    /// The end-user verification URI. This corresponds to the `verification_uri` property in the response to the client.
    verificationUri: String
    /// The end-user verification URI that includes the end-user verification code. This corresponds to the `verification_uri_complete` property in the response to the client.
    verificationUriComplete: String
    /// The duration of the device verification code in seconds. This corresponds to the `expires_in` property in the response to the client.
    expiresIn: Integer
    /// The minimum amount of time in seconds that the client must wait for between polling requests to the token endpoint. This corresponds to the `interval` property in the response to the client.
    interval: Integer
    /// The warnings raised during processing the backchannel authentication request.
    warnings: StringList
    /// The resources specified by the `resource` request parameters.
    resources: StringList
    /// The authorization details.
    authorizationDetails: AuthzDetails
    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs
    /// The attributes of the client.
    clientAttributes: Pairs
    /// The dynamic scopes which the client application requested by the scope request parameter.
    dynamicScopes: DynamicScopes
    /// The grant management action.
    gmAction: GrantManagementAction
    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String
    /// The grant.
    grant: Grant
    /// The subject identifying the user who has given the grant identified by the `grant_id` request parameter of the device authorization request.
    grantSubject: String
    /// The entity ID of the client.
    clientEntityId: String
    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}
list Scopes{
    member:Scope
}
    enum DeviceAuthorizationResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR,
    /// Bad request action.
    BAD_REQUEST,
    /// Unauthorized action.
    UNAUTHORIZED,
    /// OK action.
    OK
}



structure DeviceCompleteRequest {
    /// A user code.
    userCode: String
    /// The result of the end-user authentication and authorization.
    result: DeviceCompleteRequestResult
    /// The subject (= unique identifier) of the end-user.
    subject: String
    /// The value of the sub claim that should be used in the ID token.
    sub: String
    /// The time at which the end-user was authenticated. Its value is the number of seconds from `1970-01-01`.
    authTime: Long
    /// The reference of the authentication context class which the end-user authentication satisfied.
    acr: String
    /// Additional claims which will be embedded in the ID token.
    claims: String
    /// The extra properties associated with the access token.
    properties: Properties
    /// Scopes to replace the scopes specified in the original device authorization request with.
    scopes: StringList
    /// The description of the error. If this optional request parameter is given, its value is used as the value of the `error_description` property, but it is used only when the result is not `AUTHORIZED`.
    errorDescription: String
    /// The URI of a document which describes the error in detail. This corresponds to the `error_uri` property in the response to the client.
    errorUri: String
    /// JSON that represents additional JWS header parameters for ID tokens.
    idtHeaderParams: String
    /// The claims that the user has consented for the client application to know.
    consentedClaims: StringList
    /// Additional claims that are added to the payload part of the JWT access token.
    jwtAtClaims: String
}
    enum DeviceCompleteRequestResult {
    /// Transaction failed result.
    TRANSACTION_FAILED,
    /// Access denied result.
    ACCESS_DENIED,
    /// Authorized result.
    AUTHORIZED
}

structure DeviceCompleteResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: DeviceCompleteResponseAction

}
    enum DeviceCompleteResponseAction {
    /// Server error action.
    SERVER_ERROR,
    /// User code not exist action.
    USER_CODE_NOT_EXIST,
    /// User code expired action.
    USER_CODE_EXPIRED,
    /// Invalid request action.
    INVALID_REQUEST,
    /// Success action.
    SUCCESS
}


structure DeviceVerificationRequest {
    /// A user code.
    userCode: String
}

structure DeviceVerificationResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: DeviceVerificationResponseAction
    /// The client ID of the client application to which the user code has been issued.
    clientId: Integer
    /// The client ID alias of the client application to which the user code has been issued.
    clientIdAlias: String
    /// `true` if the value of the `client_id` request parameter included in the device authorization request is the client ID alias. `false` if the value is the original numeric client ID.
    clientIdAliasUsed: Boolean
    /// The name of the client application to which the user code has been issued.
    clientName: String
    /// The scopes requested by the device authorization request.
    scopes: Scopes
    /// The names of the claims which were requested indirectly via some special scopes.
    claimNames: StringList
    /// The list of ACR values requested by the device authorization request.
    acrs: StringList
    /// The resources specified by the `resource` request parameters or by the `resource` property in the request object.
    resources: StringList
    /// The authorization details.
    authorizationDetails: AuthzDetails
    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs
    /// The attributes of the client.
    clientAttributes: Pairs
    /// The dynamic scopes which the client application requested by the scope request parameter.
    dynamicScopes: DynamicScopes
    /// Get the date in milliseconds since the Unix epoch (1970-01-01) at which the user code will expire.
    expiresAt: Long
    /// The grant management action.
    gmAction: GrantManagementAction
    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String
    /// The grant.
    grant: Grant
    /// The subject identifying the user who has given the grant identified by the `grant_id` request parameter of the device authorization request.
    grantSubject: String
    /// The entity ID of the client.
    clientEntityId: String
    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}
    /// The next action that the authorization server implementation should take.
enum DeviceVerificationResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR,
    /// Not exist action.
    NOT_EXIST,
    /// Expired action.
    EXPIRED,
    /// Valid action.
    VALID
}



/// The display mode which the client application requests by `display` request parameter.
enum Display {
    /// Page display mode.
    PAGE,
    /// Popup display mode.
    POPUP,
    /// Touch display mode.
    TOUCH,
    /// Wap display mode.
    WAP
}

structure DynamicScope {
    /// The scope name.
    name: String
    /// The scope value.
    value: String
}

structure FederationConfigurationResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: FederationConfigurationResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String


}
    /// The next action that the authorization server implementation should take.
enum FederationConfigurationResponseAction {
    /// Ok action.
    OK,
    /// Not found action.
    NOT_FOUND,
    /// Internal server error action.
    INTERNAL_SERVER_ERROR
}



structure FederationRegistrationRequest {
    /// The entity configuration of a relying party.
    entityConfiguration: String
    /// The trust chain of a relying party.
    trustChain: String
}

structure FederationRegistrationResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: FederationRegistrationResponseAction
    /// The content that the authorization server implementation can use as the value of `WWW-Authenticate` header on errors.
    responseContent: String
    /// The client details.
    client: Client

}
    /// The next action that the authorization server implementation should take.
enum FederationRegistrationResponseAction {
    /// Ok action.
    OK,
    /// Bad request action.
    BAD_REQUEST,
    /// Not found action.
    NOT_FOUND,
    /// Internal server error action.
    INTERNAL_SERVER_ERROR
}


structure GMRequest {
    /// An access token to introspect.
    accessToken: String
    /// A string array listing names of scopes which the caller (= a protected resource endpoint of the service) requires.
    scopes: StringList
    /// A subject (= a user account managed by the service) whom the caller (= a protected resource endpoint of the service) requires.
    subject: String
    /// Client certificate in PEM format, used to validate binding against access tokens using the TLS client certificate confirmation method.
    clientCertificate: String
    /// `DPoP` header presented by the client during the request to the resource server. The header contains a signed JWT which includes the public key paired with the private key used to sign the JWT.
    dpop: String
    /// HTTP method of the request from the client to the protected resource endpoint. This field is used to validate the `DPoP` header.
    htm: String
    /// URL of the protected resource endpoint. This field is used to validate the `DPoP` header.
    htu: String
    /// The resources specified by the `resource` request parameters in the token request.
    resources: StringList
    /// The grant management action.
    gmAction: GrantManagementAction
    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String
}

structure GMResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: GMResponseAction
    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    responseContent: String

}
    /// The next action that the authorization server implementation should take.
enum GMResponseAction {
    /// Ok action.
    OK,
    /// No content action.
    NO_CONTENT,
    /// Unauthorized action.
    UNAUTHORIZED,
    /// Forbidden action.
    FORBIDDEN,
    /// Not found action.
    NOT_FOUND,
    /// Caller error action.
    CALLER_ERROR,
    /// Authlete error action.
    AUTHLETE_ERROR
}



structure Grant {
    /// The scopes associated with the Grant.
    scopes: GrantScopes
    /// The claims associated with the Grant.
    claims: StringList
    /// The authorization details associated with the Grant.
    authorizationDetails: AuthzDetails
}


//The grant management action of the device authorization request.  The `grant_management_action` request parameter is defined in [Grant Management for OAuth 2.0](https://openid.net/specs/fapi-grant-management.html). 
enum GrantManagementAction {
    /// Create action.
    CREATE,
    /// Query action.
    QUERY,
    /// Replace action.
    REPLACE,
    /// Revoke action.
    REVOKE,
    /// Merge action.
    MERGE
}


structure GrantScope {
    /// Space-delimited scopes.
    scope: String
    /// List of resource indicators.
    resource: StringList
}

//The grant type of the access token when the access token was created. 
enum GrantType {
    /// Authorization code grant type.
    AUTHORIZATION_CODE,
    /// Implicit grant type.
    IMPLICIT,
    /// Password grant type.
    PASSWORD,
    /// Client credentials grant type.
    CLIENT_CREDENTIALS,
    /// Refresh token grant type.
    REFRESH_TOKEN,
    /// CIBA grant type.
    CIBA,
    /// Device code grant type.
    DEVICE_CODE,
    /// Token exchange grant type.
    TOKEN_EXCHANGE,
    /// JWT bearer grant type.
    JWT_BEARER
}

///Holds information about a key managed in an HSM (Hardware Security Module) 
structure Hsk {
    /// The key type (EC or RSA).
    kty: String
    /// The use of the key on the HSM (Hardware Security Module). When the key use is "sig" (signature), the private key on the HSM is used to sign data and the corresponding public key is used to verify the signature. When the key use is "enc" (encryption), the public key on the HSM is used to encrypt data and the corresponding private key is used to decrypt the data.
    use: String
    /// Key ID for the key on the HSM.
    kid: String
    /// The name of the HSM. The identifier for the HSM that sits behind the Authlete server. For example, "google".
    hsmName: String
    /// The handle for the key on the HSM. A handle is a base64url-encoded 256-bit random value (43 letters) which is assigned by Authlete on the call of the /api/hsk/create API.
    handle: String
    /// The public key that corresponds to the key on the HSM.
    publicKey: String
}

structure HskCreateRequest {
    /// The key type (EC or RSA).
    kty: String
    /// The use of the key on the HSM (Hardware Security Module). When the key use is "sig" (signature), the private key on the HSM is used to sign data and the corresponding public key is used to verify the signature. When the key use is "enc" (encryption), the public key on the HSM is used to encrypt data and the corresponding private key is used to decrypt the data.
    use: String
    /// Key ID for the key on the HSM.
    kid: String
    /// The name of the HSM. The identifier for the HSM that sits behind the Authlete server. For example, "google".
    hsmName: String
    /// The handle for the key on the HSM. A handle is a base64url-encoded 256-bit random value (43 letters) which is assigned by Authlete on the call of the /api/hsk/create API.
    handle: String
    /// The public key that corresponds to the key on the HSM.
    publicKey: String
}

structure HskGetListResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The action result of the API call.
    action: HskGetListResponseAction
    /// List of HSK.
    hsks: Hsks
}
    enum HskGetListResponseAction {
    /// Success action.
    SUCCESS,
    /// Invalid request action.
    INVALID_REQUEST,
    /// Server error action.
    SERVER_ERROR
}


structure HskGetResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The action result of the API call.
    action: HskGetResponseAction
    /// The HSK (Hardware Security Key) information.
    hsk: Hsk

}
    enum HskGetResponseAction {
    /// Success action.
    SUCCESS,
    /// Invalid request action.
    INVALID_REQUEST,
    /// Not found action.
    NOT_FOUND,
    /// Server error action.
    SERVER_ERROR
}


structure InfoResponse {
    /// The server version.
    version: String
    /// The features that the server supports.
    features: StringList
}

structure IntrospectionRequest {
    /// An access token to introspect.
    token: String
    /// A string array listing names of scopes which the caller (= a protected resource endpoint of the service) requires.
    scopes: StringList
    /// A subject (= a user account managed by the service) whom the caller (= a protected resource endpoint of the service) requires.
    subject: String
    /// Client certificate in PEM format, used to validate binding against access tokens using the TLS client certificate confirmation method.
    clientCertificate: String
    /// DPoP header presented by the client during the request to the resource server. The header contains a signed JWT which includes the public key that is paired with the private key used to sign the header.
    dpop: String
    /// HTTP method of the request from the client to the protected resource endpoint. This field is used to validate the DPoP header.
    htm: String
    /// URL of the protected resource endpoint. This field is used to validate the DPoP header.
    htu: String
    /// The resources specified by the resource request parameters in the token request. See "Resource Indicators for OAuth 2.0" for details.
    resources: StringList
    /// Authentication Context Class Reference values one of which the user authentication performed during the course of issuing the access token must satisfy.
    acrValues: StringList
    /// The maximum authentication age which is the maximum allowable elapsed time since the user authentication was performed during the course of issuing the access token.
    maxAge: Integer
    /// HTTP Message Components required to be in the signature. If absent, defaults to [ "@method", "@target-uri", "authorization" ].
    requiredComponents: StringList
    /// The full URL of the userinfo endpoint.
    uri: String
    /// The HTTP message body of the request, if present.
    message: String
    /// HTTP headers to be included in processing the signature. If this is a signed request, this must include the Signature and Signature-Input headers, as well as any additional headers covered by the signature.
    headers: Pairs
}

structure IntrospectionResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The next action that the authorization server implementation should take.
    action: IntrospectionResponseAction
    /// The content that the authorization server implementation can use as the value of `WWW-Authenticate` header on errors.
    responseContent: String
    /// The client ID.
    clientId: Integer
    /// The client ID alias when the token request was made. If the client did not have an alias, this parameter is `null`.
    clientIdAlias: String
    /// The flag which indicates whether the client ID alias was used when the token request was made.
    clientIdAliasUsed: Boolean
    /// The time at which the access token expires. The value is represented in milliseconds since the Unix epoch (1970-01-01).
    expiresAt: Integer
    /// The subject who is associated with the access token. The value of this property is `null` if the access token was issued using the flow of Client Credentials Grant.
    subject: String
    /// The scopes covered by the access token.
    scopes: StringList
    /// `true` if the access token exists.
    existent: Boolean
    /// `true` if the access token is usable (= exists and has not expired).
    usable: Boolean
    /// `true` if the access token is usable (= exists and has not expired).
    sufficient: Boolean
    /// `true` if the access token can be refreshed using the associated refresh token which had been issued along with the access token.
    refreshable: Boolean
    /// The extra properties associated with the access token.
    properties: Properties
    /// The client certificate thumbprint used to validate the access token.
    certificateThumbprint: String
    /// The target resources. This represents the resources specified by the `resource` request parameters or by the `resource` property in the request object.
    resources: StringList
    /// The target resources. This property holds the resources specified by the `resource` request parameters or by the `resource` property in the request object.
    accessTokenResources: StringList
    /// The authorization details.
    authorizationDetails: AuthzDetails
    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs
    /// The attributes of the client.
    clientAttributes: Pairs
    /// The scope details. This property conveys information about scope attributes.
    scopeDetails: Scopes
    /// The value of the `grant_id` request parameter of the device authorization request.
    grantId: String
    /// The grant details.
    grant: Grant
    /// The flag which indicates whether the access token is for an external attachment.
    forExternalAttachment: Boolean
    /// The claims that the user has consented for the client application to know.
    consentedClaims: StringList
    /// The grant type.
    grantType: GrantType
    /// The Authentication Context Class Reference of the user authentication that the authorization server performed during the course of issuing the access token.
    acr: String
    /// The time when the user authentication was performed during the course of issuing the access token.
    authTime: Integer
    /// The entity ID of the client.
    clientEntityId: String
    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}
    enum IntrospectionResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR,
    /// Bad request action.
    BAD_REQUEST,
    /// Unauthorized action.
    UNAUTHORIZED,
    /// Forbidden action.
    FORBIDDEN,
    /// OK action.
    OK
}


structure ServiceConfigurationRequest {


    pretty: Boolean

    patch: String
}



//Response from Authlete's {@code /service/get/list} API.

@since("1.2")
structure ServiceListResponse {

    @documentation("The start index (inclusive) for the result set of the query.")
    start: Integer

    @documentation("The end index (exclusive) for the result set of the query.")
    end: Integer

    @documentation("The total count of services.")
    totalCount: Integer

    @documentation("The service list extracted from the database.")
    services: Services
}


structure StandardIntrospectionRequest {
    @documentation("""
    Request parameters which comply with the introspection request defined in
    "[2.1. Introspection Request](https://datatracker.ietf.org/doc/html/rfc7662#section-2.1)"
    in RFC 7662. The implementation of the introspection endpoint of your authorization server
    will receive an HTTP POST [[RFC 7231](https://datatracker.ietf.org/doc/html/rfc7231)] request
    with parameters in the `application/x-www-form-urlencoded` format. It is the entity body
    of the request that Authlete's `/api/auth/introspection/standard` API expects as the value of `parameters`.
    """)
    parameters: String

    @documentation("""
    Flag indicating whether to include hidden properties in the output.
    Authlete has a mechanism whereby to associate arbitrary key-value pairs with an access token.
    Each key-value pair has a hidden attribute. By default, key-value pairs whose hidden attribute
    is set to `true` are not embedded in the standard introspection output. If the `withHiddenProperties`
    request parameter is given and its value is `true`, `/api/auth/introspection/standard` API includes
    all the associated key-value pairs into the output regardless of the value of the hidden attribute.
    """)
    withHiddenProperties: String
}


structure JoseVerifyRequest {
    /// A JOSE object.
    jose: String
    /// Mandatory claims that are required to be included in the JOSE object.
    mandatoryClaims: String
    /// Allowable clock skew in seconds.
    clockSkew: Integer
    /// The identifier of the client application whose keys are required for verification of the JOSE object.
    clientIdentifier: String
    /// The flag which indicates whether the signature of the JOSE object has been signed by a client application with the client’s private key or a shared symmetric key.
    signedByClient: Boolean
}


structure JoseVerifyResponse {
    /// The code which represents the result of the API call.
    resultCode: String
    /// A short message which explains the result of the API call.
    resultMessage: String
    /// The result of the verification on the JOSE object.
    valid: Boolean
    /// The result of the signature verification.
    signatureValid: Boolean
    /// The list of missing claims.
    missingClaims: StringList
    /// The list of invalid claims.
    invalidClaims: StringList
    /// The list of error messages.
    errorDescriptions: StringList
}

enum JweAlg {
    /// RSA1_5 encryption algorithm.
    RSA1_5,
    /// RSA_OAEP encryption algorithm.
    RSA_OAEP,
    /// RSA_OAEP_256 encryption algorithm.
    RSA_OAEP_256,
    /// A128KW encryption algorithm.
    A128KW,
    /// A192KW encryption algorithm.
    A192KW,
    /// A256KW encryption algorithm.
    A256KW,
    /// DIR encryption algorithm.
    DIR,
    /// ECDH_ES encryption algorithm.
    ECDH_ES,
    /// ECDH_ES_A128KW encryption algorithm.
    ECDH_ES_A128KW,
    /// ECDH_ES_A192KW encryption algorithm.
    ECDH_ES_A192KW,
    /// ECDH_ES_A256KW encryption algorithm.
    ECDH_ES_A256KW,
    /// A128GCMKW encryption algorithm.
    A128GCMKW,
    /// A192GCMKW encryption algorithm.
    A192GCMKW,
    /// A256GCMKW encryption algorithm.
    A256GCMKW,
    /// PBES2_HS256_A128KW encryption algorithm.
    PBES2_HS256_A128KW,
    /// PBES2_HS384_A192KW encryption algorithm.
    PBES2_HS384_A192KW,
    /// PBES2_HS512_A256KW encryption algorithm.
    PBES2_HS512_A256KW
}

//This is the encryption algorithm to be used when encrypting a JWT on client or server side. Depending upon the context, this refers to encryption done by the client or by the server. For instance:   - as `authorizationEncryptionEnc` value, it refers to the encryption algorithm used by server when creating a JARM response   - as `requestEncryptionEnc` value, it refers to the expected encryption algorithm used by the client when encrypting a Request Object   - as `idTokenEncryptionEnc` value, it refers to the algorithm used by the server to encrypt id_
enum JweEnc {
    /// AES_128_CBC_HMAC_SHA_256 encryption algorithm.
    A128CBC_HS256,
    /// AES_192_CBC_HMAC_SHA_384 encryption algorithm.
    A192CBC_HS384,
    /// AES_256_CBC_HMAC_SHA_512 encryption algorithm.
    A256CBC_HS512,
    /// AES_128_GCM encryption algorithm.
    A128GCM,
    /// AES_192_GCM encryption algorithm.
    A192GCM,
    /// AES_256_GCM encryption algorithm.
    A256GCM
}

//The signature algorithm for JWT. This value is represented on \'alg\' attribute of the header of JWT.  it\'s semantics depends upon where is this defined, for instance:   - as service accessTokenSignAlg value, it defines that access token are JWT and the algorithm used to sign it. Check your [KB article](https://kb.authlete.com/en/s/oauth-and-openid-connect/a/jwt-based-access-token).   - as client authorizationSignAlg value, it represents the signature algorithm used when [creating a JARM response](https://kb.authlete.com/en/s/oauth-and-openid-connect/a/enabling-jarm).   - or as client requestSignAlg value, it specifies which is the expected signature used by [client on a Request Object](https://kb.authlete.com/en/s/oauth-and-openid-connect/a/request-objects). 

enum JwsAlg {
    /// No digital signature or MAC performed.
    NONE,
    /// HMAC using SHA-256.
    HS256,
    /// HMAC using SHA-384.
    HS384,
    /// HMAC using SHA-512.
    HS512,
    /// RSASSA-PKCS1-v1_5 using SHA-256.
    RS256,
    /// RSASSA-PKCS1-v1_5 using SHA-384.
    RS384,
    /// RSASSA-PKCS1-v1_5 using SHA-512.
    RS512,
    /// ECDSA using P-256 and SHA-256.
    ES256,
    /// ECDSA using P-384 and SHA-384.
    ES384,
    /// ECDSA using P-521 and SHA-512.
    ES512,
    /// RSASSA-PSS using SHA-256 and MGF1 with SHA-256.
    PS256,
    /// RSASSA-PSS using SHA-384 and MGF1 with SHA-384.
    PS384,
    /// RSASSA-PSS using SHA-512 and MGF1 with SHA-512.
    PS512,
    /// ECDSA using secp256k1 curve and SHA-256.
    ES256K,
    /// Edwards-curve Digital Signature Algorithm.
    EDDSA
}

structure NamedUri {
    /// The name associated with the URI.
    
    name: String

    /// The URI.
    
    uri: String
}

structure Pair {
    /// The key part.
    
    key: String

    /// The value part.
    
    value: String
}

//The prompt that the UI displayed to the end-user must satisfy as the minimum level. This value comes from `prompt` request parameter.  When the authorization request does not contain `prompt` request parameter, `CONSENT` is used as the default value.  See \"[OpenID Connect Core 1.0, 3.1.2.1. Authentication Request](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest), prompt\" for `prompt` request parameter. 
enum Prompt {
    /// No prompt.
    NONE,
    /// Prompt for login.
    LOGIN,
    /// Prompt for consent.
    CONSENT,
    /// Prompt to select an account.
    SELECT_ACCOUNT
}

structure Property {
    /// The key part.
    
    key: String

    /// The value part.
    
    value: String

    /// The flag to indicate whether this property is hidden from or visible to client applications.
    
    hidden: Boolean
}

structure PushedAuthReqRequest {
    /// The pushed authorization request body received from the client application.
    @required
    parameters: String

    /// The client ID extracted from `Authorization` header of the pushed request from the client application.
    
    clientId: String

    /// The client secret extracted from `Authorization` header of the pushed authorization request from the client application.
    
    clientSecret: String

    /// The client certificate from the MTLS connection to pushed authorization endpoint from the client application.
    
    clientCertificate: String

    /// The certificate path presented by the client during client authentication. These certificates are strings in PEM format.
    
    clientCertificatePath: String
}


structure PushedAuthReqResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take. Any other value other than `CREATED` should be handled as an unsuccessful result.
    
    action: PushedAuthReqResponseAction

    /// The request_uri created to the client to be used as request_uri on the authorize call.
    
    requestUri: String

    /// The content that the authorization server implementation is to return to the client application.
    
    responseContent: String

}
    /// Enum representing the possible actions in the response.
enum PushedAuthReqResponseAction {
    CREATED,
    BAD_REQUEST,
    UNAUTHORIZED,
    FORBIDDEN,
    PAYLOAD_TOO_LARGE,
    INTERNAL_SERVER_ERROR
}


structure PushedAuthorizationRequest {
    /// The pushed authorization request body received from the client application.
    @required
    parameters: String

    /// The client ID extracted from `Authorization` header of the pushed request from the client application.
    
    clientId: String

    /// The client secret extracted from `Authorization` header of the pushed authorization request from the client application.
    
    clientSecret: String

    /// The client certificate from the MTLS connection to pushed authorization endpoint from the client application.
    
    clientCertificate: String

    /// The certificate path presented by the client during client authentication. These certificates are strings in PEM format.
    
    clientCertificatePath: String

    /// DPoP Header.
    
    dpop: String

    /// HTTP Method (for DPoP validation).
    
    htm: String

    /// HTTP URL base (for DPoP validation).
    
    htu: String
}

structure PushedAuthorizationResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take. Any other value other than "CREATED" should be handled as an unsuccessful result.
    
    action: PushedAuthorizationResponseActionEnum

    /// The request_uri created to the client to be used as request_uri on the authorize call.
    
    requestUri: String

    /// The content that the authorization server implementation is to return to the client application.
    
    responseContent: String
}
    /// Enum representing the possible actions in the response.
enum PushedAuthorizationResponseActionEnum {
    CREATED,
    BAD_REQUEST,
    UNAUTHORIZED,
    FORBIDDEN,
    PAYLOAD_TOO_LARGE,
    INTERNAL_SERVER_ERROR
}



enum ResponseType {
    /// No response type.
    NONE,
    /// Authorization code.
    CODE,
    /// Access token.
    TOKEN,
    /// ID token.
    ID_TOKEN,
    /// Authorization code and access token.
    CODE_TOKEN,
    /// Authorization code and ID token.
    CODE_ID_TOKEN,
    /// ID token and access token.
    ID_TOKEN_TOKEN,
    /// Authorization code, ID token, and access token.
    CODE_ID_TOKEN_TOKEN
}

structure Result {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String
}

structure RevocationRequest {
    /// OAuth 2.0 token revocation request parameters which are the request parameters that the OAuth 2.0 token revocation endpoint ([RFC 7009](https://datatracker.ietf.org/doc/html/rfc7009)) of the authorization server receives.
    @required
    parameters: String

    /// The client ID extracted from `Authorization` header of the revocation request from the client application.
    
    clientId: String

    /// The client secret extracted from `Authorization` header of the revocation request from the client application.
    
    clientSecret: String

    /// The client certificate used in the TLS connection between the client application and the revocation endpoint.
    
    clientCertificate: String

    /// The certificate path presented by the client during client authentication.
    
    clientCertificatePath: String
}

structure RevocationResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: RevocationResponseAction

    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    
    responseContent: String

}
    /// Enum representing the possible actions in the response.
enum RevocationResponseAction {
    INTERNAL_SERVER_ERROR,
    INVALID_CLIENT,
    BAD_REQUEST,
    OK
}



structure Scope {
    /// The name of the scope.
    
    name: String

    /// `true` to mark the scope as default. Scopes marked as default are regarded as requested when an authorization request from a client application does not contain scope request parameter.
    
    defaultEntry: Boolean

    /// The description about the scope.
    
    description: String

    /// The descriptions about this scope in multiple languages.
    
    descriptions: TaggedValues

    /// The attributes of the scope.
    
    attributes: Pairs
}

structure Service {
    /// The sequential number of the service. The value of this property is assigned by Authlete.
    ////@readonly
    number: Integer

    /// The sequential number of the service owner of the service. The value of this property is assigned by Authlete.
    ////@readonly
    serviceOwnerNumber: Integer

    /// The name of this service.
    serviceName: String

    /// The issuer identifier of the service.
    issuer: String

    /// The description about the service.
    description: String

    /// The API key. The value of this property is assigned by Authlete.
    ////@readonly
    apiKey: Integer

    /// The API secret. A random 256-bit value encoded by base64url (43 letters). The value of this property is assigned by Authlete.
    ////@readonly
    apiSecret: String

    /// The maximum number of client applications that a developer is allowed to create. `0` means no limit.
    ////@readonly
    clientsPerDeveloper: Integer

    /// The flag to indicate whether the 'Client ID Alias' feature is enabled or not.
    clientIdAliasEnabled: Boolean

    /// The `metadata` of the service. The content of the returned array depends on contexts.
    metadata: Pairs

    /// The time at which this service was created. The value is represented as milliseconds since the UNIX epoch (`1970-01-01`).
    ////@readonly
    createdAt: Timestamp

    /// The time at which this service was last modified. The value is represented as milliseconds since the UNIX epoch (`1970-01-01`).
    ////@readonly
    modifiedAt: Timestamp

    /// A Web API endpoint for user authentication which is to be prepared on the service side.
    authenticationCallbackEndpoint: String

    /// API key for basic authentication at the authentication callback endpoint.
    authenticationCallbackApiKey: String

    /// API secret for basic authentication at the authentication callback endpoint.
    authenticationCallbackApiSecret: String

    /// SNSes you want to support 'social login' in the UI at the authorization endpoint provided by Authlete.
    supportedSnses: SnsList

    /// `SNS` credentials which Authlete uses to make requests to SNSes.
    snsCredentials: SnsCredentialsList

    /// Values of acrs (authentication context class references) that the service supports.
    ////@readonly
    supportedAcrs: StringList

    /// A Web API endpoint for developer authentication which is to be prepared on the server side.
    developerAuthenticationCallbackEndpoint: String

    /// API key for basic authentication at the developer authentication callback endpoint.
    developerAuthenticationCallbackApiKey: String

    /// API secret for basic authentication at the developer authentication callback endpoint.
    developerAuthenticationCallbackApiSecret: String

    /// SNSes you want to support 'social login' in the login page of Developer Console provided by Authlete.
    supportedDeveloperSnses: SnsList

    /// SNS credentials which Authlete uses to make requests to SNSes.
    developerSnsCredentials: SnsCredentialsList

    /// Values of `grant_type` request parameter that the service supports.
    supportedGrantTypes: GrantTypes

    /// Values of `response_type` request parameter that the service supports.
    supportedResponseTypes: ResponseTypes

    /// The supported data types that can be used as values of the type field in `authorization_details`.
    supportedAuthorizationDetailsTypes: StringList

    /// The profiles that this service supports.
    supportedServiceProfiles: ServiceProfiles

    /// The flag to indicate whether the `error_description` response parameter is omitted.
    errorDescriptionOmitted: Boolean

    /// The flag to indicate whether the `error_uri` response parameter is omitted.
    errorUriOmitted: Boolean

    /// The authorization endpoint of the service.
    authorizationEndpoint: String

    /// The flag to indicate whether the direct authorization endpoint is enabled or not.
    directAuthorizationEndpointEnabled: Boolean

    /// UI locales that the service supports.
    supportedUiLocales: StringList

    /// Values of `display` request parameter that service supports.
    supportedDisplays: Displays

    /// The flag to indicate whether the use of Proof Key for Code Exchange (PKCE) is always required for authorization requests by Authorization Code Flow.
    pkceRequired: Boolean

    /// The flag to indicate whether `S256` is always required as the code challenge method whenever PKCE is used.
    pkceS256Required: Boolean

    /// The duration of authorization response JWTs in seconds.
    authorizationResponseDuration: Integer

    /// The token endpoint of the service.
    tokenEndpoint: String

    /// The flag to indicate whether the direct token endpoint is enabled or not.
    directTokenEndpointEnabled: Boolean

    /// Client authentication methods supported by the token endpoint of the service.
    supportedTokenAuthMethods: ClientAuthMethods

    /// The flag to indicate token requests from public clients without the `client_id` request parameter are allowed when the client can be guessed from `authorization_code` or `refresh_token`.
    missingClientIdAllowed: Boolean

    /// The revocation endpoint of the service.
    revocationEndpoint: String

    /// The flag to indicate whether the direct revocation endpoint is enabled or not.
    directRevocationEndpointEnabled: Boolean

    /// Client authentication methods supported at the revocation endpoint.
    supportedRevocationAuthMethods: ClientAuthMethods

    /// The URI of the introspection endpoint.
    introspectionEndpoint: String

    /// The flag to indicate whether the direct userinfo endpoint is enabled or not.
    directIntrospectionEndpointEnabled: Boolean

    /// Client authentication methods supported at the introspection endpoint.
    supportedIntrospectionAuthMethods: ClientAuthMethods

    /// The URI of the pushed authorization request endpoint.
    pushedAuthReqEndpoint: String

    /// The duration of pushed authorization requests in seconds.
    pushedAuthReqDuration: Integer

    /// The flag to indicate whether this service requires that clients use the pushed authorization request endpoint.
    parRequired: Boolean

    /// The flag to indicate whether this service requires that authorization requests always utilize a request object by using either request or `request_uri` request parameter.
    requestObjectRequired: Boolean

    /// The flag to indicate whether a request object is processed based on rules defined in OpenID Connect Core 1.0 or JAR (JWT Secured Authorization Request).
    traditionalRequestObjectProcessingApplied: Boolean

    /// The flag to indicate whether this service validates certificate chains during PKI-based client mutual TLS authentication.
    mutualTlsValidatePkiCertChain: Boolean

    /// The list of root certificates trusted by this service for PKI-based client mutual TLS authentication.
    trustedRootCertificates: StringList

    /// The MTLS endpoint aliases.
    mtlsEndpointAliases: NamedUris

    /// The access token type.
    accessTokenType: String

    /// The flag to indicate whether this service supports issuing TLS client certificate bound access tokens.
    tlsClientCertificateBoundAccessTokens: Boolean

    /// The duration of access tokens in seconds.
    accessTokenDuration: Integer

    /// The flag to indicate whether the number of access tokens per subject (and per client) is at most one or can be more.
    singleAccessTokenPerSubject: Boolean

    /// The algorithm used for signing access tokens.
    accessTokenSignAlg: JwsAlg

    /// The key ID to identify a JWK used for signing access tokens.
    accessTokenSignatureKeyId: String

    /// The duration of refresh tokens in seconds.
    refreshTokenDuration: Integer

    /// The flag to indicate whether the remaining duration of the used refresh token is taken over to the newly issued refresh token.
    refreshTokenDurationKept: Boolean

    /// The flag to indicate whether duration of refresh tokens are reset when they are used even if the `refreshTokenKept` property of this service set to `true`.
    refreshTokenDurationReset: Boolean

    /// The flag to indicate whether a refresh token remains unchanged or gets renewed after its use.
    refreshTokenKept: Boolean

    /// Scopes supported by the service.
    supportedScopes: Scopes

    /// The flag to indicate whether requests that request no scope are rejected or not.
    scopeRequired: Boolean

    /// The duration of ID tokens in seconds.
    idTokenDuration: Integer

    /// The allowable clock skew between the server and clients in seconds.
    allowableClockSkew: Integer

    /// Claim types supported by the service.
    supportedClaimTypes: ClaimTypes

    /// Claim locales that the service supports.
    supportedClaimLocales: StringList

    /// Claim names that the service supports.
    supportedClaims: StringList

    /// The flag indicating whether claims specified by shortcut scopes (e.g. `profile`) are included in the issued ID token only when no access token is issued.
    claimShortcutRestrictive: Boolean

    /// The URL of the service's JSON Web Key Set (JWKS) document.
    jwksUri: String

    /// The flag to indicate whether the direct jwks endpoint is enabled or not.
    directJwksEndpointEnabled: Boolean

    /// The content of the service's JSON Web Key Set (JWKS) document.
    jwks: String

    /// The key ID to identify a JWK used for ID token signature using an asymmetric key.
    idTokenSignatureKeyId: String

    /// The key ID to identify a JWK used for user info signature using an asymmetric key.
    userInfoSignatureKeyId: String

    /// The key ID to identify a JWK used for signing authorization responses using an asymmetric key.
    authorizationSignatureKeyId: String

    /// The user info endpoint of the service.
    userInfoEndpoint: String

    /// The flag to indicate whether the direct userinfo endpoint is enabled or not.
    directUserInfoEndpointEnabled: Boolean

    /// The boolean flag which indicates whether the OAuth 2.0 Dynamic Client Registration Protocol is supported.
    dynamicRegistrationSupported: Boolean

    /// The registration endpoint of the service.
    registrationEndpoint: String

    /// The URI of the registration management endpoint.
    registrationManagementEndpoint: String

    /// The URL of the "Policy" of the service.
    policyUri: String

    /// The URL of the "Terms Of Service" of the service.
    tosUri: String

    /// The URL of a page where documents for developers can be found.
    serviceDocumentation: String

    /// The URI of the backchannel authentication endpoint.
    backchannelAuthenticationEndpoint: String

    /// The supported backchannel token delivery modes.
    supportedBackchannelTokenDeliveryModes: DeliveryModes

    /// The duration of backchannel authentication request IDs in seconds.
    backchannelAuthReqIdDuration: Integer

    /// The minimum interval between polling requests to the token endpoint from client applications in seconds.
    backchannelPollingInterval: Integer

    /// The boolean flag which indicates whether the `user_code` request parameter is supported at the backchannel authentication endpoint.
    backchannelUserCodeParameterSupported: Boolean

    /// The flag to indicate whether the `binding_message` request parameter is always required whenever a backchannel authentication request is judged as a request for Financial-grade API.
    backchannelBindingMessageRequiredInFapi: Boolean

    /// The URI of the device authorization endpoint.
    deviceAuthorizationEndpoint: String

    /// The verification URI for the device flow.
    deviceVerificationUri: String

    /// The verification URI for the device flow with a placeholder for a user code.
    deviceVerificationUriComplete: String

    /// The duration of device verification codes and end-user verification codes issued from the device authorization endpoint in seconds.
    deviceFlowCodeDuration: Integer

    /// The minimum interval between polling requests to the token endpoint from client applications in seconds in device flow.
    deviceFlowPollingInterval: Integer

    /// The charset of the user code.
    userCodeCharset: UserCodeCharset

    /// The length of end-user verification codes (`user_code`) for Device Flow.
    userCodeLength: Integer

    /// Trust frameworks supported by this service.
    supportedTrustFrameworks: StringList

    /// Evidence supported by this service.
    supportedEvidence: StringList

    /// Identity documents supported by this service.
    supportedIdentityDocuments: StringList

    /// Verification methods supported by this service.
    supportedVerificationMethods: StringList

    /// Verified claims supported by this service.
    supportedVerifiedClaims: StringList

    /// OIDC4IDA / verifiedClaimsValidationSchemaSet
    verifiedClaimsValidationSchemaSet: VerifiedClaimsValidationSchema

    /// The attributes of this service.
    attributes: Pairs

    /// The flag indicating whether the nbf claim in the request object is optional even when the authorization request is regarded as a FAPI-Part2 request.
    nbfOptional: Boolean

    /// The flag indicating whether generation of the iss response parameter is suppressed.
    issSuppressed: Boolean

    /// Custom client metadata supported by this service.
    supportedCustomClientMetadata: StringList

    /// The flag indicating whether the expiration date of an access token never exceeds that of the corresponding refresh token.
    tokenExpirationLinked: Boolean

    /// The flag indicating whether encryption of request object is required when the request object is passed through the front channel.
    frontChannelRequestObjectEncryptionRequired: Boolean

    /// The flag indicating whether the JWE alg of encrypted request object must match the `request_object_encryption_alg` client metadata of the client that has sent the request object.
    requestObjectEncryptionAlgMatchRequired: Boolean

    /// The flag indicating whether the JWE `enc` of encrypted request object must match the `request_object_encryption_enc` client metadata of the client that has sent the request object.
    requestObjectEncryptionEncMatchRequired: Boolean

    /// The flag indicating whether HSM (Hardware Security Module) support is enabled for this service.
    hsmEnabled: Boolean

    /// The information about keys managed on HSMs (Hardware Security Modules).
    hsks: Hsks

    /// The URL of the grant management endpoint.
    grantManagementEndpoint: String

    /// The flag indicating whether every authorization request (and any request serving as an authorization request such as CIBA backchannel authentication request and device authorization request) requires grant management action.
    grantManagementActionRequired: Boolean

    /// The flag indicating whether Authlete's `/api/client/registration` API uses `UNAUTHORIZED` as a value of the `action` response parameter when appropriate.
    unauthorizedOnClientConfigSupported: Boolean

    /// The flag indicating whether the `scope` request parameter in dynamic client registration and update requests is used as scopes that the client can request.
    dcrScopeUsedAsRequestable: Boolean

    /// The endpoint for clients ending the sessions.
    endSessionEndpoint: String

    /// The flag indicating whether the port number component of redirection URIs can be variable when the host component indicates loopback.
    loopbackRedirectionUriVariable: Boolean

    /// The flag indicating whether Authlete checks whether the `aud` claim of request objects matches the issuer identifier of this service.
    requestObjectAudienceChecked: Boolean

    /// The flag indicating whether Authlete generates access tokens for external attachments and embeds them in ID tokens and userinfo responses.
    accessTokenForExternalAttachmentEmbedded: Boolean

    /// Identifiers of entities that can issue entity statements for this service.
    authorityHints: StringList

    /// The flag indicating whether this service supports OpenID Connect Federation 1.
    federationEnabled: Boolean

    /// JWK Set document containing keys that are used to sign (1) self-signed entity statement of this service and (2) the response from `signed_jwks_uri`.
    federationJwks: String

    /// A key ID to identify a JWK used to sign the entity configuration and the signed JWK Set.
    federationSignatureKeyId: String

    /// The duration of the entity configuration in seconds.
    federationConfigurationDuration: Integer

    /// The URI of the federation registration endpoint.
    federationRegistrationEndpoint: String

    /// The human-readable name representing the organization that operates this service.
    organizationName: String

    /// The transformed claims predefined by this service in JSON format.
    predefinedTransformedClaims: String

    /// The flag indicating whether refresh token requests with the same refresh token can be made multiple times in quick succession and they can obtain the same renewed refresh token within the short period.
    refreshTokenIdempotent: Boolean

    /// The URI of the endpoint that returns this service's JWK Set document in the JWT format.
    signedJwksUri: String

    /// Supported attachment types.
    supportedAttachments: AttachmentTypes

    /// Supported algorithms used to compute digest values of external attachments.
    supportedDigestAlgorithms: StringList

    /// Document types supported by this service.
    supportedDocuments: StringList

    /// Validation and verification processes supported by this service.
    supportedDocumentsMethods: StringList

    /// Document validation methods supported by this service.
    supportedDocumentsValidationMethods: StringList

    /// Document verification methods supported by this service.
    supportedDocumentsVerificationMethods: StringList

    /// Electronic record types supported by this service.
    supportedElectronicRecords: StringList

    /// Supported client registration types.
    supportedClientRegistrationTypes: ClientRegistrationTypes

    /// The flag indicating whether to prohibit unidentifiable clients from making token exchange requests.
    tokenExchangeByIdentifiableClientsOnly: Boolean

    /// The flag indicating whether to prohibit public clients from making token exchange requests.
    tokenExchangeByConfidentialClientsOnly: Boolean

    /// The flag indicating whether to prohibit clients that have no explicit permission from making token exchange requests.
    tokenExchangeByPermittedClientsOnly: Boolean

    /// The flag indicating whether to reject token exchange requests which use encrypted JWTs as input tokens.
    tokenExchangeEncryptedJwtRejected: Boolean

    /// The flag indicating whether to reject token exchange requests which use unsigned JWTs as input tokens.
    tokenExchangeUnsignedJwtRejected: Boolean

    /// The flag indicating whether to prohibit unidentifiable clients from using the grant type `urn:ietf:params:oauth:grant-type:jwt-bearer`.
    jwtGrantByIdentifiableClientsOnly: Boolean

    /// The flag indicating whether to reject token requests that use an encrypted JWT as an authorization grant with the grant type `urn:ietf:params:oauth:grant-type:jwt-bearer`.
    jwtGrantEncryptedJwtRejected: Boolean

    /// The flag indicating whether to reject token requests that use an unsigned JWT as an authorization grant with the grant type `urn:ietf:params:oauth:grant-type:jwt-bearer`.
    jwtGrantUnsignedJwtRejected: Boolean

    /// The flag indicating whether to block DCR (Dynamic Client Registration) requests whose `software_id` has already been used previously.
    dcrDuplicateSoftwareIdBlocked: Boolean

    /// The trust anchors that are referenced when this service resolves trust chains of relying parties.
    trustAnchors: TrustAnchors

    /// The flag indicating whether the openid scope should be dropped from scopes list assigned to access token issued when a refresh token grant is used.
    openidDroppedOnRefreshWithoutOfflineAccess: Boolean

// Supported document check methods.
    supportedDocumentsCheckMethods: StringList

    /// The key ID of a JWK containing the private key used by this service to sign responses from the resource server.
    resourceSignatureKeyId: String

    /// The flag indicating whether this service signs responses from the resource server.
    rsResponseSigned: Boolean


}   

list ServiceProfiles{
    member:ServiceProfile
}
list Properties{
    member: Property
}

list Prompts{
    member:Prompt
}
list TaggedValues{
    member:TaggedValue
}
list TrustAnchors{
    member:TrustAnchor
}

list Pairs{
    member:Pair
}
list AttachmentTypes{
    member:AttachmentType
}
list DeliveryModes{
member:DeliveryMode
}
list ClaimTypes{
    member:ClaimType
}
list NamedUris{
    member:NamedUri
}
list Displays{
    member:Display
}
list ClientAuthMethods{
    member:ClientAuthMethod
}
list Clients{
    member:Client
}
list GrantScopes{
    member:GrantScope
}
list Hsks{
    member:Hsk
}
list ClientRegistrationTypes{
    member:ClientRegistrationType
}
list AuthorizationDetailsElements{
    member:AuthorizationDetailsElement
}
list ResponseTypes{
    member:ResponseType
}
list GrantTypes{
    member:GrantType
}
list DynamicScopes{
    member:DynamicScope
}
list AccessTokens{
    member:AccessToken
}
list SnsList{
    member:Sns
}

list SnsCredentialsList{
    member:SnsCredentials
}
structure ServiceGetListResponse {
    /// Start index (inclusive) of the result set. The default value is 0. Must not be a negative number.
    
    start: Integer

    /// End index (inclusive) of the result set. The default value is 0. Must not be a negative number.
    
    end: Integer

    /// Total number of services owned by the service owner. This doesn't mean the number of services contained in the response.
    
    totalCount: Integer

    /// An array of services.
    
    services: Services
}

list Services{
    member:Service
}

structure ServiceJwksGetResponse {
    /// An array of [JWK](https://datatracker.ietf.org/doc/html/rfc7517)s.
    
    keys: StringList //List<Object>
}

enum ServiceProfile {
    /// Financial-grade API (FAPI) profile.
    FAPI,

    /// Open Banking profile.
    OPEN_BANKING
}


enum Sns {
    /// Facebook social network service.
    FACEBOOK
}

structure SnsCredentials {
    /// SNS.
    
    sns: String

    /// API key.
    
    apiKey: String

    /// API secret.
    
    apiSecret: String
}

structure StandardIntrospectionResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: StandardIntrospectionResponseAction

    /// The content that the authorization server implementation is to return to the client application.
    
    responseContent: String

}
    enum StandardIntrospectionResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST

    /// OK action.
    OK
}


// The subject type that the client application requests.
/// Details about the subject type are described in [OpenID Connect Core 1.0, 8. Subject Identifier Types](https://openid.net/specs/openid-connect-core-1_0.html#SubjectIDTypes).
enum SubjectType {
    /// Public subject type.
    PUBLIC,

    /// Pairwise subject type.
    PAIRWISE
}

structure TaggedValue {
    /// The language tag part.
    
    tag: String

    /// The value part.
    
    value: String
}

structure TokenCreateRequest {
    /// The grant type.
    grantType: GrantType

    /// The ID of the client application which will be associated with a newly created access token.
    clientId: Integer

    /// The subject (= unique identifier) of the user who will be associated with a newly created access token.
    
    subject: String

    /// The scopes which will be associated with a newly created access token.
    
    scopes: StringList

    /// The duration of a newly created access token in seconds.
    
    accessTokenDuration: Integer

    /// The duration of a newly created refresh token in seconds.
    
    refreshTokenDuration: Integer

    /// Extra properties to associate with a newly created access token.
    
    properties: Properties

    /// A boolean request parameter which indicates whether to emulate that the client ID alias is used instead of the original numeric client ID when a new access token is created.
    
    clientIdAliasUsed: Boolean

    /// The value of the new access token.
    
    accessToken: String

    /// The value of the new refresh token.
    
    refreshToken: String

    /// Get whether the access token expires or not.
    
    accessTokenPersistent: Boolean

    /// The thumbprint of the MTLS certificate bound to this token.
    
    certificateThumbprint: String

    /// The thumbprint of the public key used for DPoP presentation of this token.
    
    dpopKeyThumbprint: String

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The value of the resources to associate with the token.
    
    resources: StringList

    /// The flag which indicates whether the access token is for an external attachment.
    
    forExternalAttachment: Boolean

    /// Additional claims that are added to the payload part of the JWT access token.
    
    jwtAtClaims: String

    /// The Authentication Context Class Reference of the user authentication that the authorization server performed during the course of issuing the access token.
    
    acr: String

    /// The time when the user authentication was performed during the course of issuing the access token.
    
    authTime: Integer

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    
    clientEntityIdUsed: Boolean
}

structure TokenCreateResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: TokenCreateResponseAction

    /// The newly issued access token.
    
    accessToken: String

    /// The ID of the client application associated with the access token.
    
    clientId: Integer

    /// The time at which the access token expires.
    
    expiresAt: Integer

    /// The duration of the newly issued access token in seconds.
    
    expiresIn: Integer

    /// The grant type for the newly issued access token.
    
    grantType: String

    /// The extra properties associated with the access token.
    
    properties: Properties

    /// The newly issued refresh token.
    
    refreshToken: String

    /// Scopes which are associated with the access token.
    
    scopes: StringList

    /// The subject (= unique identifier) of the user associated with the newly issued access token.
    
    subject: String

    /// The token type of the access token.
    
    tokenType: String

    /// If the authorization server is configured to issue JWT-based access tokens, a JWT-based access token is issued along with the regular access token.
    
    jwtAccessToken: String

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The flag which indicates whether the access token is for an external attachment.
    
    forExternalAttachment: Boolean

}
    enum TokenCreateResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST

    /// Forbidden action.
    FORBIDDEN

    /// OK action.
    OK
}



structure TokenFailRequest {
    /// The ticket issued from Authlete `/auth/token` API.
    ticket: String

    /// The reason of the failure of the token request.
    reason: TokenFailRequestReason

}
    enum TokenFailRequestReason {
    /// Unknown reason.
    UNKNOWN

    /// Invalid resource owner credentials.
    INVALID_RESOURCE_OWNER_CREDENTIALS

    /// Invalid target.
    INVALID_TARGET
}



structure TokenFailResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: TokenFailResponseAction

    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    
    responseContent: String

}
    enum TokenFailResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST
}



structure TokenGetListResponse {
    /// Start index of search results (inclusive).
    
    start: Integer

    /// End index of search results (exclusive).
    
    end: Integer

    /// Unique ID of a client developer.
    
    totalCount: Integer

    /// Client information.
    
    client: Client

    /// Unique user ID of an end-user.
    
    subject: String

    /// An array of access tokens.
    
    accessTokens: AccessTokens
}

structure TokenInfo {
    /// The client id.
    
    clientId: Integer

    /// The alias of the client.
    
    clientIdAlias: String

    /// Flag specifying if the alias was used to identify the client.
    
    clientIdAliasUsed: Boolean

    /// The resource owner unique id.
    
    subject: String

    /// The scopes granted on the token.
    
    scopes: StringList

    /// Time when the token expires.
    
    expiresAt: Integer

    /// Extra properties associated with the token.
    
    properties: Properties

    /// The array of the resources of the token.
    
    resources: StringList

    /// Authorization details.
    
    authorizationDetails: AuthorizationDetailsElement

    /// The entity ID of the client.
    
    clientEntityId: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    
    clientEntityIdUsed: Boolean
}


structure TokenIssueRequest {
    /// The ticket issued from Authlete `/auth/token` API.
    ticket: String

    /// The subject (= unique identifier) of the authenticated user.
    subject: String

    /// Extra properties to associate with a newly created access token.
    
    properties: Properties

    /// Additional claims that are added to the payload part of the JWT access token.
    
    jwtAtClaims: String

    /// The representation of an access token that may be issued as a result of the Authlete API call.
    
    accessToken: String
}



structure TokenIssueResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: TokenIssueResponseAction

    /// The content that the authorization server implementation is to return to the client application. Its format is JSON.
    
    responseContent: String

    /// The newly issued access token. This parameter is a non-null value only when the value of `action` parameter is `OK`.
    
    accessToken: String

    /// The datetime at which the newly issued access token will expire. The value is represented in milliseconds since the Unix epoch (1970-01-01).
    
    accessTokenExpiresAt: Integer

    /// The duration of the newly issued access token in seconds.
    
    accessTokenDuration: Integer

    /// The refresh token. This parameter is a non-null value only when `action` is `OK` and the service supports the refresh token flow.
    
    refreshToken: String

    /// The datetime at which the newly issued refresh token will expire. The value is represented in milliseconds since the Unix epoch (1970-01-01).
    
    refreshTokenExpiresAt: Integer

    /// The duration of the newly issued refresh token in seconds.
    
    refreshTokenDuration: Integer

    /// The client ID.
    
    clientId: Integer

    /// The client ID alias. If the client did not have an alias, this parameter is `null`.
    
    clientIdAlias: String

    /// The flag which indicates whether the client ID alias was used when the token request was made.
    
    clientIdAliasUsed: Boolean

    /// The subject (= resource owner's ID) of the access token.
    
    subject: String

    /// The scopes covered by the access token.
    
    scopes: StringList

    /// The extra properties associated with the access token.
    
    properties: Properties

    /// The newly issued access token in JWT format.
    
    jwtAccessToken: String

    /// The target resources of the access token being issued.
    
    accessTokenResources: StringList

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The attributes of this service that the client application belongs to.
    
    serviceAttributes: Pairs

    /// The attributes of the client.
    
    clientAttributes: Pairs

    /// The entity ID of the client.
    
    clientEntityId: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    
    clientEntityIdUsed: Boolean

}

    enum TokenIssueResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// OK action.
    OK
}



structure TokenRequest {
    /// OAuth 2.0 token request parameters which are the request parameters that the OAuth 2.0 token endpoint of the authorization server implementation received from the client application.
    parameters: String

    /// The client ID extracted from `Authorization` header of the token request from the client application.
    
    clientId: String

    /// The client secret extracted from `Authorization` header of the token request from the client application.
    
    clientSecret: String

    /// The client certificate from the MTLS of the token request from the client application.
    
    clientCertificate: String

    /// The certificate path presented by the client during client authentication. These certificates are strings in PEM format.
    
    clientCertificatePath: String

    /// Extra properties to associate with an access token.
    
    properties: String

    /// `DPoP` header presented by the client during the request to the token endpoint.
    
    dpop: String

    /// HTTP method of the token request. This field is used to validate the `DPoP` header.
    
    htm: String

    /// URL of the token endpoint. This field is used to validate the `DPoP` header.
    
    htu: String

    /// The representation of an access token that may be issued as a result of the Authlete API call.
    
    accessToken: String

    /// Additional claims that are added to the payload part of the JWT access token.
    
    jwtAtClaims: String
}


structure TokenResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: TokenResponseAction

    /// The content that the authorization server implementation is to return to the client application. Its format varies depending on the value of `action` parameter.
    
    responseContent: String

    /// The value of `username` request parameter in the token request.
    
    username: String

    /// The value of `password` request parameter in the token request.
    
    password: String

    /// The ticket which is necessary to call Authlete's `/auth/token/fail` API or `/auth/token/issue` API.
    
    ticket: String

    /// The newly issued access token.
    
    accessToken: String

    /// The datetime at which the newly issued access token will expire. The value is represented in milliseconds since the Unix epoch (1970-01-01).
    
    accessTokenExpiresAt: Integer

    /// The duration of the newly issued access token in seconds.
    
    accessTokenDuration: Integer

    /// The newly issued refresh token.
    
    refreshToken: String

    /// The datetime at which the newly issued refresh token will expire. The value is represented in milliseconds since the Unix epoch (1970-01-01).
    
    refreshTokenExpiresAt: Integer

    /// The duration of the newly issued refresh token in seconds.
    
    refreshTokenDuration: Integer

    /// The newly issued ID token.
    
    idToken: String

    /// The grant type of the token request.
    
    grantType: String

    /// The client ID.
    
    clientId: Integer

    /// The client ID alias when the token request was made. If the client did not have an alias, this parameter is `null`.
    
    clientIdAlias: String

    /// The flag which indicates whether the client ID alias was used when the token request was made.
    
    clientIdAliasUsed: Boolean

    /// The subject (= resource owner's ID) of the access token.
    
    subject: String

    /// The scopes covered by the access token.
    
    scopes: StringList

    /// The extra properties associated with the access token.
    
    properties: Properties

    /// The newly issued access token in JWT format.
    
    jwtAccessToken: String

    /// The resources specified by the `resource` request parameters in the token request.
    
    resources: StringList

    /// The target resources of the access token being issued.
    
    accessTokenResources: StringList

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The attributes of this service that the client application belongs to.
    
    serviceAttributes: Pairs

    /// The attributes of the client.
    
    clientAttributes: Pairs

    /// The value of the `grant_id` request parameter of the device authorization request.
    
    grantId: String

    /// The audiences on the token exchange request.
    
    audiences: StringList

    /// The requested token type.
    
    requestedTokenType: TokenType

    /// The subject token.
    
    subjectToken: String

    /// The subject token type.
    
    subjectTokenType: TokenType

    /// Information about the subject token.
    
    subjectTokenInfo: TokenInfo

    /// The actor token.
    
    actorToken: String

    /// The actor token type.
    
    actorTokenType: TokenType

    /// Information about the actor token.
    
    actorTokenInfo: TokenInfo

    /// For RFC 7523 JSON Web Token (JWT) Profile for OAuth 2.0 Client Authentication and Authorization Grants.
    
    assertion: String

    /// Indicate whether the previous refresh token that had been kept in the database for a short time was used.
    
    previousRefreshTokenUsed: Boolean

    /// The entity ID of the client.
    
    clientEntityId: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    
    clientEntityIdUsed: Boolean

}
    enum TokenResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Invalid client action.
    INVALID_CLIENT

    /// Bad request action.
    BAD_REQUEST

    /// Password action.
    PASSWORD

    /// OK action.
    OK

    /// Token exchange action.
    TOKEN_EXCHANGE

    /// JWT bearer action.
    JWT_BEARER
}




structure TokenRevokeRequest {
    /// The identifier of an access token to revoke. The hash of an access token is recognized as an identifier as well as the access token itself.
    
    accessTokenIdentifier: String

    /// The identifier of a refresh token to revoke. The hash of a refresh token is recognized as an identifier as well as the refresh token itself.
    
    refreshTokenIdentifier: String

    /// The client ID of the access token to be revoked. Both the numeric client ID and the alias are recognized as an identifier of a client.
    
    clientIdentifier: String

    /// The subject of a resource owner.
    
    subject: String
}

structure TokenRevokeResponse {
    /// The number of tokens revoked.
    
    count: Integer

    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String
}



enum TokenType {
    @enumValue("urn:ietf:params:oauth:token-type:jwt")
    JWT

    @enumValue("urn:ietf:params:oauth:token-type:access_token")
    ACCESS_TOKEN

    @enumValue("urn:ietf:params:oauth:token-type:refresh_token")
    REFRESH_TOKEN

    @enumValue("urn:ietf:params:oauth:token-type:id_token")
    ID_TOKEN

    @enumValue("urn:ietf:params:oauth:token-type:saml1")
    SAML1

    @enumValue("urn:ietf:params:oauth:token-type:saml2")
    SAML2

    DEVICE_CODE
    TOKEN_EXCHANGE
    JWT_BEARER
}


structure TokenUpdateRequest {
    /// An access token.
    accessToken: String

    /// A new date at which the access token will expire in milliseconds since the Unix epoch (1970-01-01). If the `accessTokenExpiresAt` request parameter is not included in a request or its value is null, the expiration date of the access token is not changed.
    
    accessTokenExpiresAt: Integer

    /// A new set of scopes assigned to the access token. Scopes that are not supported by the service and those that the client application associated with the access token is not allowed to request are ignored.
    
    scopes: StringList

    /// A new set of properties assigned to the access token. If the `properties` request parameter is not included in a request or its value is null, the properties of the access token are not changed.
    
    properties: Properties

    /// A boolean request parameter which indicates whether the API attempts to update the expiration date of the access token when the scopes linked to the access token are changed by this request.
    
    accessTokenExpiresAtUpdatedOnScopeUpdate: Boolean

    /// The hash of the access token value. Used when the hash of the token is known (perhaps from lookup) but the value of the token itself is not. The value of the `accessToken` parameter takes precedence over this parameter.
    
    accessTokenHash: String

    /// A boolean request parameter which indicates whether to update the value of the access token in the data store. If this parameter is set to `true` then a new access token value is generated by the service.
    
    accessTokenValueUpdated: Boolean

    /// The flag which indicates whether the access token expires or not. By default, all access tokens expire after a period of time determined by their service. If this request parameter is `true` then the access token will not expire.
    
    accessTokenPersistent: Boolean

    /// The thumbprint of the MTLS certificate bound to this token. If this property is set, a certificate with the corresponding value MUST be presented with the access token when it is used by a client.
    
    certificateThumbprint: String

    /// The thumbprint of the public key used for DPoP presentation of this token. If this property is set, a DPoP proof signed with the corresponding private key MUST be presented with the access token.
    
    dpopKeyThumbprint: String

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The flag which indicates whether the access token is for an external attachment.
    
    forExternalAttachment: Boolean
}


structure TokenUpdateResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: TokenUpdateResponseAction

    /// The access token which has been specified by the request.
    
    accessToken: String

    /// The date at which the access token will expire.
    
    accessTokenExpiresAt: Integer

    /// The date at which the refresh token will expire.
    
    refreshTokenExpiresAt: Integer

    /// The extra properties associated with the access token.
    
    properties: Properties

    /// The scopes associated with the access token.
    
    scopes: StringList

    /// Authorization details.
    
    authorizationDetails: AuthzDetails

    /// The token type associated with the access token.
    
    tokenType: String

    /// The flag which indicates whether the access token is for an external attachment.
    
    forExternalAttachment: Boolean

}
    enum TokenUpdateResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST

    /// Forbidden action.
    FORBIDDEN

    /// Not found action.
    NOT_FOUND

    /// OK action.
    OK
}

structure TokenListResponse{

}

enum TokenStatus {
    @documentation("All valid tokens.")
    VALID

    @documentation("All invalid (expired) tokens.")
    INVALID

    @documentation("All tokens.")
    ALL
}


structure TrustAnchor {
    /// The entity ID of the trust anchor.
    
    entityId: String

    /// The JWK Set document containing public keys of the trust anchor.
    
    jwks: String
}

//The character set for end-user verification codes (`user_code`) for Device Flow. 
enum UserCodeCharset {
    /// Base20 character set for end-user verification codes.
    BASE20

    /// Numeric character set for end-user verification codes.
    NUMERIC
}

structure UserInfoIssueRequest {
    /// The access token that has been passed to the userinfo endpoint by the client application. In other words, the access token which was contained in the userinfo request.
    token: String

    /// Claims in JSON format. As for the format, see [OpenID Connect Core 1.0, 5.1. Standard Claims](https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims).
    
    claims: String

    /// The value of the `sub` claim. If the value of this request parameter is not empty, it is used as the value of the `sub` claim. Otherwise, the value of the subject associated with the access token is used.
    
    sub: String

    /// Claim key-value pairs that are used to compute transformed claims.
    
    claimsForTx: String

    /// The Signature header value from the request.
    
    requestSignature: String

    /// HTTP headers to be included in processing the signature. If this is a signed request, this must include the Signature and Signature-Input headers, as well as any additional headers covered by the signature.
    
    headers: Pairs
}


structure UserInfoIssueResponse {
    /// The code which represents the result of the API call.
    
    resultCode: String

    /// A short message which explains the result of the API call.
    
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    
    action: UserInfoIssueResponseAction

    /// The content that the authorization server implementation can use as the value of `WWW-Authenticate` header on errors.
    
    responseContent: String

    /// The signature header of the response message.
    
    signature: String

    /// The signature-input header of the response message.
    
    signatureInput: String

    /// The content-digest header of the response message.
    
    contentDigest: String

}
    enum UserInfoIssueResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST

    /// Unauthorized action.
    UNAUTHORIZED

    /// Forbidden action.
    FORBIDDEN

    /// JSON action.
    JSON

    /// OK action.
    OK
}


structure UserInfoRequest {
    /// An access token.
    token: String

    /// Client certificate used in the TLS connection established between the client application and the userinfo endpoint. The value of this request parameter is referred to when the access token is bound to a client certificate.
    
    clientCertificate: String

    /// `DPoP` header presented by the client during the request to the user info endpoint. The header contains a signed JWT which includes the public key that is paired with the private key used to sign the request.
    
    dpop: String

    /// HTTP method of the user info request. This field is used to validate the DPoP header. In normal cases, the value is either `GET` or `POST`.
    
    htm: String

    /// URL of the user info endpoint. This field is used to validate the DPoP header. If this parameter is omitted, the `userInfoEndpoint` property of the service is used as the default value.
    
    htu: String

    /// The full URL of the userinfo endpoint.
    
    uri: String

    /// The HTTP message body of the request, if present.
    
    message: String

    /// HTTP headers to be included in processing the signature. If this is a signed request, this must include the Signature and Signature-Input headers, as well as any additional headers covered by the signature.
    
    headers: Pairs
}


structure UserInfoResponse {
    /// The code which represents the result of the API call.
    resultCode: String

    /// A short message which explains the result of the API call.
    resultMessage: String

    /// The next action that the authorization server implementation should take.
    action: UserInfoResponseAction

    /// The list of claims that the client application requests to be embedded in the ID token.
    claims: StringList

    /// The ID of the client application which is associated with the access token.
    clientId: Integer

    /// The client ID alias when the authorization request for the access token was made.
    clientIdAlias: String

    /// The flag which indicates whether the client ID alias was used when the authorization request for the access token was made.
    clientIdAliasUsed: Boolean

    /// The content that the authorization server implementation can use as the value of `WWW-Authenticate` header on errors.
    responseContent: String

    /// The scopes covered by the access token.
    scopes: StringList

    /// The subject (= resource owner's ID).
    subject: String

    /// The access token that came along with the userinfo request.
    token: String

    /// The extra properties associated with the access token.
    properties: Properties

    /// The value of the `userinfo` property in the `claims` request parameter or in the `claims` property in an authorization request object. A client application may request certain claims to be embedded in the ID token.
    userInfoClaims: String

    /// The attributes of this service that the client application belongs to.
    serviceAttributes: Pairs

    /// The attributes of the client.
    clientAttributes: Pairs

    /// The claims that the user has consented for the client application to know.
    consentedClaims: StringList

    /// Get names of claims that are requested indirectly by "transformed claims". A client application can request "transformed claims" by adding names of transformed claims.
    requestedClaimsForTx: StringList

    /// Names of verified claims that will be referenced when transformed claims are computed.  
    requestedVerifiedClaimsForTx: VerifiedClaims

    /// The value of the `transformed_claims` property in the `claims` request parameter of an authorization request or in the `claims` property in a request object.
    transformedClaims: String

    /// The entity ID of the client. 
    clientEntityId: String

    /// Flag which indicates whether the entity ID of the client was used when the request for the access token was made.
    clientEntityIdUsed: Boolean

}

list VerifiedClaims{
    member:StringList
}
    enum UserInfoResponseAction {
    /// Internal server error action.
    INTERNAL_SERVER_ERROR

    /// Bad request action.
    BAD_REQUEST

    /// Unauthorized action.
    UNAUTHORIZED

    /// Forbidden action.
    FORBIDDEN

    /// OK action.
    OK
}


@documentation("Validation schema for verified claims")
enum VerifiedClaimsValidationSchema {
    @enumValue("standard")
    STANDARD

    @enumValue("standard+id_document")
    STANDARD_ID_DOCUMENT

    @enumValue("null")
    NULL
}


