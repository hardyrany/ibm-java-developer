
/*
  You use rational operators to compare two values.
  These operator return a boolean result (true or false).
 */
public class RationalOperators {
    public static void main(String[] args) {

        /*
         * Static variables
         * Primitive data types
         * Declared and initialized
         */

        int a = 10;
        int b = 5;

        System.out.println("===============");
        System.out.println("First value: " + a);
        System.out.println("Secund value: " + b);
        System.out.println("===============");
        
        System.out.println("Rational Operators: " 
        + "\nEqual: ==" 
        + "\nNot Equal/Different: !=" 
        + "\nGreater Than: >" 
        + "\nLess Than: <" 
        + "\nGreater Than or Equal: >=" 
        + "\nLess Than or Equal: <=");
        System.out.println("=========================");

        System.out.println("Is a equal to b? : " + (a == b));
        System.out.println("Is a not equal to b? : " + (a != b) );
        System.out.println("Is a greater than b? : " + (a > b));
        System.out.println("Ia a less than b? : " + (a < b));
        System.out.println("Is a greater or equal to b? : " + (a >= b));
        System.out.println("Is a less than or equal to b? : " + (a <= b));
    }
}
