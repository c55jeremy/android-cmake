/*
 * func.c
 *
 *  Created on: 2019 M07 1
 *      Author: jeremychen
 */
#include <stdio.h>

int myfunc(){
	printf("Hello! %s\n",__func__);
	return 999;
}



