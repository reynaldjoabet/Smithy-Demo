import com.bank.*
final case class DefaultCheckingAccountService[F[_]]() extends CheckingAccountService[F]{

  override def writeCheck(id: String, amount: MoneyType): F[WriteCheckOutput] = ???


}
