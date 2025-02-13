$version: "2"

namespace utils

structure authToken{
  @required
  roles: StringList
}

list StringList{
    member: String
}