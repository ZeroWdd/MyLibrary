package com.wdd.library.service.impl;

import com.wdd.library.dao.ReaderMapper;
import com.wdd.library.pojo.Reader;
import com.wdd.library.service.ReaderService;
import com.wdd.library.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ReaderServiceImpl implements ReaderService {

    @Autowired
    private ReaderMapper readerMapper;

    @Override
    public int checkReader(Integer reader_id) {
        return readerMapper.checkReader(reader_id);
    }

    @Override
    public void addReader(Reader reader) {
        readerMapper.addReader(reader);
    }

    @Override
    public Reader select(Reader rd) {
        return readerMapper.select(rd);
    }

    @Override
    public PageBean<Reader> listReader(Map<String, Object> paramMap) {
        PageBean<Reader> pageBean = new PageBean<Reader>((Integer) paramMap.get("pageno"),(Integer) paramMap.get("pagesize"));

        Integer startIndex = pageBean.getStartIndex();
        paramMap.put("startIndex",startIndex);
        List<Reader> datas = readerMapper.queryList(paramMap);
        pageBean.setDatas(datas);

        Integer totalsize = readerMapper.queryCount(paramMap);
        pageBean.setTotalsize(totalsize);
        return pageBean;
    }

    @Override
    public Reader selectById(Integer id) {
        return readerMapper.selectById(id);
    }

    @Override
    public void updateReader(Reader reader) {
        readerMapper.updateReader(reader);
    }

    @Override
    public void delReader(Integer id) {
        readerMapper.delReader(id);
    }

    @Override
    public void alterpwd(Reader reader) {
        readerMapper.alterpwd(reader);
    }

}
