import 'package:tdd_bank_account/bank_account.dart';
import 'package:test/test.dart';

void main() {
  test('Open a new account with deposit amount 5000', () {
    BankAccount account = BankAccount();
    account.deposit(5000.00);
    expect(5000.00, account.balance);
  });

  test("Open a new account  with deposit amount  1000 then deposit 200", () {
    BankAccount account = BankAccount();

    account.deposit(1000.00);
    expect(1000.00, account.balance);
    account.deposit(200.00);
    expect(1200.00, account.balance);
  });
  
  
  test("Open a new account with deposit amount 800 then withdraw 200", () {

  });


  test("Open a new accountA with deposit amount 2000 the Transfer 1500 to AccountB who has already 700", () => null);


}
