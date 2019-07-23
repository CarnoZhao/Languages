public class Linked_Stack<T> {
	private Linked_List<T> aList;

	public Linked_Stack() {
		aList = new Linked_List<T>();
	}

	public void clear() {
		aList.clear();
	}

	public void push(T value) {
		aList.insert(0, value);
	}

	public T pop() {
		if (isEmpty()) throw new Error("Pop from empty stack!");
		T ret = aList.getValue(0);
		aList.del(0);
		return ret;
	}

	public T top() {
		if (isEmpty()) throw new Error("Stack is empty");
		return aList.getValue(0);
	}

	public boolean isEmpty() {
		return aList.isEmpty();
	}

	public void printAll() {
		aList.printAll();
	}

	public static void main(String[] args) {
		System.out.println("Linked Stack:");
		Linked_Stack<Integer> st = new Linked_Stack<Integer>();
		for (int i = 0; i < 10; i ++) st.push(i);
		st.printAll();
		System.out.println(st.pop());
		st.printAll();
		System.out.println(st.top());
		st.printAll();
		st.clear();
		st.printAll();
	}
}