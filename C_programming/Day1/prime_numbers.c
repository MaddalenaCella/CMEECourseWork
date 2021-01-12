#include <stdio.h>

int main() {
  for (int counter = 2; counter <= 100; counter++) {
    int isPrime = 1;
    for (int lower = 2; lower < counter; lower++) {
      if (counter % lower == 0) {
        isPrime = 0;
        break;
      }
    }
    if (isPrime == 1) {
        printf("%i, \n", counter);
    }
  }
  return 0;
}