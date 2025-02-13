# Smithy-Demo




https://disneystreaming.github.io/smithy4s/docs/overview/quickstart


OpenAPI-language agnostic
Smithy- Protocol Agnostic( eg GRPC and RUST, Scala and REST )

Smithy is a protocol agnostic IDL(interface description language)

get client, server and documentation

[Smithy and IDL universe](https://www.youtube.com/watch?v=B7hVVbLgjm4&t=1536s)

Smithy provides a way to define APIs, services, operations, and data models using a neutral, language-agnostic format

Smithy separates the API definition from the underlying protocols (such as REST, HTTP, or JSON-RPC). You can model your service once and use protocol bindings to generate APIs for multiple environments or platforms.




In the banking sector, Smithy can be a powerful tool for defining APIs and building SDKs efficiently. Originally developed by AWS, Smithy is an interface definition language (IDL) that helps organizations model their services in a protocol-agnostic way, making it suitable for complex financial systems where interoperability across different platforms and programming languages is essential


Code Generation and Interoperability: Smithy models can be used to generate code in multiple programming languages, helping financial institutions quickly develop SDKs for both internal services and external client integrations. This simplifies maintaining diverse microservices and makes it easier to roll out secure APIs for mobile apps, payment gateways, and other banking products.
Cross-Team Collaboration: Smithy’s ability to assign different parts of the API model to different teams can streamline collaboration between engineering, compliance, and documentation teams, which is critical in financial institutions dealing with both internal APIs and public-facing services like open banking interfaces.


### Structure
A structure type represents a fixed set of named heterogeneous members. In Kotlin this can be represented as either a normal class or a data class.

Traits of generated classes in Kotlin:

- We generate standard classes for types rather than Kotlin's data classes. 
- We generate request and response classes with nullable properties, regardless of any modeling notions of required-ness. 


[kotlin-smithy](https://github.com/smithy-lang/smithy-kotlin/blob/main/docs/design/kotlin-smithy-sdk.md)

auto-generating http routes, clients and momain models

A Smithy model defines the service, operations, and data structures (shapes) of an API. This model is used to generate client and server code that adheres to the specifications described in the Smithy file

[Smithy](https://www.youtube.com/watch?v=_dyEfxA9aeY&t=8s)

oeration-http endpoint

```sh

service AdminService {
  operations: [GetUser]
}

@http(method: "GET", uri: "/user/{id}")
operation GetUser {
  input := {
    @required
    @httpLabel
    id: String
  }
  output: User
}

structure User {
  @required firstName: String
  @required lastName: String
}
```

There are different interpretters that you can use to generate code from this data structure.Smithy4s is one of these

Smithy is protocol agnostic-> you can generate code for a number of server and client languages
Based on the smithy model, you generate clients for scala, typescript, java, kotlin,swift etc

There are number of server languages
from your smithy spec, you implement the spec using the generated code  and that gives you the server for free

You can support many serialization formats

You can easily convert smithy models into OpenAPI specs


## Generate a new SSL self-signed CA

```sh

❯❯❯ openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout certs/localhost.key -out certs/localhost.crt -subj "/CN=localhost" \
  -addext "basicConstraints=critical,CA:false" \
  -addext "subjectAltName=DNS:localhost"

```


## interface definition language

- Smithy
- Protocol Buffers
- Apache Thrift
- Avrol IDL
- FlatBuffers
-  Json
- OpenApi specification



`sbt show smithy4sGeneratedSmithyFiles`
- `smithy-demo/target/scala-3.3.3/src_managed/main/smithy/generated-metadata.smithy`


## protocols

-alloy#simpleRestJson







[interface-definition-language](https://csis.pace.edu/~marchese/CS865/Papers/interface-definition-language.pdf)


`@trait`
- This trait may only be applied to shapes that match the following selector: :is(simpleType, list, map, structure, union)

- Operations tied to `alloy#simpleRestJson` services must be annotated with the `@http` trait | SimpleRestJson



1. define operations
2. specify protocol ( protocols usually define both the transport and serialization mechanism)
eg `aws.protocols#restJson1`,`AWS Json 1.0 protocol`, `AWS Json 1.1 protocol`,`AWS restXml protocol`,`AWS query protocol`, `AWS EC2 query protocol`

`smithy4s` provides other protocols( eg `simpleRestjson protocol`)

3. Use an interpreter: aware of protocol semantics and uses any service protocol that confirms to this protocol and transforms into something that runs with that protocol, you can get a http4s client, routes and documentation using simpleRestJson protocol


## Dependencies
If your model requires dependencies, add a `smithy-build.json` file to the root of your project, `specifying Maven dependencies`, along with the repositories where they can be located.

```json
{
    "version": "1.0",
    "maven": {
        "dependencies": ["software.amazon.smithy:smithy-aws-traits:1.40.0"],
        "repositories": [{ "url": "https://repo1.maven.org/maven2/" }]
    }
}
```

## Smithy build
You can configure your Smithy projects using a Smithy build file.

The name of the file is smithy-build.json. This build file is a JSON file has the following structure:

`imports: Array[String]` - a list of path to directories or file to include in the Smithy model - default: ["$PWD"]
`mavenDependencies: Array[String]` - maven dependencies that contains Smithy definitions - default: []
`mavenRepositories: Array[String]` - maven repositories to fetch mavenDependencies from - default: m2local and maven central
An example Smithy build file looks like this:

```json
{
    "imports": ["./specs"],
    "mavenDependencies": ["com.disneystreaming.smithy4s:smithy4s-protocol_2.13:latest.stable"],
    "mavenRepositories": ["https://full.url.to.your.mavenrepository.tld"]
}

```

`cats-effect` depends on `cats-effect-std`

✔️ fork := true helps reduce port binding issues when stopping sbt.

✅ Yes, because the server runs in a separate process, stopping sbt won’t leave the port occupied by a hanging in-process thread.

Why?
- Since sbt forks a new JVM, the server runs in a separate process.
- When sbt is terminated, the child process (server) is also terminated.
- This prevents situations where an in-process server continues running and keeps the port occupied.

`sbt smithy4sUpdateLSPConfig`

A structure in Smithy is a data type that defines a collection of named fields.

A resource represents a higher-level entity in an API that has behaviors and operations.
It typically models a RESTful resource and is associated with operations.
Resources can have identifiers, operations, and nested resources.


In Smithy, both resources and services are used to define APIs, but they serve different purposes.
## Resource
A resource represents an individual entity in an API that has operations and identifiers.

- Resources model RESTful entities such as User, Order, or Product.
- They define operations that can be performed on the entity.
- They can have nested resources.

```smithy
resource User {
    identifiers: { userId: String }
    operations: [GetUser, DeleteUser]
}
```
### Service
A service defines the entire API and acts as the entry point for clients.

- It groups multiple resources together.
- It specifies the protocol (e.g., HTTP, AWS JSON, etc.).
- It defines the version of the API.

```smithy
service UserService {
    version: "2024-02-09"
    resources: [User]
}

```

A service can also be built using operations

```smithy
service Payments {
  version: "0.1",
  operations: [ AuthorizePayment, CompletePayment, GetPaymentMethods ]
}

```


## Resources and Protocols
A resource in Smithy is an abstraction for an API entity, and it inherits the protocol from the service. The service determines whether the API uses HTTP, gRPC, or another protocol.

 Resource with HTTP Protocol
```smithy
service UserService {
    version: "2024-02-09"
    protocol: aws.protocols#restJson1
    resources: [User]
}

resource User {
    identifiers: { userId: String }
    operations: [GetUser]
}

operation GetUser {
    input: GetUserInput
    output: UserData
    http: { method: "GET", uri: "/users/{userId}" }
}

```

Service with gRPC Protocol
```
service UserService {
    version: "2024-02-09"
    protocol: aws.protocols#awsJson1_1
    operations: [GetUser]
}

operation GetUser {
    input: GetUserInput
    output: UserData
}
```

### Understanding aws.protocols#awsJson1_1
- It is an RPC-style protocol that uses JSON over HTTP.
- It does not follow RESTful principles (no resource-based URLs).
- Instead, requests are sent to a single endpoint with a JSON payload specifying the operation.
- This is commonly used in AWS SDKs for internal service communication.
Example Request (AWS JSON 1.1)
A request to `https://example.com` with AWS JSON 1.1 might look like:

```http
POST / HTTP/1.1
Host: example.com
Content-Type: application/x-amz-json-1.1
X-Amz-Target: UserService.GetUser

{
  "userId": "12345"
}
```
The X-Amz-Target header specifies the operation (GetUser).
The request body contains a JSON payload.

The following is an example of an endpoint that makes a request to create a queue.
```http
POST / HTTP/1.1
Host: sqs.us-west-2.amazonaws.com
X-Amz-Target: AmazonSQS.CreateQueue
X-Amz-Date: <Date>
Content-Type: application/x-amz-json-1.0
Authorization: <AuthParams>
Content-Length: <PayloadSizeBytes>
Connection: Keep-Alive 
{
    "QueueName":"MyQueue",
    "Attributes": {
        "VisibilityTimeout": "40"
    },
    "tags": {
        "QueueType": "Production"
    }
}
```

application/json is to request/receive JSON data without anything more specific
application/x-amz-json-1.1 (or other version) is also to request/receive JSON data and expect additional behaviors described in the docs above. (i.e. tell the server/client this is JSON plus additional elements)

### Making a POST request
An Amazon SQS POST request sends query parameters as a form in the body of an HTTP request.

The following is an example of an HTTP header with X-Amz-Target set to AmazonSQS.<operationName>, and an HTTP header with Content-Type set to application/x-amz-json-1.0.

```http
POST / HTTP/1.1
Host: sqs.<region>.<domain>
X-Amz-Target: AmazonSQS.SendMessage
X-Amz-Date: <Date>
Content-Type: application/x-amz-json-1.0
Authorization: <AuthParams>
Content-Length: <PayloadSizeBytes>
Connection: Keep-Alive 
{
    "QueueUrl": "https://sqs.<region>.<domain>/<awsAccountId>/<queueName>/",
    "MessageBody": "This is a test message"
}
```

Both HTTP headers X-Amz-Target and Content-Type are required.

in smithy,`The protocol dictates the overall structure of the API requests for a particular service. `

As of today, all public AWS services fall into one of five protocols; ec2, query, json, rest-json, and rest-xml.*

The easiest way to determine the type of protocol a service uses would be to see its service-2.json file in botocore. For example, Lambda uses the rest-json protocol:

```json
{
  "version":"2.0",
  "metadata":{
	"apiVersion":"2015-03-31",
	"endpointPrefix":"lambda",
	"protocol":"rest-json",
	"serviceFullName":"AWS Lambda",
	"serviceId":"Lambda",
	"signatureVersion":"v4",
	"uid":"lambda-2015-03-31"
  }
}
  ```

  The protocol of the API will determine the structure of the API request. For example, the Amazon Elastic Container Service (ECS) using the json protocol. An API request for the ECS service could look like the following (with heavy editing to highlight certain points):


```http
POST / HTTP/1.1
Host: ecs.us-east-1.amazonaws.com
X-Amz-Target: AmazonEC2ContainerServiceV20141113.ListClusters
Content-Type: application/x-amz-json-1.1
Authorization: AWS4-HMAC-SHA256 Credential=ASIAEXAMPLEEXAMPLEEX/20230121/us-east-1/ecs/aws4_request, SignedHeaders=content-type;host;x-amz-date;x-amz-security-token;x-amz-target,...

{}

```

The most notable features of the json protocol are the `X-Amz-Target` header, which specifies the action to be performed, and the `Content-Type` header, which specifies which json version to use.

If we compare this with something like IAM, which uses the query protocol we see a much different structure:

```http
POST / HTTP/1.1
Host: iam.amazonaws.com
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Authorization: AWS4-HMAC-SHA256 Credential=ASIAEXAMPLEEXAMPLEEX/20230122/us-east-1/iam/aws4_request, SignedHeaders=content-type;host;x-amz-date;x-amz-security-token,... 

Action=ListUsers&Version=2010-05-08

```

Here, there is no `X-Amz-Target` header. It is instead passed as the `Action` parameter in the body of the request, which notably does not use JSON.


### Cross-Protocol Requests

So far we’re addressed that some AWS services communicate using specific protocols. What is interesting to note however, is that some services can actually speak multiple protocols. For example, ECS, which we demonstrated above uses the json protocol, can actually use query as well.

```htpp
POST / HTTP/1.1
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Host: ecs.us-east-1.amazonaws.com
Authorization: AWS4-HMAC-SHA256 Credential=ASIAQEPLEVBZIQ24U2FR/20230122/us-east-1/ecs/aws4_request, SignedHeaders=content-type;host;x-amz-date;x-amz-security-token,...

Action=ListClusters&Version=2014-11-13

```

[aws-api-protocols](https://frichetten.com/blog/aws-api-protocols/)


Opaque types + extension methods within a companion object

metals uses the scala3 presentation compiler

```curl
curl -d @bla.txt -H 'x-amz-content-sha256: 9955fb97fb73507e8eb72474f572afbba3b7d59d19324052bab4c5c949d9e1be' -H 'x-amz-target: DynamoDB_20120810.UpdateItem' -H 'content-type: application/x-amz-json-1.1' -H 'Host: dynamodb.eu-west-1.amazonaws.com' -H 'x-amz-date: 20160409T135929Z' -H 'authorization: AWS4-HMAC-SHA256 Credential=AKIAJT4RBNEWBQHRHKLA/20160409/eu-west-1/dynamodb/aws4_request, SignedHeaders=host;x-amz-date;x-amz-target, Signature=eabb94677b4a6dd812e2cfc1d2a756521d6fefa61e2e2a16c779def6875436b4' http://dynamodb.eu-west-1.amazonaws.com -vv
* Rebuilt URL to: http://dynamodb.eu-west-1.amazonaws.com/
*   Trying 176.32.111.182...
* Connected to dynamodb.eu-west-1.amazonaws.com (176.32.111.182) port 80 (#0)
> POST / HTTP/1.1
> Host: dynamodb.eu-west-1.amazonaws.com
> User-Agent: curl/7.43.0
> Accept: */*
> x-amz-content-sha256: 9955fb97fb73507e8eb72474f572afbba3b7d59d19324052bab4c5c949d9e1be
> x-amz-target: DynamoDB_20120810.UpdateItem
> content-type: application/x-amz-json-1.1
> x-amz-date: 20160409T135929Z
> authorization: AWS4-HMAC-SHA256 Credential=AKIAJT4RBNEWBQHRHKLA/20160409/eu-west-1/dynamodb/aws4_request, SignedHeaders=host;x-amz-date;x-amz-target, Signature=eabb94677b4a6dd812e2cfc1d2a756521d6fefa61e2e2a16c779def6875436b4
> Content-Length: 754
>
* upload completely sent off: 754 out of 754 bytes
< HTTP/1.1 404 Not Found
< x-amzn-RequestId: 7DJO7KONVCTIC0RTL2JGOTAS8BVV4KQNSO5AEMVJF66Q9ASUAAJG
< x-amz-crc32: 2548615100
< Content-Length: 272
< Date: Sat, 09 Apr 2016 14:06:07 GMT

```

To generate code from the smithy file, you need  the java smithy gradle plugin or the cli

protocol- serialization and transport (json and http,protobuf and grpc,)


## Traits
@nnotations that you can use to enrich your model with protocol specific constrains

Services can be annotated with protocol traits to signal how to communicate with a service

A protocol is a list of traits to consider when implementing


`An client codec for the AWS_JSON_1.0/AWS_JSON_1.1 protocol`
AwsJsonCodecs


## AWS Protocols
- AWS restJson1 protocol
- AWS JSON 1.0 protocol
- AWS JSON 1.1 protocol
- AWS restXml protocol
- AWS query protocol
- AWS EC2 query protocol


A service may support more than one protocol

A service can have zero or more resources

Both a service and a resource shape can contain zero or more operations

An operation consists of the input, output and set of possible errors

Simple types and Numeric types
- blob
- boolean
- document
- string
- timestamp
- integer
- short
- float
- bigInteger
- bigDecimal
- long
- byte
- double


Aggregate: list,map,union


 Smithy language parser and model builder, and Smithy4s - code generator, which produces HTTP server and client definitions using the following libraries:

- Http4s
- Cats-effect
- Jsoniter

Smithy is an IDL, allowing to describe both data and interactions (operations, services, errors) in a clear and concise manner. It can be used as the input to guide generation of any sort of client or server code, in any language - even if the generator itself has to be written in a JVM language, as that's what Smithy compiler currently targets.

![alt text](image.png)

This lets you write common logic in `shared`, use `jvm` for backend, and `js` for frontend.

[smithy4s-fullstack-part-1](https://blog.indoorvivants.com/2022-06-10-smithy4s-fullstack-part-1)

[smithy4s-fullstack-part-2](https://blog.indoorvivants.com/2022-06-11-smithy4s-fullstack-part-2)

[smithy4s-fullstack-part-3](https://blog.indoorvivants.com/2022-06-12-smithy4s-fullstack-part-3)
[smithy4s-fullstack-part-4](https://blog.indoorvivants.com/2022-06-13-smithy4s-fullstack-part-4)





### Protobuf

The `smithy4s-protobuf` module provides [protocol-buffers](https://protobuf.dev/) codecs that can read/write generated data-types from protobuf-encoded bytes.

```
sbt : "com.disneystreaming.smithy4s" %% "smithy4s-protobuf" % "@VERSION@"
mill : "com.disneystreaming.smithy4s::smithy4s-protobuf:@VERSION@"
```

The entrypoint for Protobuf parsing/writing is `smithy4s.protobuf.Protobuf`. See below for example usage.

```scala mdoc:reset
import smithy4s.example.hello.Person
import smithy4s.protobuf.Protobuf

val personCodec = Protobuf.codecs.fromSchema(Person.schema)
val personBytes = personCodec.writeBlob(Person(name = "John Doe"))
val maybePerson = personCodec.readBlob(personBytes)
```

By default, `smithy4s-protobuf` abides by the semantics of :

* [alloy protobuf traits](https://github.com/disneystreaming/alloy/blob/main/docs/serialisation/protobuf.md). These semantics are the exact same semantics that [smithy-translate](https://github.com/disneystreaming/smithy-translate) uses to translate smithy to protobuf. This implies that the Smithy4s protobuf codecs are compatible with the codecs of other protobuf tools, generated from the .proto files resulting from running smithy through smithy-translate. In short, Smithy4s and [ScalaPB](https://github.com/scalapb/ScalaPB) can talk to each other : the ScalaPB codecs generated from protobuf after a translation from smithy are able to decode binary data produced by Smithy4s protobuf codecs (and vice versa).


```
┌────────────────────┐                        ┌────────────────────┐
│                    │                        │                    │
│                    │                        │                    │
│                    │                        │                    │
│                    │                        │                    │
│     Smithy IDL     ├────────────────────────►    Protobuf IDL    │
│                    │   smithy-translate     │                    │
│                    │                        │                    │
│                    │                        │                    │
│                    │                        │                    │
└─────────┬──────────┘                        └─────────┬──────────┘
          │                                             │
          │                                             │
          │                                             │
          │                                             │
          │                                             │
          │                                             │
          │ Smithy4s codegen                            │ ScalaPB codegen
          │                                             │
          │                                             │
          │                                             │
          │                                             │
          │                                             │
┌─────────▼──────────┐                        ┌─────────▼──────────┐
│                    │                        │                    │
│                    │                        │                    │
│                    │                        │                    │
│                    ◄────────────────────────┤                    │
│    Smithy4s code   │  Runtime communication │     ScalaPB code   │
│                    ├────────────────────────►                    │
│                    │                        │                    │
│                    │                        │                    │
│                    │                        │                    │
└────────────────────┘                        └────────────────────┘
```

	
peterthehacker on May 7, 2021 | parent | context | favorite | on: Smithy: A language for defining services and SDKs

## How does this compare to Google’s protocol buffers? It looks like smithy has a broader set of applications. 


>>> Protobuf and gRPC are great, and AWS will continue to make sure developers can be successful using them with AWS. I’ll try to explain how we ended up at Smithy instead of using other existing tools.
We started working on Smithy around 2018 because we wanted to improve the scale of our API program and the AWS SDK team to deal with the growing number of services (over 250 now!) and languages we want to support in official AWS SDKs (like the newly released Rust SDK). We had a ton of existing services that we needed to be compatible with, but we also wanted to add new features to improve new services going forward too.

We needed a very flexible meta-model that allows us to continue to evolve the model to account for things like integrating with other systems and to model service-specific customizations that each AWS SDK team can implement independently. Smithy's meta-model is based on traits, a self-describing way to add more information to models. Lots of validation can be built in to custom traits, which helps to ensure that service teams are using traits properly and adhere to their specifications. Smithy's resource modeling helps us here too because it allows AWS service teams, as they adopt Smithy, to essentially automatically support CloudFormation resource schemas. Resources also help us to point service teams in the right direction to make their services work well over HTTP (which methods to use, URIs, safety, idempotency, etc).

We needed an integrated model validation, linting, and diff tool to keep services consistent and detect breaking changes, and it needed to support company-wide standards as well as service-specific standards. We use Smithy’s validation system to automatically enforce API standards, and service teams often create their own service-specific rules to keep their own internal consistency.

We needed built-in input validation constraints so that they're standard across services and clients (e.g., length, range, pattern, etc). We didn't want to rely on third-party extensions to provide this feature since validating inputs is important. AWS uses internal service frameworks that enforce these constraints and are compatible with Smithy models. We're working to create open source service frameworks for Smithy as well.

We also wanted to support various serialization formats so that clients work with all of our existing services spread across JSON, XML, query strings, RPC, and HTTP APIs, but we also wanted to be able to evolve our serialization formats in the future as new technology comes along. That's why Smithy is protocol agnostic (like gRPC actually). The serialization format is an implementation detail. Smithy has some support for MQTT as well.

And finally, we need our code generators to be really flexible to support service customizations. There's quite a few customizations across AWS services, and we needed a way to inject custom code generation logic in various parts of our generators.


[SimpleRestJson](https://github.com/disneystreaming/alloy/blob/main/docs/protocols/SimpleRestJson.md)


```json
{
    "version": "1.0",
    "imports": [
        "src/main/smithy",
        "target/scala-3.3.3/src_managed/main/scala"
    ],
    "maven": {
        "dependencies": [
            "com.disneystreaming.alloy:alloy-core:0.3.6"
        ],
        "repositories": []
    }
}

```

```json
"imports" : [
    "src/main/smithy",
    "target/scala-3.3.3/src_managed/main/smithy"
]
```

- Defines directories where Smithy should look for model files (.smithy files)
- src/main/smithy → Likely contains the manually written Smithy models.

- target/scala-3.3.3/src_managed/main/smithy → Likely contains generated Smithy models (e.g., from other sources or tools).

```json
"maven" : {
    "dependencies" : [
        "com.disneystreaming.alloy:alloy-core:0.3.6"
    ],
    "repositories" : [
    ]
}

```

- Declares Maven dependencies required for processing Smithy models.
- com.disneystreaming.alloy:alloy-core:0.3.6

- Repositories are empty ("repositories": []), meaning it will fetch dependencies from default Maven repositories (like Maven Central).


Currently protocol support is limited to the restJson1 protocol, which makes use of http bindings with a JSON body. It’s widely used among Amazon’s services, such as API Gateway and Lambda.
Now you need to create a configuration file named smithy-build.json. This configuration file lets you specify dependencies, configure plugins, and create projections, which are different views of your model catered to a specific purpose.
The following `smithy-build.json` file adds a few necessary dependencies and creates a projection to build the python client in. Create your smithy-build.json file in the same directory as your model folder with the following contents:
```json
{
    "version": "1.0",
    "sources": ["model"],
    "maven": {
        "dependencies": [
            "software.amazon.smithy:smithy-model:1.34.0",
            "software.amazon.smithy:smithy-aws-traits:1.34.0",
            "software.amazon.smithy.python:smithy-python-codegen:0.1.0"
        ]
    },
    "projections": {
        "python-client": {
            "plugins": {
                "python-client-codegen": {
                    "service": "com.example#EchoService",
                    "module": "echo",
                    "moduleVersion": "0.1.0"
                }
            }
        }
    }
}
```


Your file structure now should now look like this:

```sh
├── model
│   └── main.smithy
└── smithy-build.json
```

[introducing-smithy-for-python](https://aws.amazon.com/blogs/developer/introducing-smithy-for-python/)


// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-codegen-core
libraryDependencies += "software.amazon.smithy" % "smithy-codegen-core" % "1.54.0"
This module provides a code generation framework for generating clients, servers, documentation, and other artifacts for various languages from Smithy models.

// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-openapi
libraryDependencies += "software.amazon.smithy" % "smithy-openapi" % "1.54.0"
This module contains support for converting a Smithy model to OpenAPI.

// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-openapi-traits
libraryDependencies += "software.amazon.smithy" % "smithy-openapi-traits" % "1.54.0"

This module provides Smithy traits that are used in converting a Smithy model to OpenAPI.

Generates TypeScript code from Smithy models
Generates Scala code from Smithy models

// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-aws-iam-traits
libraryDependencies += "software.amazon.smithy" % "smithy-aws-iam-traits" % "1.54.0"

This module provides Smithy traits and validators for IAM

// https://mvnrepository.com/artifact/software.amazon.smithy/smithy-aws-traits
libraryDependencies += "software.amazon.smithy" % "smithy-aws-traits" % "1.54.0"

This module provides Smithy traits and validators that are used by most AWS services.

## SBT

Using the SBT plugin, the `Smithy4s` config object can be used to tag dependencies that Smithy4s should feed to the code generator.

You can declare your intent to depend on these smithy definitions as such:

```scala
libraryDependencies += "software.amazon.smithy" % "smithy-aws-iam-traits" % "1.14.1" % Smithy4s
```


## Consequence

This will have the effect of loading the contents of the smithy files (or smithy-compliant Json files) from the artifact into the aggregated model that Smithy4s uses as an input to the code generator. It means that the traits and shapes defined in these files will be available to use in your models, but it also means that Smithy4s will try to generate code for these shapes.

This artifact will not be included as a dependency to your project at compile-time (nor runtime), it will only be consumed for the
Smithy specs (and validators) it may contain.


### Manually skipping (or including) namespaces during code-generation.

Sometimes, you may want to tell Smithy4s to skip code-generation of some namespaces altogether, because the corresponding code may have been produced by another tool than Smithy4s. In that case, you can gain control over which namespaces Smithy4s crawls through when performing the code generation to avoid regenerating code that already exists. This is achieved via a couple of build-settings (the names are shared between SBT and Mill).

* `smithy4sAllowedNamespaces` which is an allow-list
* `smithy4sExcludedNamespaces` which is a disallow-list

By default, Smithy4s tries to generate everything but shapes that are in the following namespaces:

* `smithy4s.api`
* `smithy4s.meta`
* namespaces that start with `aws`
* namespaces that start with `smithy`



Protocol buffer is both an idl and a serialization mechanism
. it is used as an idl to define services in grpc