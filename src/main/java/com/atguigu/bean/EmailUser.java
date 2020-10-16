package com.atguigu.bean;

public class EmailUser {
    private Integer useremailId;

    private String useremailEmail;

    public Integer getUseremailId() {
        return useremailId;
    }

    public void setUseremailId(Integer useremailId) {
        this.useremailId = useremailId;
    }

    public String getUseremailEmail() {
        return useremailEmail;
    }

    public void setUseremailEmail(String useremailEmail) {
        this.useremailEmail = useremailEmail == null ? null : useremailEmail.trim();
    }
}