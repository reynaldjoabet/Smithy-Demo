$version: "2"

namespace filmclub

use alloy#simpleRestJson
//use aws.protocols#restJson1
use filmclub.films#Film
use filmclub.films#FilmDetail
use filmclub.films#FilmId
use filmclub.films#ReleaseDate
use filmclub.media#ImagePath
use filmclub.media#ImageSize
use filmclub.media#ImageType
use smithy.framework#ValidationException


@simpleRestJson
service FilmService {
    version: "v1"
    operations: [
        GetUpcomingFilms
        GetFilmDetail
        GetImageData
    ]
    errors: [ValidationException]
}

integer Page

list UpcomingFilms {
    member: Film
}

integer TotalPages

integer TotalResults

@readonly
@http(method: "GET", uri: "/films/upcoming", code: 200)
operation GetUpcomingFilms {
    input := {
        @httpQuery("start")
        start: ReleaseDate
        @httpQuery("page")
        page: Page
    }
    output := {
        @required
        films: UpcomingFilms
        @required
        page: Page
        @required
        totalPages: TotalPages
        @required
        totalResults: TotalResults
    }
}

@readonly
@http(method: "GET", uri: "/films/detail/{id}", code: 200)
operation GetFilmDetail {
    input := {
        @required
        @httpLabel
        id: FilmId
    }
    output: FilmDetail
}

@readonly
@http(method: "GET", uri: "/media/images/{imageType}/{imagePath}", code: 200)
operation GetImageData {
    input := {
        @required
        @httpLabel
        imageType: ImageType
        @required
        @httpLabel
        imagePath: ImagePath
        @httpQuery("size")
        @default("SMALL")
        size: ImageSize
    }
    output := {
        @required
        @httpPayload
        imageData: Blob
    }
}