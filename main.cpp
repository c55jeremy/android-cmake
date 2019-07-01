/*
 * main.cpp
 *
 *  Created on: 2019 M06 28
 *      Author: jeremychen
 */
#include <vector>
#include <iostream>

using namespace std;

extern "C" int myfunc();

void printVector(vector<int> v)
{
    //lambda expression to print vector
    for_each(v.begin(), v.end(), [](int i)
    {
        cout << i << " ";
    });
    cout << endl;
}


int main() {
	// the iterator constructor can also be used to construct from arrays:
	  int myints[] = {16,2,77,29};
	  vector<int> v (myints, myints + sizeof(myints) / sizeof(int));
	  printVector(v);
#ifdef ANDROID
    cout<<"Hello Android! "<<myfunc()<<endl;
#else
    cout<<"Hello World!"<<endl;
#endif
	return 0;
}


