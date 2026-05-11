public class ArrayAccess {
    public static void main(String[] args) {

        // Arrays -> declared and initialize
        int[] years = { 2020, 2021, 2022, 2023, 2024, 2025 };
        years[1] = 2021;
        years[3] = 2023;

        // Accessing array
        System.out.println(years[0]);
        System.out.println(years[1]);
        System.out.println(years[2]);
        System.out.println(years[3]);
        System.out.println(years[4]);
        System.out.println(years[5]);

        System.out.println("====");

        // Arrays -> initialize and create
        int[] years1 = new int[6];
        years1[1] = 2021;
        years1[3] = 2023;

        // Accessing array
        System.out.println(years1[0]);
        System.out.println(years1[1]);
        System.out.println(years1[2]);
        System.out.println(years1[3]);
        System.out.println(years1[4]);
        System.out.println(years1[5]);

        System.out.println("====");

        // Using 'for' loops to traverse through an array
        int[] years2 = new int[6];
        years2[0] = 2020;
        years2[1] = 2021;
        years2[2] = 2022;
        years2[3] = 2023;
        years2[4] = 2024;
        years2[5] = 2025;
        int count_years = years2.length;
        System.out.println("The length of the array is " + count_years);
        System.out.println("============================");

        for (int i = 0; i < years2.length; i++) {
            System.out.println(years2[i]);
        }

        // Using 'for' loops to traverse through the command line arguments
        int num_args = s.length;
        System.out.println("the length of array is " + num_args);
        for (int i = 0; i < num_args; i++) {
            System.out.println(s[i]);
        }

    }
}
