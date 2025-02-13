import com.running.* 

final case class DefaultRunningService[F[_]]() extends RunningService[F]{

  override def login(username: Option[String], password: Option[String]): F[LoginOutput] = ???

  override def ping(): F[PingOutput] = ???

  override def listActivities(username: String, nextToken: Option[String], maxResults: Option[Int]): F[ListActivitiesOutput] = ???

  override def isAuthenticated(username: String): F[IsAuthenticatedOutput] = ???

  override def getAthlete(athleteId: String): F[GetAthleteOutput] = ???

  override def exchangeToken(username: String, state: String, code: String, scope: List[String]): F[ExchangeTokenOutput] = ???

  override def getActivity(id: ActivityId): F[GetActivityOutput] = ???

  override def syncActivities(username: String): F[SyncActivitiesOutput] = ???

  override def authenticate(username: String): F[AuthenticationOutput] = ???

  override def signUp(username: String, password: String): F[SignUpOutput] = ???

  override def getAthleteFromUsername(username: String): F[GetAthleteFromUsernameOutput] = ???


}
