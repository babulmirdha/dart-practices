import 'package:inheritance/bank_account.dart';

void main() {

  SavingAccount savings = SavingAccount( balance: 1000, interestRate: 0.05);
  CheckingAccount checking = CheckingAccount( balance: 500,  overdraftLimit:200);

  savings.deposit(200);
  savings.addInterest();
  savings.withdraw(1500);

  checking.deposit(100);
  checking.withdraw(700);

}