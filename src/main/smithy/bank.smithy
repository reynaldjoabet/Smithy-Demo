$version: "2.0"

namespace com.bank

use alloy#simpleRestJson

/// Structure for a person's name
structure NameType {
    first: String
    last: String
}

/// Definition of MoneyType
structure MoneyType {
    @required
    amount: Float

    @required
    currency: String
}

/// BankAccount interface defining basic banking operations
service BankAccountService {
    version: "1.0"
    operations: [
        Balance
        Deposit
        Withdraw
    ]
}

/// Operation to get the account balance
@readonly
@http(method: "GET", uri: "/bank/{id}/balance")
operation Balance {
    input: BalanceInput
    output: BalanceOutput
}

structure BalanceOutput {}

structure BalanceInput {
    @required
    @httpLabel
    id: String
}

@http(method: "POST", uri: "/bank/{id}/deposit")
operation Deposit {
    input: DepositInput
    output: DepositOutput
}

structure DepositInput {
    @required
    @httpLabel
    id: String

    @required
    amount: MoneyType

    @required
    newBalance: MoneyType
}

structure DepositOutput {}

/// Operation to withdraw money
@http(method: "POST", uri: "/bank/{id}")
operation Withdraw {
    input: WithdrawInput
    output: WithdrawOutput
}

structure WithdrawInput {
    @httpLabel
    @required
    id: String

    @required
    amount: MoneyType
}

structure WithdrawOutput {
    newBalance: MoneyType
}

/// CheckingAccount extends BankAccount and adds check-writing functionality
@simpleRestJson
service CheckingAccountService {
    version: "1.0"
    operations: [
        WriteCheck
    ]
    errors: [
        BadCheck
    ]
}

structure WriteCheckInput {
    @required
    @httpLabel
    id: String

    @required
    amount: MoneyType
}

@error("client")
@httpError(404)
structure BadCheck {
    fee: MoneyType
}

/// Operation for writing a check
@http(method: "POST", uri: "/bank/{id}")
operation WriteCheck {
    input: WriteCheckInput
    output: WriteCheckOutput
    errors: [
        BadCheck
    ]
}

structure WriteCheckOutput {}

structure OpenAccountInput {
    @required
    @httpLabel
    id: String

    accountId: String

    deposit: MoneyType
}

@simpleRestJson
service BankManagerService {
    version: "1.0"
    operations: [
        OpenAccount
    ]
}

/// Operation to open a new checking account
@http(method: "POST", uri: "/bank/{id}")
operation OpenAccount {
    input: OpenAccountInput
    output: OpenAccountOutput
}

structure OpenAccountOutput {
    balance: MoneyType
    accountId: String
}
