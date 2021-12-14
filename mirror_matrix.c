/**
 * @file	mirror_matrix.c
 * @author	Simone Arcari
 *
 * @abstract	main file
 * @discussion	This code contains the mirror_matrix function which is the 
 *		equivalent implemented in assembly. 
 */


#include <stdio.h>
#include <stdlib.h>


/* function declarations */
int **create_matrix(int row, int col);
void popolate_matrix(int row, int col, int **mat, int values[row][col]);
void print_matrix(int **mat, int row, int col);
void mirror_matrix(int **mat, int row, int col);



int main(int argc, char **argv) {

	int m = 3;
	int n = 5;


	int **mat = create_matrix(m,3);
	int temp[3][5] = { {1,2,3,4,5}, {6,7,8,9,10}, {11,12,13,14,15}};
	
	popolate_matrix(m, n, mat, temp);
	
	printf("before:\n");
	print_matrix(mat, m, n);
	puts("");
	
	mirror_matrix(mat, m, n);

	printf("after:\n");
	print_matrix(mat, m, n);
	puts("");
	

	return 0;
}



int **create_matrix(int row, int col) {

	int **mat = malloc( row*sizeof(int *) );

	for(int i=0; i<row; i++) 
		mat[i] = malloc( col*sizeof(int) );

	return (mat);
}

void popolate_matrix(int row, int col, int **mat, int values[row][col]) {
	
	for(int i=0; i<row; i++) {
		for(int j=0; j<col; j++) {
			mat[i][j] = values[i][j];
		}
	}
}

void print_matrix(int **mat, int row, int col) {

	for(int i=0; i<row; i++) {
		for(int j=0; j<col; j++) {
			printf("\t%d", mat[i][j]);
		}
		puts("");
	}
}


/* MIRROR MATRIX FUNCTION IN C */
void mirror_matrix(int **mat, int row, int col) {
	
	for(int i=0; i<row; i++) 
		for(int j=0; j<col/2; j++) {
		
			int temp = mat[i][j];
			mat[i][j] = mat[i][col-j-1];
			mat[i][col-j-1] = temp;
	}
}

