#include<stdio.h>
void main()
{
    int row=0;
    scanf("%d",&row);
    for(int i=0;i<2*row-1;i++){ //i=0 to 9
        int comp;
        if(i<row) // upper pyramid
            comp=2*(row-i)-1;
        else
        comp= 2*(i-row+1)+1;
    for(int j=0;j<comp;j++){
        printf(" ");
    }
        for(int k=0;k<2*row-comp;k++){
            printf("* ");
        }
        printf("\n");
    }
}