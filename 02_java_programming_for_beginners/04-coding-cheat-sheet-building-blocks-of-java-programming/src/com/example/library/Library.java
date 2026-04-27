package com.example.library;

import java.util.ArrayList;
import java.util.List;

// Class
public class Library {

    // Private attributes to hold books
    private List<Book> books;

    // Initialize the list in the constructor
    public Library() {
        books = new ArrayList<>();
    }

    // Method to add a book to the library
    public void addBook(Book book) {
        books.add(book);
    }

    // Method to display book
    public void displayBooks() {
        for (Book book : books) {
            System.out.println(book);
        }
    }
}
