package com;

public class Arrays {
    public static void main(String[] args) {

        // declaring an array
        String[] arrayNames = {};
        int[] arrayNumbers = {};

        // Initializing an array
        arrayNumbers = new int[5]; // X Wrong
        int[] arrayNumbers1 = new int[4]; // V right
        int[] arrayNumbers2 = {1, 2, 3, 4, 5};

        // Accessing an array
        System.out.println(arrayNumbers2[0] + "\n" + arrayNumbers2[4]);
        System.out.println("====================================");
        
        // Modifying array elements
        arrayNumbers2[2] = 10; // Changing the third element  to 10
        System.out.println(arrayNumbers2[2]);
        System.out.println("====================================");
        
        // Verify the array length
        System.out.println("The length of array is: " +arrayNumbers2.length);
        System.out.println("====================================");
        
        // Using a for loop to iterate through an array
        for (int i = 0; i < arrayNumbers2.length; i++) {
            System.out.println(arrayNumbers2[i]);
        }
        System.out.println("====================================");
        
        // Using a for each loop to iterate through an array
        for (int number : arrayNumbers2) {
            System.out.println(number);
        }
        System.out.println("====================================");

        // Declare and initialize a multidimensional array
        int[][] matrix = {{1, 2, 3,}, {4, 5, 6}, {7, 8, 9}};
        System.out.println(matrix[0][1]);
        System.out.println("====================================");

        // Iterating through a 2D Array
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.println(matrix[i][j]);
            }
            System.out.println(); // Move the next line after each now
        }
    
    }
}
