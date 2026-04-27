package com.example.library;

// Main class - entry point to execute java file
public class Main {
    public static void main(String[] args) {

        /*
         * Create a new object
         * Create an instance of Library
         */
        Library library = new Library();

        /*
         * Method addBook
         * Add books to the library
         */
        library.addBook(new Book("1984", "George Orwell"));
        library.addBook(new Book("To kill a Mockingbird", "Happer Lee"));

        /*
         * Method displayBooks
         * Display all books
         */
        library.displayBooks();
    }
}
