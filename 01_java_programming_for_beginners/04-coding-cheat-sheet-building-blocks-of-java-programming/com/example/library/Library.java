package com.example.library;

import java.awt.print.Book;
import java.util.ArrayList;
import java.util.List;

public class Library {

    private List<Book> books; // Private attributes to hold books
    
    public Library() {
        books = new ArrayList<>(); // Initialize the list in the constructor
    }

    public void addBook(Book book) {
        books.add(book); // Method to add a book to the library
    }

    public void displayBooks() {
        for (Book book : books) {
            System.out.println(book);
        }
    }
}
