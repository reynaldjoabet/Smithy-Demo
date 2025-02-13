$version: "2"

namespace filmclub.credits

use filmclub#Popularity

integer CastId

string CastName

string OriginalCastName

string Character

string CreditId

integer CastOrder

string ProfilePath

structure CastMember {
    @required
    id: CastId
    @required
    name: CastName
    @required
    originalName: OriginalCastName
    @required
    character: Character
    @required
    popularity: Popularity
    @required
    creditId: CreditId
    @required
    order: CastOrder
    profilePath: ProfilePath
}

integer CrewId

string CrewName

string OriginalCrewName

string Department

string Job

structure CrewMember {
    @required
    id: CrewId
    @required
    name: CrewName
    @required
    originalName: OriginalCrewName
    @required
    popularity: Popularity
    @required
    creditId: CreditId
    @required
    department: Department
    @required
    job: Job
    profilePath: ProfilePath
}

list Cast {
    member: CastMember
}

list Crew {
    member: CrewMember
}

structure Credits {
    @required
    cast: Cast
    @required
    crew: Crew
}