#include<stdio.h>
void main()
{
    int row=0;
    scanf("%d",&row);
    for(int i=0;i<row;i++){
        for(int j=0;j<(row-i)-1;j++){
            printf(" ");
        }
        for(int k=0;k<row;k++){
            printf("* ");
        }
        printf("\n");
    }
}