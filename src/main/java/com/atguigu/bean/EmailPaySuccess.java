package com.atguigu.bean;

public class EmailPaySuccess {
    private Integer paysuccessId;

    private String paysuccessEmail;

    public Integer getPaysuccessId() {
        return paysuccessId;
    }

    public void setPaysuccessId(Integer paysuccessId) {
        this.paysuccessId = paysuccessId;
    }

    public String getPaysuccessEmail() {
        return paysuccessEmail;
    }

    public void setPaysuccessEmail(String paysuccessEmail) {
        this.paysuccessEmail = paysuccessEmail == null ? null : paysuccessEmail.trim();
    }

	public EmailPaySuccess() {
		super();
	}

	public EmailPaySuccess(Integer paysuccessId, String paysuccessEmail) {
		super();
		this.paysuccessId = paysuccessId;
		this.paysuccessEmail = paysuccessEmail;
	}

	@Override
	public String toString() {
		return "EmailPaySuccess [paysuccessId=" + paysuccessId + ", paysuccessEmail=" + paysuccessEmail + "]";
	}
    
}