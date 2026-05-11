
/* 
  You can use logical to combine boolean expressions
  The following code examples use boolean x = true; and boolean y = false
 */

public class LogicalOperators {

    public static void main(String[] args) {
        
        // Static variables
        // Primitive data type
        // Declared and initialized

        int a = 10;
        int b = 5;
        int c = 15;

        if (a > b && b < c) {
            System.out.println("AND logical operator '&&'");
        } else if (a > b || b > c) {
            System.out.println("OR logical operator '||'");
        } else if (!(a > b)) {
            System.out.println("NOT logical operator ''!()");
        }

    }
}
