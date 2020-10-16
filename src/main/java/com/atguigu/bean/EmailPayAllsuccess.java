package com.atguigu.bean;

public class EmailPayAllsuccess {
    private Integer payallsuccessId;

    private String payallsuccessEmail;

    public Integer getPayallsuccessId() {
        return payallsuccessId;
    }

    public void setPayallsuccessId(Integer payallsuccessId) {
        this.payallsuccessId = payallsuccessId;
    }

    public String getPayallsuccessEmail() {
        return payallsuccessEmail;
    }

    public void setPayallsuccessEmail(String payallsuccessEmail) {
        this.payallsuccessEmail = payallsuccessEmail == null ? null : payallsuccessEmail.trim();
    }
}