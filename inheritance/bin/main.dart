import 'package:inheritance/checking-account.dart';
import 'package:inheritance/savings-account.dart';

void main() {
  SavingsAccount savings = SavingsAccount('SA123', 1000, 0.05);
  CheckingAccount checking = CheckingAccount('CA456', 500, 200);

  savings.deposit(200);
  savings.addInterest();
  savings.withdraw(1500);

  checking.deposit(100);
  checking.withdraw(700);

}