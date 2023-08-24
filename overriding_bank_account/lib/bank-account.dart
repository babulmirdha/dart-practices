class BankAccount {
  String accountNumber;
  double balance;

  BankAccount(this.accountNumber, this.balance);

  void deposit(double amount) {
    balance += amount;
    print('$amount deposited. New balance: $balance');
  }

  void withdraw(double amount) {
    if (amount <= balance) {
      balance -= amount;
      print('$amount withdrawn. New balance: $balance');
    } else {
      print('Insufficient funds');
    }
  }
}