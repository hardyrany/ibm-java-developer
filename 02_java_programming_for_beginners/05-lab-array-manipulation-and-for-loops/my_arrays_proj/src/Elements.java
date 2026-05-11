public class Elements {
    public static void main(String[] args) {

        // Arrays -> Create/Declare and initialize array with 10 elements
        System.out.println("Array -> Element List: ");
        String[] elements = { "Fire", "Earth", "Water", "Ice", "Rock", "Sand", "Air", "Dragon", "Psycho", "Grass",
                "Fly" };

        // Print each element of the array without using the 'for' loop
        System.out.println(elements[0]);
        System.out.println(elements[1]);
        System.out.println(elements[2]);
        System.out.println(elements[3]);
        System.out.println(elements[4]);
        System.out.println(elements[5]);
        System.out.println(elements[6]);
        System.out.println(elements[7]);
        System.out.println(elements[8]);
        System.out.println(elements[9]);
        System.out.println(elements[10]);

        System.out.println("=======================");

        // Using a for loop to iterate through an array
        for (int i = 0; i < elements.length; i++) {
            System.out.println("Element Length List: " + i);
        }

        System.out.println("=======================");

        /*
         * Using a for each loop to iterate through an array
         * Print ech element of the array using the 'for' loop
         */
        for (String element : elements) {
            System.out.println(element);
        }
    }
}
