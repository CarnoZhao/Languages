public class Linked_List<T> {
	private class Node {
		public T val;
		public Node next;
		public Node(T value) {
			val = value;
			next = null;
		}		
	}

	private Node head, tail;
	private int length = 0;

	private Node setPos(int i) {
		int cnt = 0;
		if (i == -1) return head;
		Node p;
		p = head.next;
		while (p != null && cnt < i) {
			p = p.next;
			cnt ++;
		}
		return p;
	}

	public Linked_List() {
		head = new Node(null);
	}

	public void clear() {
		head.next = null;
		tail = null;
	}

	public boolean isEmpty() {
		return head.next == null;
	}

	public int len() {
		return length;
	}

	public void append(T value) {
		Node q;
		q = new Node(value);
		if (head.next != null) {
			tail.next = q;
		} else {
			head.next = q;
		}
		tail = q;
		length ++;
	}

	public void insert(int i, T value) {
		Node p, q;
		p = setPos(i - 1);
		if (p == null) throw new Error("Index out of range!");
		q = new Node(value);
		q.next = p.next;
		p.next = q;
		if (p == tail) tail = q;
		length ++;
	}

	public void del(int i) {
		Node p, q;
		p = setPos(i - 1);
		if (p == null || p == tail) throw new Error("Index out of range!");
		q = p.next;
		if (q == tail) {
			tail = p;
			p.next = null;
		} else {
			p.next = q.next;
		}
		length --;
	}

	public T getValue(int i) {
		if (i >= length) throw new Error("Index out of range!");
		Node p = head.next;
		for (int j = 0; j < i; j ++) p = p.next;
		return p.val;
	}

	public int getPos(T value) {
		int idx = 0;
		Node p = head.next;
		while (p != null) {
			if (p.val == value) break;
			idx ++;
			p = p.next;
		}
		if (p != null) {
			return idx;
		} else {
			throw new Error("Item not exist!");
		}
	}

	public void printAll() {
		Node p = head.next;
		while (p != null) {
			System.out.printf("%s ", p.val);
			p = p.next;
		}
		System.out.println();
	}

	public static void main(String[] args) {
		System.out.println("Linked List:");
		Linked_List<Integer> list = new Linked_List<Integer>();
		for (int i = 0; i < 10; i ++) list.append(i);
		list.printAll();
		list.insert(2, 10);
		list.printAll();
		list.del(3);
		list.printAll();
		System.out.println(list.getValue(2));
		System.out.println(list.getPos(10));
	}
}