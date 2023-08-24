import "bank-account.dart";

class SavingsAccount extends BankAccount {
  double interestRate;

  SavingsAccount(String accountNumber, double balance, this.interestRate)
      : super(accountNumber, balance);

  void addInterest() {
    double interest = balance * interestRate;
    balance += interest;
    print('Interest added: $interest. New balance: $balance');
  }
}