package com.atguigu.bean;

public class EmailAddress {
    private Integer addressemailId;

    private String addressemailEmail;

    public Integer getAddressemailId() {
        return addressemailId;
    }

    public void setAddressemailId(Integer addressemailId) {
        this.addressemailId = addressemailId;
    }

    public String getAddressemailEmail() {
        return addressemailEmail;
    }

    public void setAddressemailEmail(String addressemailEmail) {
        this.addressemailEmail = addressemailEmail == null ? null : addressemailEmail.trim();
    }
}