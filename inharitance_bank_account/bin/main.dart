import 'package:inheritance/bank_account.dart';

void main() {

  SavingAccount savings = SavingAccount( balance: 1000, interestRate: 0.05);

  savings.deposit(200);
  savings.addInterest();
  savings.withdraw(1500);

}