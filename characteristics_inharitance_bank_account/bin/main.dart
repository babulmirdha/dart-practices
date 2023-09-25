import 'package:inheritance/bank_account.dart';

void main() {

  SavingAccount savings = SavingAccount( balance: 1000, interestRate: 0.05);

  savings.deposit(200);

  print("Balance: ${savings.balance}");

  savings.addInterest();
  print("Balance: ${savings.balance}");

  savings.withdraw(1200);
  print("Balance: ${savings.balance}");

}