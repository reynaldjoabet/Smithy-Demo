$version: "2.0"

namespace com.minerva

use smithy.framework#ValidationException

resource Dataset {
  identifiers: { datasetId: String }
  create: CreateDataset,
  list: ListDataset,
  read: GetDataset,
  operations: [QueryDataset, SampleDataset]
}

@http(uri: "/datasets", method: "POST", code: 201)
operation CreateDataset {
  input := {
    @required
    name: String,
    @required
    sql: String,
  },
  output := {
    @httpHeader("x-dataset-name")
    @required
    name: String
  }
  errors: [ValidationException, ThrottlingError, ServerError]
}

@readonly
@paginated(inputToken: "nextToken", outputToken: "nextToken",
           pageSize: "size", items: "items")
@http(method: "GET", uri: "/datasets")
operation ListDataset {
  input := {
    @httpQuery("limit")
    size: Integer = 50,
    @httpQuery("nextToken")
    nextToken: String,
  }
  output := {
    @required
    items: DatasetList,
    nextToken: String,
  }
  errors: [ValidationException, ThrottlingError, ServerError]
}

@readonly
@http(method: "GET", uri: "/datasets/{datasetId}")
operation GetDataset {
  input := {
    @httpLabel
    @required
    datasetId: String
  },
  output: DatasetInfo
  errors: [ValidationException, NotFoundError, ThrottlingError, ServerError]
}

@http(method: "POST", uri: "/datasets/{datasetId}/query")
operation QueryDataset {
  input := {
    @httpLabel
    @required
    datasetId: String,
    @required
    sql: String,
  },
  output := {
      @required
      data: Blob,
  }
  errors: [ValidationException, NotFoundError, ClickhouseQueryError, ThrottlingError, ServerError]
}

@readonly
@http(method: "GET", uri: "/datasets/{datasetId}/sample")
operation SampleDataset {
  input := {
    @httpLabel
    @required
    datasetId: String,
    @httpQuery("limit")
    size: Integer = 100,
  },
  output := {
      @required
      data: Blob,
  }
  errors: [ValidationException, NotFoundError, ThrottlingError, ServerError]
}