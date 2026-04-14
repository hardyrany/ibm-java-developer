public class TypesOfComments {
    public static void main(String[] args) {

        System.out.println("Hello, World!");
        System.out.println("// This is a single-line comment.");

        int number = 10; // This variable stores the number 10
        System.out.println("// This variable stores the number " + number);
        System.out.println(
                "/* This is a multi-line comment It can be used to explain a block of code or provide detailed information */");
        System.out.println("/* int sum = 0; This variable will hold the sum of numbers */");

        /**
         * This method calculates the square of number.
         * @param number The number to be squared
         * @return The square of the input number
         */

        System.out.println("""
                /**
                 * This method calculates the square of number.
                 * @param number The number to be squared
                 * @return The square of the input number
                 */
                """);

    }

    public int square(int number) {
        return number * number;
    }

}
