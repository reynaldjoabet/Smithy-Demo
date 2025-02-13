import jobs.spec.*
final case class DefaultHealthService[F[_]]()extends HealthService[F]{

    override def healthCheck(): F[HealthCheckOutput] = ???
}
