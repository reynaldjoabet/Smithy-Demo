$version: "2"

namespace com.cloud.picture

use com.cloud.common#ValidatedOperation
use com.cloud.main#BadRequestError
use com.cloud.main#NotFoundError

resource Picture {
    identifiers: {
        pictureId: String
        dateId: String
    }
    create: CreatePicture
    read: GetPicture
    // update: UpdatePicture,
    delete: DeletePicture
    // list: ListPictures,
}

@http(method: "POST", uri: "/v1/dates/{dateId}/pictures")
operation CreatePicture with [ValidatedOperation] {
    input: CreatePictureInput
    output: CreatePictureOutput
}

@input
structure CreatePictureInput for CreatePicture {
    @required
    @httpLabel
    dateId: String

    @required
    @httpPayload
    imageData: Blob
}

@output
structure CreatePictureOutput for CreatePicture {
    @required
    pictureId: String

    @required
    success: Boolean
}

@http(method: "GET", uri: "/v1/dates/{dateId}/pictures/{pictureId}")
@readonly
operation GetPicture with [ValidatedOperation] {
    input: GetPictureInput
    output: GetPictureOutput
}

@input
structure GetPictureInput for GetPicture {
    @required
    @httpLabel
    pictureId: String

    @httpLabel
    @required
    dateId: String
}

@output
structure GetPictureOutput for GetPicture {
    @required
    @httpPayload
    data: Blob
}

// @http(method: "PUT", uri: "/pictures/{id}")
// operation UpdatePicture with [ValidatedOperation] {
//     input: UpdatePictureInput
//     output: UpdatePictureOutput
// }
// structure UpdatePictureInput {
//     @required
//     @httpLabel
//     id: String,
//     dateId: String,
//     @httpPayload
//     imageData: Blob
// }
// structure UpdatePictureOutput {
//     @required
//     success: Boolean
// }
@http(method: "DELETE", uri: "/v1/dates/{dateId}/pictures/{pictureId}")
@idempotent
operation DeletePicture with [ValidatedOperation] {
    input: DeletePictureInput
    output: DeletePictureOutput
}

@input
structure DeletePictureInput for DeletePicture {
    @required
    @httpLabel
    pictureId: String

    @httpLabel
    @required
    dateId: String
}

@output
structure DeletePictureOutput for DeletePicture {
    @required
    success: Boolean
}
// @http(method: "GET", uri: "/pictures")
// operation ListPictures with [ValidatedOperation] {
//     input: ListPicturesInput
//     output: ListPicturesOutput
// }
// structure ListPicturesInput {
//     nextToken: String,
//     limit: Integer
// }
// structure ListPicturesOutput {
//     @required
//     pictures: PictureList,
//     nextToken: String
// }
// list PictureList {
//     member: PictureMetadata
// }
// structure PictureMetadata {
//     @required
//     id: String,
//     @required
//     dateId: String
// }
