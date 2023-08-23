class BankAccount {
  String accountNumber;

  double _balance = 0;

  BankAccount(this.accountNumber, this._balance);

  double get balance => _balance;

  void deposit(double amount) {
    _balance += amount;
    print('$amount deposited. New balance: $balance');
  }

  void withdraw(double amount) {
    if (amount <= balance) {
      _balance -= amount;
      print('$amount withdrawn. New balance: $balance');
    } else {
      print('Insufficient funds');
    }
  }
}

class SavingsAccount extends BankAccount {
  double interestRate;

  SavingsAccount(String accountNumber, double balance, this.interestRate)
      : super(accountNumber, balance);

  void addInterest() {
    double interest = balance * interestRate;
    _balance += interest;
    print('Interest added: $interest. New balance: $balance');
  }
}

class CheckingAccount extends BankAccount {
  double overdraftLimit;

  CheckingAccount(String accountNumber, double balance, this.overdraftLimit)
      : super(accountNumber, balance);

  @override
  void withdraw(double amount) {
    if (amount <= balance + overdraftLimit) {
      _balance -= amount;
      print('$amount withdrawn. New balance: $balance');
    } else {
      print('Exceeds overdraft limit');
    }
  }
}