int factorial(var n) {

  if(n<0){
    throw ArgumentError("Negative number not allowed.");
  }

  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}
