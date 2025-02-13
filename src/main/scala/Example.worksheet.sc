import javax.naming.ldap.ExtendedRequest
import authlete.models.*


Display.PAGE

Display.POPUP

Display.TOUCH

Display.WAP

val client=Client(clientNumber=12,serviceNumber=23,clientId=31,"secret",derivedSectorIdentifier="derivedSectorIdentifier")


AccessToken(

)

AccessTokens(List.empty)

ApplicationType.NATIVE

ApplicationType.WEB

AuthorizationDetails()

AuthorizationDetailsElement

TokenRequest()

BackchannelAuthenticationCompleteRequestResult

BackchannelAuthenticationCompleteRequest("ticket",
BackchannelAuthenticationCompleteRequestResult.TRANSACTION_FAILED,"subject")

BackchannelAuthenticationIssueRequest("ticket")

BackchannelAuthenticationFailRequestReason

BackchannelAuthenticationRequest("params")

ClientRegistrationUpdateRequest()

ClientRegistrationDeleteRequest()

FederationRegistrationRequest()

ClientRegistrationGetRequest()

PushedAuthorizationRequest("params")


DeviceAuthorizationRequest()

DeviceVerificationRequest()

ClientSecretUpdateRequest()


ClientRegistrationRequest()

AuthorizationIssueRequest("ticket","subject")

AuthorizationFailRequestReason

AuthorizationFailRequest("ticket",AuthorizationFailRequestReason.DENIED)


ClientFlagUpdateRequest()

UserinfoRequest()

RevocationRequest("")

HskCreateRequest()


TokenFailRequest()

JoseVerifyRequest()


TokenIssueRequest()


IntrospectionRequest()

PushedAuthReqRequest("params")




AuthzDetails()

ClaimType.NORMAL

ResponseType.CODE_ID_TOKEN

TokenResponse()

HskGetResponse()


RevocationResponse()

UserinfoResponse()

TokenFailResponse()

ClientExtensionRequestableScopesGetResponse()

BackchannelAuthenticationCompleteResponseAction.NO_ACTION

BackchannelAuthenticationCompleteResponse()

BackchannelAuthenticationIssueResponse()

JwsAlg.EDDSA

JwsAlg.HS384

JwsAlg.PS512

JwsAlg.RS384

JweEnc.A192GCM

JweEnc.A192CBC_HS384

JweEnc.A128GCM

JweEnc.A256GCM

JweAlg.A128GCMKW

JweAlg.A128KW

JweAlg.A192GCMKW

JweAlg.A256GCMKW

JweAlg.A256KW

JweAlg.ECDH_ES

JweAlg.ECDH_ES_A192KW

JweAlg.PBES2_HS384_A192KW

JweAlg.RSA_OAEP

JweAlg.PBES2_HS384_A192KW

JweAlg.PBES2_HS512_A256KW




import com.bank.* 


BalanceInput("id")

BalanceOutput()

DepositInput("id",MoneyType(656.toFloat,"AUD"),MoneyType(656.toFloat,"AUD"))


DepositOutput()

import com.bison.* 


HerdMembers(List.empty)


BisonRates

BisonId


