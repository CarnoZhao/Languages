public class Sequence_List<T> {
	private T[] aList;
	private int maxSize = 1;
	private int curLen;

	private void checkFull() {
		if (curLen >= maxSize) {
			maxSize *= 2;
			T[] newList = (T[]) new Object[maxSize];
			for (int i = 0; i < curLen; i ++) {
				newList[i] = aList[i];
			}
			aList = newList;
		}
	}

	private void checkHalf() {
		if (curLen <= maxSize / 2) {
			maxSize /= 2;
			T[] newList = (T[]) new Object[maxSize];
			for (int i = 0; i < curLen; i ++) {
				newList[i] = aList[i];
			}
			aList = newList;
		}
	}

	private void checkOut(int p, int threshold) {
		if (p > threshold) throw new Error("Index out of range!");
	}

	public Sequence_List() {
		aList = (T[]) new Object[maxSize];
		curLen = 0;
	}

	public void clear() {
		curLen = 0;
		maxSize = 1;
		aList = (T[]) new Object[maxSize];
	}

	public boolean isEmpty() {
		return curLen == 0;
	}

	public void append(T value) {
		checkFull();
		aList[curLen] = value;
		curLen ++;
	}

	public void insert(int p, T value) {
		checkFull();
		checkOut(p, curLen);
		for (int i = curLen; i >= p; i --) {
			aList[i] = aList[i - 1];
		}
		aList[p] = value;
		curLen ++;
	}

	public void del(int p) {
		checkHalf();
		checkOut(p, curLen - 1);
		for (int i = p; i < curLen - 1; i ++) {
			aList[i] = aList[i + 1];
		}
		curLen --;
	}

	public int getPos(T value) {
		int i;
		for (i = 0; i < curLen; i ++) {
			if (aList[i] == value) break;
		}
		if (i != curLen) {
			return i;
		} else {
			throw new Error("Item not exist!");
		}
	}

	public T getValue(int p) {
		checkOut(p, curLen - 1);
		return aList[p];
	}

	public void setValue(int p, T value) {
		checkOut(p, curLen - 1);
		aList[p] = value;
	}

	public void printAll() {
		for (int i = 0; i < curLen; i ++) {
			System.out.printf("%s ", aList[i]);
		}
		System.out.printf("| %s", maxSize);
		System.out.println();
	}

	public static void main(String[] args) {
		System.out.println("Sequence_List:");
		Sequence_List<Integer> list = new Sequence_List<Integer>();
		for (int i = 0; i < 10; i ++) {
			list.append(i);
		}
		list.printAll();
		list.insert(1, 10);
		list.printAll();
		for (int i = 0; i < 6; i ++) {
			list.del(i);
		}
		list.printAll();
		System.out.println(list.getValue(4));
		System.out.println(list.getPos(10));
		list.setValue(2, 100);
		list.printAll();
	}
}