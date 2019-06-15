package com.wdd.library.pojo;

import java.io.Serializable;

public class Reader implements Serializable {
    private Integer id;
    private Integer reader_id;//登陆名
    private String name;//姓名
    private Integer password = 123;//默认密码
    private String sex;
    private String birthday;// 用于添加出生日期
    private String address;
    private String telephone;//电话
    private Integer card_state;//读者等级

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getReader_id() {
        return reader_id;
    }

    public void setReader_id(Integer reader_id) {
        this.reader_id = reader_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPassword() {
        return password;
    }

    public void setPassword(Integer password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Integer getCard_state() {
        return card_state;
    }

    public void setCard_state(Integer card_state) {
        this.card_state = card_state;
    }
}
