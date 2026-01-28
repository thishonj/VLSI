#include<stdio.h>
void main()
{
    int row=0,column=0;
    scanf("%d%d",&row,&column);
    for(int i=0;i<row;i++){
        for(int j=0;j<(column-i)-1;j++){
            printf(" ");
        }
        for(int k=0;k<column;k++){
            printf("* ");
        }
        printf("\n");
    }
}