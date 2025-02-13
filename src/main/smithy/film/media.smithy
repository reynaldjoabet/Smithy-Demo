$version: "2"

namespace filmclub.media

use filmclub#VoteAverage
use filmclub#VoteCount

double AspectRatio

string ImagePath

integer Height

integer Width

string Iso6391

enum ImageType {
    POSTER
    BACKDROP
    LOGO
    PROFILE
    STILL
}

enum ImageSize {
    SMALL
    MEDIUM
    LARGE
    FULL
}

structure Image {
    @required
    filePath: ImagePath
    @required
    height: Height
    @required
    width: Width
    @required
    aspectRatio: AspectRatio
    @required
    voteAverage: VoteAverage
    @required
    voteCount: VoteCount
    iso_639_1: Iso6391
}

list Backdrops {
    member: Image
}

list Posters {
    member: Image
}

structure Images {
    @required
    backdrops: Backdrops
    @required
    posters: Posters
}

string VideoId

string VideoKey

string VideoName

string VideoSite

string VideoUrl

string Iso31661

intEnum VideoSize {
    SIZE_360 = 360
    SIZE_480 = 480
    SIZE_720 = 720
    SIZE_1080 = 1080
}

enum VideoType {
    TRAILER = "Trailer"
    TEASER = "Teaser"
    CLIP = "Clip"
    FEATURETTE = "Featurette"
    BEHIND_THE_SCENES = "Behind the Scenes"
    BLOOPERS = "Bloopers"
}

structure Video {
    @required
    id: VideoId
    @required
    key: VideoKey
    @required
    name: VideoName
    @required
    site: VideoSite
    @required
    size: VideoSize
    @required
    type: VideoType
    @required
    url: VideoUrl
    iso_639_1: Iso6391
    iso_3166_1: Iso31661
}

list Videos {
    member: Video
}

string ProviderId

string ProviderName

string LogoPath

integer DisplayPriority

structure WatchProvider {
    @required
    providerId: ProviderId
    @required
    providerName: ProviderName
    @required
    logoPath: LogoPath
    @required
    displayPriority: DisplayPriority
}

string ProviderLink

list BuyProviders {
    member: WatchProvider
}

list RentProviders {
    member: WatchProvider
}

list FlatrateProviders {
    member: WatchProvider
}

structure WatchProviders {
    @required
    link: ProviderLink
    buy: BuyProviders
    rent: RentProviders
    flatrate: FlatrateProviders
}