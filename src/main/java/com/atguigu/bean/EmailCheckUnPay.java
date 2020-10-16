package com.atguigu.bean;

public class EmailCheckUnPay {
    private Integer checkunpayId;

    private String checkunpayEmail;

    public Integer getCheckunpayId() {
        return checkunpayId;
    }

    public void setCheckunpayId(Integer checkunpayId) {
        this.checkunpayId = checkunpayId;
    }

    public String getCheckunpayEmail() {
        return checkunpayEmail;
    }

    public void setCheckunpayEmail(String checkunpayEmail) {
        this.checkunpayEmail = checkunpayEmail == null ? null : checkunpayEmail.trim();
    }
}