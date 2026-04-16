package com.example.library;

public class Book {
    // Attributes
    String author;
    String title;

    // Constructors
    public Book(String title, String author) {
        this.title = title;
        this.author =  author;

    }

    // Method -> rewrite method
    @Override
    public String toString() {
        return title + ", " + author;
    }

}
