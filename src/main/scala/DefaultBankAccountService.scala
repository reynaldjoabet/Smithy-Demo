import com.bank.*
final case class DefaultBankAccountService[F[_]]() extends BankAccountService[F]{

  override def balance(id: String): F[BalanceOutput] = ???

  override def deposit(id: String, amount: MoneyType, newBalance: MoneyType): F[DepositOutput] = ???

  override def withdraw(id: String, amount: MoneyType): F[WithdrawOutput] = ???


}
