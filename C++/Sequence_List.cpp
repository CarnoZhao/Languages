#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;


template <class T> class Sequence_List{
private:
	T *aList;
	int maxSize = 1;
	int curLen;
	int position;

	void checkFull(){
		if(curLen >= maxSize){
			maxSize *= 2;
			T *newList = new T[maxSize];
			for(int i = 0; i < curLen; i ++){
				newList[i] = aList[i];
			}
			aList = newList;
		}
	}

	void checkHalf(){
		if(curLen <= maxSize / 2){
			maxSize /= 2;
			T *newList = new T[maxSize];
			for(int i = 0; i < curLen; i ++){
				newList[i] = aList[i];
			}
			aList = newList;
		}
	}

	void checkOut(const int p, const int threshold){
		try{
			if(p > threshold) throw "ERROR: Position out of range!";
		} catch(const char * err){
			cout << err << endl;
			exit(1);
		}
	}

public:
	Sequence_List(){
		aList = new T[maxSize];
		curLen = position = 0;
	}

	~Sequence_List(){
		delete [] aList;
	}

	void clear(){
		curLen = 0;
		maxSize = 1;
		aList = new T[maxSize];
	}

	bool isEmpty(){
		return curLen == 0;
	}

	void append(const T value){
		checkFull();
		aList[position] = value;
		position ++;
		curLen ++;
	}

	void insert(const int p, const T value){
		checkFull();
		checkOut(p, curLen);
		for(int i = curLen; i >= p; i --){
			aList[i] = aList[i - 1];
		}
		aList[p] = value;
		curLen ++;
	}

	void del(const int p){
		checkHalf();
		checkOut(p, curLen - 1);
		for(int i = p; i < curLen - 1; i ++){
			aList[i] = aList[i + 1];
		}
		curLen --;
	}

	int getPos(const T value){
		int i;
		for(i = 0; i < curLen; i ++){
			if(aList[i] == value) break;
		}
		try{
			if(i != curLen){
				return i;
			} else{
				throw "ERROR: Not exist!";
			}
		} catch(const char * err){
			cout << err << endl;
			exit(1);
		}
	}

	T getValue(const int p){
		checkOut(p, curLen - 1);
		return aList[p];
	}

	void setValue(const int p, const T value){
		checkOut(p, curLen - 1);
		aList[p] = value;
	}

	void printAll(){
		for(int i = 0; i < curLen; i ++){
			cout << aList[i] << " ";
		}
		cout << "| " << maxSize;
		cout << "\n";
	}
	
};

int main(){
	Sequence_List<int> list;
	for(int i = 0; i < 10; i ++){
		list.append(i);
	}
	list.printAll();
	list.insert(1, 10);
	for(int i = 0; i < 6; i ++){
		list.del(0);
	}
	cout << "set" << endl;
	list.setValue(3, 10);
	cout << "get" << endl;
	cout << list.getValue(1) << " | GetValue\n";
	list.printAll();
	cout << list.getPos(9) << " | GetPos\n";
	cout << list.getValue(0) << " | GetValue\n";
	return 0;
}