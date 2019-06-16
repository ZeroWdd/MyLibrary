package com.wdd.library.dao;


import com.wdd.library.pojo.Reader;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ReaderMapper {
    int checkReader(Integer reader_id);

    void addReader(Reader reader);

    Reader select(Reader rd);

    List<Reader> queryList(Map<String, Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    Reader selectById(Integer id);

    void updateReader(Reader reader);

    void delReader(Integer id);

    void alterpwd(Reader reader);
}
