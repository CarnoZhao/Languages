public class Queue<T> {
	private Sequence_List<T> aList;
	private int head = 0;
	private int tail;

	public Queue() {
		aList = new Sequence_List<T>();
		tail = 0;
	}

	public void clear() {
		aList.clear();
	}

	public void enQueue(T value) {
		aList.append(value);
		tail ++;
	}

	public T deQueue() {
		T ret = aList.getValue(head);
		aList.del(head);
		tail --;
		return ret;
	}

	public T getFront() {
		return aList.getValue(head);
	}

	public boolean isEmpty() {
		return tail == 0;
	}

	public void printAll() {
		aList.printAll();
	}

	public static void main(String[] args) {
		System.out.println("Queue:");
		Queue<Integer> st = new Queue<Integer>();
		for (int i = 0; i < 10; i ++) st.enQueue(i);
		st.printAll();
		System.out.println(st.deQueue());
		st.printAll();
		System.out.println(st.getFront());
		st.printAll();
	}
}