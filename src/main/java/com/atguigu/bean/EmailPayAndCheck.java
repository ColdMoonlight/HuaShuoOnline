package com.atguigu.bean;

public class EmailPayAndCheck {
    private Integer payandcheckId;

    private String payandcheckEmail;

    public Integer getPayandcheckId() {
        return payandcheckId;
    }

    public void setPayandcheckId(Integer payandcheckId) {
        this.payandcheckId = payandcheckId;
    }

    public String getPayandcheckEmail() {
        return payandcheckEmail;
    }

    public void setPayandcheckEmail(String payandcheckEmail) {
        this.payandcheckEmail = payandcheckEmail == null ? null : payandcheckEmail.trim();
    }
}