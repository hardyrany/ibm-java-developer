package com.example.library;

// Class
public class Book {
    // Attributes
    private String author;
    private String title;

    // Constructors
    public Book(String title, String author) {
        this.title = title;
        this.author = author;

    }

    // Method -> rewrite method
    @Override
    public String toString() {
        return title + ", " + author;
    }

}
