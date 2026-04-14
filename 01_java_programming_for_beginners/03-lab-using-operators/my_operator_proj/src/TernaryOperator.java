public class TernaryOperator {
    public static void main(String[] args) {

        String hasArgs = args.length == 0 ? "No arguments passed" : args[0];
        System.out.println(hasArgs);

        String withArgs = args.length == 0 ? "something" : args[0];
        System.out.println(withArgs);
    }
}
