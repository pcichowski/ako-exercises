#include <stdio.h>

int max_4(int a, int b, int c, int d);

void liczba_przeciwna(int* a);

void odejmij_jeden(int** liczba);

int main() {
	
	int k;
	int* wsk;
	wsk = &k;

	printf("\nProsze napisac liczbe: ");
	scanf_s("%d", &k, 12);
	odejmij_jeden(&wsk);

	printf("\nWynik = %d\n", k);


	/*printf("hellow\n");

	int wynik = max_4(12, 10, 2, 7);

	int g = 15;

	liczba_przeciwna(&g);

	printf("%d\n\n%d\n", wynik, g);
	*/
	return 0;
}