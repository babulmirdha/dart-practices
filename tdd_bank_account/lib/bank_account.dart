class BankAccount {
  String _accountNumber = '';
  String _accountTitle = '';
  double _balance = 0;

  bool _isActive = true;

  BankAccount(String accountTitle, double balance) {
    if (accountTitle.isEmpty || balance < 0) {
      throw ArgumentError("Invalid account information");
    }

    _accountTitle = accountTitle;
    _balance = balance;
    _accountNumber = generateAccountNumber();

    print("acNo $_accountNumber");
  }

  String get accountNumber => _accountNumber;

  String get accountTitle => _accountTitle;

  double get balance => _balance;

  set isActive(bool isActive) {
    _isActive = isActive;
  }

  deposit(double amount) {
    if (!_isActive) {
      throw Exception("Account Status is inactive");
    }

    if (amount < 0) {
      throw ArgumentError("Invalid deposit amount");
    }

    _balance += amount;
    print('${this.runtimeType}: $amount deposited. New balance: $_balance');
  }

  void withdraw(double amount) {
    if (amount < 0) {
      throw ArgumentError("Invalid withdraw amount");
    }

    if (amount <= _balance) {
      _balance -= amount;
      print('${this.runtimeType}: $amount withdrawn. New balance: $balance');
    } else {
      print('${this.runtimeType}: Insufficient balance');
      throw Exception("Insufficient funds");
    }
  }

  String generateAccountNumber() {
    return 'AC${DateTime.now().millisecondsSinceEpoch}';
  }
}
