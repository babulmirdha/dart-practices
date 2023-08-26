import 'package:tdd_bank_account/bank_account.dart';
import 'package:test/test.dart';

void main() {
  testAccountCreation();
  testDepositFunds();
  testWithdrawFunds();
}

void testAccountCreation() {
  group("Test Case 1: Account Creation", () {
    test('Creating a BankAccount with valid information', () {
      final account = BankAccount('John Doe', 1000.0);
      expect(account.accountNumber, isNotNull);
      expect(account.balance, 1000.0);
    });

    test('Creating a BankAccount with missing information', () {
      expect(() => BankAccount("", 0), throwsA(isA<ArgumentError>()));
    });

    test('Creating a BankAccount with negative initial balance', () {
      expect(() => BankAccount('Jane Smith', -200.0),
          throwsA(isA<ArgumentError>()));
    });
  });
}

void testDepositFunds() {
  group("Test Case 2: Deposit Funds", () {
    test('Depositing funds into a BankAccount with a positive amount', () {
      final account = BankAccount('Alice Johnson', 1500.0);
      account.deposit(500.0);
      expect(account.balance, 2000.0);
    });

    test('Depositing funds into a BankAccount with a negative amount', () {
      final account = BankAccount('Bob Brown', 800.0);
      expect(() => account.deposit(-200.0), throwsA(isA<ArgumentError>()));
    });

    test('Depositing funds into an invalid BankAccount', () {
      final account = BankAccount('Md Babul Mirdha', 500);

      account.isActive = false;

      expect(() => account.deposit(100.0), throwsA(isA<Exception>()));
    });
  });
}

testWithdrawFunds() {
  group("Test Case 3: Withdraw Funds", () {
    test('Withdrawing funds from a BankAccount with sufficient balance', () {
      final account = BankAccount('Eve Wilson', 3000.0);
      account.withdraw(1000.0);
      expect(account.balance, 2000.0);
    });

    test('Withdrawing funds from a BankAccount with negative amount', () {
      final account = BankAccount('Charlie Davis', 500.0);
      expect(() => account.withdraw(-200.0), throwsA(isA<ArgumentError>()));
    });

    test('Withdrawing funds from a BankAccount with insufficient balance', () {
      final account = BankAccount('Grace Turner', 200.0);
      expect(() => account.withdraw(500.0), throwsA(isA<Exception>()));
    });
  });
}
