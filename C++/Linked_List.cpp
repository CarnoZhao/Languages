#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

template <class T> class Node
{
public:
	T val;
	Node<T>* next;
	Node(const T value){
		val = value;
		next = NULL;
	}
	Node(){
		next = NULL;
	}
};

template <class T> class Linked_List
{
private:
	Node<T> *head, *tail;
	int length = 0;
	Node<T> *setPos(const int i){
		int cnt = 0;
		if(i == -1) return head;
		Node<T> *p;
		p = head -> next;
		while(p != NULL && cnt < i){
			p = p -> next;
			cnt ++;
		}
		return p;
	}

public:
	Linked_List(){
		head = new Node<T>();
	}

	bool isEmpty(){
		return head -> next == NULL;
	}

	void clear(){
		head -> next = NULL;
	}

	int len(){
		return length;
	}

	bool append(const T value){
		Node<T> *q;
		q = new Node<T>(value);
		if(head -> next != NULL){
			tail -> next = q;
		} else{
			head -> next = q;
		}
		tail = q;
		length ++;
		return true;
	}

	bool insert(const int i, const T value){
		Node<T> *p, *q;
		if((p = setPos(i - 1)) == NULL){
			cout << "Illegal insertion" << endl;
			return false;
		}
		q = new Node<T>(value);
		q -> next = p -> next;
		p -> next = q;
		if(p == tail) tail = q;
		length ++;
		return true;
	}

	bool del(const int i){
		Node<T> *p, *q;
		if((p = setPos(i - 1)) == NULL || p == tail){
			cout << "Illegal deletion" << endl;
			return false;
		}
		q = p -> next;
		if(q == tail){
			tail = p;
			p -> next = NULL;
		} else{
			p -> next = q -> next;
		}
		delete q;
		length --;
		return true;
	}

	bool getValue(const int p, T &value){
		if(p >= length){
			cout << "Out of range!" << endl;
			return false;
		}
		Node<T> *q;
		q = head -> next;
		for(int i = 0; i < p; i ++){
			q = q -> next;
		}
		value = q -> val;
		return true;
	}

	bool getPos(int &p, const T value){
		Node<T> *q;
		int cnt = 0;
		q = head -> next;
		while(q != NULL){
			if(q -> val == value) break;
			cnt ++;
			q = q -> next;
		}
		if(q != NULL){
			p = cnt;
			return true;
		} else{
			cout << "Not exist!" << endl;
			p = -1;
			return false;
		}
	}

	void printAll(){
		Node<T> *p;
		p = head -> next;
		while(p != NULL){
			cout << p -> val << " ";
			p = p -> next;
		}
		cout << "NULL" << endl;
	}
	
};

int main(){
	Linked_List<int> list;
	for(int i = 0; i < 10; i ++){
		list.append(i);
	}
	list.printAll();
	list.insert(2, 10);
	list.printAll();
	list.del(3);
	list.printAll();
	int x;
	list.getValue(2, x);
	cout << x << endl;
	int y;
	list.getPos(y, 10);
	cout << y << endl;
	return 0;
}