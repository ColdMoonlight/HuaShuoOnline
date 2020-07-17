package com.atguigu.bean;

import java.math.BigDecimal;

public class MlfrontPayInfo {
	
    private Integer payinfoId;

    private Integer payinfoUid;

    private String payinfoIp;

    private Integer payinfoOid;

    private String payinfoPlatform;

    private String payinfoPlatformserialcode;

    private BigDecimal payinfoMoney;

    private Integer payinfoStatus;

    private String payinfoReason;

    private String payinfoCreatetime;

    private String payinfoMotifytime;

    private String payinfoPlatenum;//平台交易号

    private String payinfoUname;//客户名

    private String payinfoUemail;//客户邮箱

    private String payinfoTransidnum;//paypal交易ID

    private String payinfoTransStatus;//paypal交易status

    private String payinfoEcpphsnum;//Ecpp单号

    private String payinfoSendnum;//物流单号

    public Integer getPayinfoId() {
        return payinfoId;
    }

    public void setPayinfoId(Integer payinfoId) {
        this.payinfoId = payinfoId;
    }

    public Integer getPayinfoUid() {
        return payinfoUid;
    }

    public void setPayinfoUid(Integer payinfoUid) {
        this.payinfoUid = payinfoUid;
    }

    public String getPayinfoIp() {
        return payinfoIp;
    }

    public void setPayinfoIp(String payinfoIp) {
        this.payinfoIp = payinfoIp == null ? null : payinfoIp.trim();
    }

    public Integer getPayinfoOid() {
        return payinfoOid;
    }

    public void setPayinfoOid(Integer payinfoOid) {
        this.payinfoOid = payinfoOid;
    }

    public String getPayinfoPlatform() {
        return payinfoPlatform;
    }

    public void setPayinfoPlatform(String payinfoPlatform) {
        this.payinfoPlatform = payinfoPlatform == null ? null : payinfoPlatform.trim();
    }

    public String getPayinfoPlatformserialcode() {
        return payinfoPlatformserialcode;
    }

    public void setPayinfoPlatformserialcode(String payinfoPlatformserialcode) {
        this.payinfoPlatformserialcode = payinfoPlatformserialcode == null ? null : payinfoPlatformserialcode.trim();
    }

    public BigDecimal getPayinfoMoney() {
        return payinfoMoney;
    }

    public void setPayinfoMoney(BigDecimal payinfoMoney) {
        this.payinfoMoney = payinfoMoney;
    }

    public Integer getPayinfoStatus() {
        return payinfoStatus;
    }

    public void setPayinfoStatus(Integer payinfoStatus) {
        this.payinfoStatus = payinfoStatus;
    }

    public String getPayinfoReason() {
        return payinfoReason;
    }

    public void setPayinfoReason(String payinfoReason) {
        this.payinfoReason = payinfoReason == null ? null : payinfoReason.trim();
    }

    public String getPayinfoCreatetime() {
        return payinfoCreatetime;
    }

    public void setPayinfoCreatetime(String payinfoCreatetime) {
        this.payinfoCreatetime = payinfoCreatetime == null ? null : payinfoCreatetime.trim();
    }

    public String getPayinfoMotifytime() {
        return payinfoMotifytime;
    }

    public void setPayinfoMotifytime(String payinfoMotifytime) {
        this.payinfoMotifytime = payinfoMotifytime == null ? null : payinfoMotifytime.trim();
    }

    public String getPayinfoPlatenum() {
        return payinfoPlatenum;
    }

    public void setPayinfoPlatenum(String payinfoPlatenum) {
        this.payinfoPlatenum = payinfoPlatenum == null ? null : payinfoPlatenum.trim();
    }

    public String getPayinfoUname() {
        return payinfoUname;
    }

    public void setPayinfoUname(String payinfoUname) {
        this.payinfoUname = payinfoUname == null ? null : payinfoUname.trim();
    }

    public String getPayinfoUemail() {
        return payinfoUemail;
    }

    public void setPayinfoUemail(String payinfoUemail) {
        this.payinfoUemail = payinfoUemail == null ? null : payinfoUemail.trim();
    }

    public String getPayinfoTransidnum() {
        return payinfoTransidnum;
    }

    public void setPayinfoTransidnum(String payinfoTransidnum) {
        this.payinfoTransidnum = payinfoTransidnum == null ? null : payinfoTransidnum.trim();
    }

    public String getPayinfoTransStatus() {
        return payinfoTransStatus;
    }

    public void setPayinfoTransStatus(String payinfoTransStatus) {
        this.payinfoTransStatus = payinfoTransStatus == null ? null : payinfoTransStatus.trim();
    }

    public String getPayinfoEcpphsnum() {
        return payinfoEcpphsnum;
    }

    public void setPayinfoEcpphsnum(String payinfoEcpphsnum) {
        this.payinfoEcpphsnum = payinfoEcpphsnum == null ? null : payinfoEcpphsnum.trim();
    }

    public String getPayinfoSendnum() {
        return payinfoSendnum;
    }

    public void setPayinfoSendnum(String payinfoSendnum) {
        this.payinfoSendnum = payinfoSendnum == null ? null : payinfoSendnum.trim();
    }

	public MlfrontPayInfo() {
		super();
	}

	public MlfrontPayInfo(Integer payinfoId, Integer payinfoUid, String payinfoIp, Integer payinfoOid,
			String payinfoPlatform, String payinfoPlatformserialcode, BigDecimal payinfoMoney, Integer payinfoStatus,
			String payinfoReason, String payinfoCreatetime, String payinfoMotifytime, String payinfoPlatenum,
			String payinfoUname, String payinfoUemail, String payinfoTransidnum, String payinfoTransStatus,
			String payinfoEcpphsnum, String payinfoSendnum) {
		super();
		this.payinfoId = payinfoId;
		this.payinfoUid = payinfoUid;
		this.payinfoIp = payinfoIp;
		this.payinfoOid = payinfoOid;
		this.payinfoPlatform = payinfoPlatform;
		this.payinfoPlatformserialcode = payinfoPlatformserialcode;
		this.payinfoMoney = payinfoMoney;
		this.payinfoStatus = payinfoStatus;
		this.payinfoReason = payinfoReason;
		this.payinfoCreatetime = payinfoCreatetime;
		this.payinfoMotifytime = payinfoMotifytime;
		this.payinfoPlatenum = payinfoPlatenum;
		this.payinfoUname = payinfoUname;
		this.payinfoUemail = payinfoUemail;
		this.payinfoTransidnum = payinfoTransidnum;
		this.payinfoTransStatus = payinfoTransStatus;
		this.payinfoEcpphsnum = payinfoEcpphsnum;
		this.payinfoSendnum = payinfoSendnum;
	}

	@Override
	public String toString() {
		return "MlfrontPayInfo [payinfoId=" + payinfoId + ", payinfoUid=" + payinfoUid + ", payinfoIp=" + payinfoIp
				+ ", payinfoOid=" + payinfoOid + ", payinfoPlatform=" + payinfoPlatform + ", payinfoPlatformserialcode="
				+ payinfoPlatformserialcode + ", payinfoMoney=" + payinfoMoney + ", payinfoStatus=" + payinfoStatus
				+ ", payinfoReason=" + payinfoReason + ", payinfoCreatetime=" + payinfoCreatetime
				+ ", payinfoMotifytime=" + payinfoMotifytime + ", payinfoPlatenum=" + payinfoPlatenum
				+ ", payinfoUname=" + payinfoUname + ", payinfoUemail=" + payinfoUemail + ", payinfoTransidnum="
				+ payinfoTransidnum + ", payinfoTransStatus=" + payinfoTransStatus + ", payinfoEcpphsnum="
				+ payinfoEcpphsnum + ", payinfoSendnum=" + payinfoSendnum + "]";
	}
    
}