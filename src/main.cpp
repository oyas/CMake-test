#include <cstdio>
#include "module1/func1.h"
#include "module1/subdir/sub.h"

int main(){
	printf("hello, world\n");
	func1();
	sub_func();
	return 0;
}
