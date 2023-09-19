class BankAccount {
  double _balance;

  BankAccount( this._balance);

  void deposit(double amount) {
    _balance += amount;
    print('$amount deposited. New balance: $_balance');
  }

  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      print('$amount withdrawn. New balance: $_balance');
    } else {
      print('Insufficient funds');
    }
  }
}


class SavingsAccount extends BankAccount {
  double interestRate;

  SavingsAccount( double balance, this.interestRate)
      : super( balance);

  void addInterest() {
    double interest = _balance * interestRate;
    _balance += interest;
    print('Interest added: $interest. New balance: $_balance');
  }
}

class CheckingAccount extends BankAccount {

  final double _overdraftLimit;

  CheckingAccount({double balance=0, double overdraftLimit=0})
      : _overdraftLimit = overdraftLimit, super(balance);

  @override
  bool withdraw(double amount) {
    if (amount <= _balance + _overdraftLimit) {
      _balance -= amount;
      print('${this.runtimeType}: $amount withdrawn. New balance: $_balance');
      return true;
    } else {
      print('${this.runtimeType}: Exceeds overdraft limit');
      return false;
    }
  }
}