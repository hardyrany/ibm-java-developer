public class PrintStrAsCharArr {
    public static void main(String[] args) {

        // Create and initialize as string
        String myStr = "The quick brown fox jumped over the lazy dog";

        // Convert the string to a char array using the toCharArray() method
        char[] chrArr = myStr.toCharArray();

        /*
         * 'for' loop iteration over array
         * Print each element od the array using the 'for' loop
         * 
         */
        for (int i = 0; i < chrArr.length; i++) {
            System.out.println(chrArr[i]);
        }

    }
}
