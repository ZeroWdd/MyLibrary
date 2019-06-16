package com.wdd.library.dao;

import com.wdd.library.pojo.Admin;

public interface AdminMapper {
    Admin select(Admin ad);

    void alterpwd(Admin ad);
}
