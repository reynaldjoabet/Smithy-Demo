$version: "2"

namespace filmclub.films

use filmclub#Popularity
use filmclub#VoteAverage
use filmclub#VoteCount
use filmclub.credits#Credits
use filmclub.media#Images
use filmclub.media#Videos
use filmclub.media#WatchProviders

integer FilmId

string FilmTitle

string FilmOverview

string OriginalTitle

string OriginalLanguage

timestamp ReleaseDate

string PosterPath

string BackdropPath

integer GenreId

string GenreName

structure Genre {
    @required
    id: GenreId
    @required
    name: GenreName
}

list Genres {
    member: Genre
}

structure Film {
    @required
    id: FilmId
    @required
    title: FilmTitle
    @required
    overview: FilmOverview
    @required
    genres: Genres
    @required
    popularity: Popularity
    @required
    voteAverage: VoteAverage
    @required
    voteCount: VoteCount
    @required
    originalTitle: OriginalTitle
    @required
    originalLanguage: OriginalLanguage
    releaseDate: ReleaseDate
    posterPath: PosterPath
    backdropPath: BackdropPath
}

enum FilmStatus {
    RUMORED = "Rumored"
    PLANNED = "Planned"
    IN_PRODUCTION = "In Production"
    POST_PRODUCTION = "Post Production"
    RELEASED = "Released"
    CANCELLED = "Cancelled"
}

list SimilarFilms {
    member: Film
}

integer Budget

string Homepage

string ImdbId

string Rating

integer Revenue

integer Runtime

string Tagline

structure FilmDetail {
    @required
    id: FilmId
    @required
    title: FilmTitle
    @required
    overview: FilmOverview
    @required
    genres: Genres
    @required
    status: FilmStatus
    @required
    originalLanguage: OriginalLanguage
    @required
    originalTitle: OriginalTitle
    @required
    popularity: Popularity
    @required
    voteAverage: VoteAverage
    @required
    voteCount: VoteCount
    @required
    images: Images
    @required
    videos: Videos
    @required
    credits: Credits
    @required
    similar: SimilarFilms
    tagline: Tagline
    releaseDate: ReleaseDate
    rating: Rating
    runtime: Runtime
    posterPath: PosterPath
    backdropPath: BackdropPath
    homepage: Homepage
    budget: Budget
    revenue: Revenue
    imdbId: ImdbId
    watchProviders: WatchProviders
}