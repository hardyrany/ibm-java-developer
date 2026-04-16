package com.example.library;

public class Main {
    public static void main(String[] args) {

        Library library = new Library(); // Create an instance of Library

        // Add books to the library
        library.addBook(new Book("1984", "George Orwell"));
        library.addBook(new Book("To kill a Mockingbird", "Happer Lee"));

        // Display all books
        library.displayBooks();
    }
}
