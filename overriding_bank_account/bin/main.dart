import 'package:overriding/bank-account.dart';

void main() {
  SavingsAccount savings = SavingsAccount(1000, 0.05);

  CheckingAccount checking = CheckingAccount( balance: 500,  overdraftLimit:200);

  savings.deposit(200);
  savings.addInterest();
  savings.withdraw(1500);

  checking.deposit(100);
  checking.withdraw(700);

}