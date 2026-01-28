#include<stdio.h>
void main()
{
    int row=0,column=0,i=0,j=0,k=0;
    scanf("%d%d",&row,&column);
    for(i=0;i<row;i++){
        for(j=0;j<(column-i)-1;j++){
            printf(" ");
        }
        for(k=0;k<column;k++){
            if(k==0||k==column-1||i==0||i==row-1){
            printf("*");}
            else
            printf(" ");
        }
        printf("\n");
    }
}