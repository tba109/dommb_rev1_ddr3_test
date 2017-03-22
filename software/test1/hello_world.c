#include <stdio.h>
#include <unistd.h>
int main()
{
  
  unsigned int i = 0;
  unsigned char * ptr;
  printf("The address of ptr is 0x%x\n",(unsigned long)&ptr);
  // ptr = 0x00000001;
  ptr = 0x00ffffff;
  // ptr = 0x0fffffff;
  printf("The address pointed to by ptr is 0x%x\n",(unsigned long)ptr);
  printf("The contents of ptr is ptr = 0x%x\n",(unsigned char)*ptr);
  *ptr = 0;
  for (i = 0; i < 8 ; i++)
    {
      *ptr = 1 << i;
      printf("The contents of ptr is ptr = 0x%x\n",(unsigned char)*ptr);
    }
  
  printf("Waiting");
  for(i = 0; i < 10 ; i++)
    {
      usleep(1000000);
      printf("...%d",i+1);
    }
  printf("\n");
  printf("The contents of ptr is ptr = 0x%x\n",(unsigned char)*ptr);
  
  while(1);

  return 0;
}
