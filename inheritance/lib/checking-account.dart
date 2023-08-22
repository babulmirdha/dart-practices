import 'bank-account.dart';

class CheckingAccount extends BankAccount {
  double overdraftLimit;

  CheckingAccount(String accountNumber, double balance, this.overdraftLimit)
      : super(accountNumber, balance);

  @override
  void withdraw(double amount) {
    if (amount <= balance + overdraftLimit) {
      balance -= amount;
      print('$amount withdrawn. New balance: $balance');
    } else {
      print('Exceeds overdraft limit');
    }
  }
}