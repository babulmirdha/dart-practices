import 'package:loop_examples/loop_examples.dart' as loop_examples;


// write a program that will sum of 1,5,9,... <=100 and print each number while loop;

void main(List<String> arguments) {


  int sum = 0;
  for(int i=1;i<=100; i+=4)
  {
    print(i);
    sum+=i;

  }

    print(sum);
  }
