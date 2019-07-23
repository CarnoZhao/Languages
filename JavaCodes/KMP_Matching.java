public class KMP_Matching {
	public KMP_Matching() {};

	public int[] getNArray(String p) {
		int j, k;
		int len =  p.length();
		assert(len > 0);
		int[] n = new int[len];
		n[0] = -1;
		j = 0; k = -1;
		while (j < len - 1) {
			while (k >= 0 && p.charAt(k) != p.charAt(j)) {
				k = n[k];
			}
			j ++; k ++; n[j] = k;
		}
		for (int i = 0; i < len; i ++) System.out.print(n[i] + " ");
		System.out.println();
		return n;
	}

	public boolean matchStrings(String t, String p, int[] n, int start) {

		return true;
	}

	public static void main(String[] args) {
		System.out.println("KMP Matching:");
		KMP_Matching kmp = new KMP_Matching();
		int[] n = kmp.getNArray("abcaababc");
	}
}