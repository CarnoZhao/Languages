public class Stack<T> {

	private int head;
	private Sequence_List<T> aList;

	public Stack() {
		aList = new Sequence_List<T>();
		head = -1;
	}

	public void clear() {
		aList.clear();
		head = -1;
	}

	public void push(T value) {
		aList.append(value);
		head ++;
	}

	public T pop() {
		if (isEmpty()) throw new Error("Pop from empty stack!");
		T ret = aList.getValue(head);
		aList.del(head);
		head --;
		return ret;
	}

	public T top() {
		if (isEmpty()) throw new Error("Stack is empty");
		return aList.getValue(head);
	}

	public boolean isEmpty() {
		return head == -1;
	}

	public void printAll() {
		aList.printAll();
	}

	public static void main(String[] args) {
		System.out.println("Stack:");
		Stack<Integer> st = new Stack<Integer>();
		for (int i = 0; i < 10; i ++) st.push(i);
		st.printAll();
		System.out.println(st.pop());
		st.printAll();
		System.out.println(st.top());
		st.printAll();
	}
}