package com.wdd.library.service;

import com.wdd.library.pojo.Book;
import com.wdd.library.pojo.Category;
import com.wdd.library.util.PageBean;

import java.util.List;
import java.util.Map;

public interface BookService {

    PageBean<Book> queryBookPage(Map<String, Object> paramMap);

    List<Category> listCategory();

    void addBook(Book book);

    Book selectById(int book_id);

    void updateBook(Book book);

    void delBook(int book_id);
}
