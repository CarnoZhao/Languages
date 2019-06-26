#include <stdio.h>
#include <iostream>
using namespace std;

template <class T> class Stack
{
private:
	int size;
	int maxSize = 1;
	T *aList;

public:
	Stack(){
		aList = new T[maxSize];
		size = 0;
	}

	~Stack(){
		clear();
	}
	
};