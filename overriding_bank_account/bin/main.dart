import 'package:overriding/savings-account.dart';

void main() {
  SavingsAccount savings = SavingsAccount('SA123', 1000, 0.05);

  savings.deposit(200);
  savings.addInterest();
  savings.withdraw(1500);

}