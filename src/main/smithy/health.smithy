$version: "2.0"

namespace jobs.spec

use alloy#simpleRestJson

@simpleRestJson
service HealthService {
  version: "1.0.0",
  operations: [HealthCheck]
}

@readonly
@http(method: "GET", uri: "/api/health", code: 200)
operation HealthCheck {
  output: HealthCheckOutput
}

structure HealthCheckOutput {
  service: String
}


