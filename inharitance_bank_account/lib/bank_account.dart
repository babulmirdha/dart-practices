class BankAccount {

  double _balance = 0;

  BankAccount({double balance = 0}) : _balance = balance;

  double get balance => _balance;

  deposit(double amount) {
    _balance += amount;
    print('${this.runtimeType}: $amount deposited. New balance: $_balance');
  }

  bool withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      print('${this.runtimeType}: $amount withdrawn. New balance: $balance');
      return true;
    }else{
      print('${this.runtimeType}: Insufficient funds');
      return false;
    }

  }
}

class SavingAccount extends BankAccount {
  double _interestRate = 0;

  SavingAccount({double balance = 0, double interestRate = 0})
      : _interestRate = interestRate,
        super( balance: balance);

  double get interestRate => _interestRate;

  set interestRate(double value) {
    if (value > 0) {
      _interestRate = value;
    }
  }

  addInterest() {
    double interest = _balance * _interestRate;
    _balance += interest;
    print('${this.runtimeType}: Interest added: $interest. New balance: $balance');
  }
}