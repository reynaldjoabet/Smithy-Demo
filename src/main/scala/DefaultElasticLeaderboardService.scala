import leaderboard.*
final case class  DefaultElasticLeaderboardService[F[_]]() extends ElasticLeaderboardService[F] {

  override def getLeaderboard(id: LeaderboardId): F[GetLeaderboardOutput] = ???

  override def createLeaderboard(name: String, maxEntries: MaxEntries, token: Option[String]): F[CreateLeaderboardOutput] = ???

  override def listLeaderboards(nextToken: Option[String], maxResults: Option[Int]): F[ListLeaderboardsOutput] = ???

  override def updateLeaderboard(id: LeaderboardId, name: Option[String]): F[Unit] = ???

  override def submitScoreEvent(id: LeaderboardId, scoreEvent: ScoreEvent): F[Unit] = ???

  override def deleteLeaderboard(id: LeaderboardId): F[Unit] = ???

  
}
