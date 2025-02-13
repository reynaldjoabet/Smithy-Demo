import com.minerva.*

final case class DefaultDatasetService[F[_]]() extends DatasetService[F]{

  override def healthCheck(message: String): F[HealthCheckOutput] = ???

  override def signin(username: String, password: String): F[SigninOutput] = ???

  override def createDataset(name: String, sql: String): F[CreateDatasetOutput] = ???

  override def sampleDataset(datasetId: String, size: Int): F[SampleDatasetOutput] = ???

  override def listDataset(size: Int, nextToken: Option[String]): F[ListDatasetOutput] = ???

  override def getDataset(datasetId: String): F[DatasetInfo] = ???

  override def queryDataset(datasetId: String, sql: String): F[QueryDatasetOutput] = ???


}
