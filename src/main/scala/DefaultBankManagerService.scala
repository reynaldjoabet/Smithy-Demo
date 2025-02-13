import com.bank.*

final case class DefaultBankManagerService[F[_]]() extends BankManagerService[F] {

  override def openAccount(id: String, accountId: Option[String], deposit: Option[MoneyType]): F[OpenAccountOutput] = ???

  
}
