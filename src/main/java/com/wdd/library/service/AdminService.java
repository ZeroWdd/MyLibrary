package com.wdd.library.service;

import com.wdd.library.pojo.Admin;

public interface AdminService {
    Admin select(Admin ad);

    void alterpwd(Admin ad);
}
