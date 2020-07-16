package com.atguigu.bean;

public class MlbackCouponDescTitle {
    private Integer coupondesctieleId;

    private String coupondesctieleName;

    private String coupondesctieleTieledetail;

    private Integer coupondesctieleWapstatus;

    private String coupondesctieleWapimgurl;

    private Integer coupondesctielePcstatus;

    private String coupondesctielePcimgurl;

    private String coupondesctieleCreatetime;

    private String coupondesctieleMotifytime;

    public Integer getCoupondesctieleId() {
        return coupondesctieleId;
    }

    public void setCoupondesctieleId(Integer coupondesctieleId) {
        this.coupondesctieleId = coupondesctieleId;
    }

    public String getCoupondesctieleName() {
        return coupondesctieleName;
    }

    public void setCoupondesctieleName(String coupondesctieleName) {
        this.coupondesctieleName = coupondesctieleName == null ? null : coupondesctieleName.trim();
    }

    public String getCoupondesctieleTieledetail() {
        return coupondesctieleTieledetail;
    }

    public void setCoupondesctieleTieledetail(String coupondesctieleTieledetail) {
        this.coupondesctieleTieledetail = coupondesctieleTieledetail == null ? null : coupondesctieleTieledetail.trim();
    }

    public Integer getCoupondesctieleWapstatus() {
        return coupondesctieleWapstatus;
    }

    public void setCoupondesctieleWapstatus(Integer coupondesctieleWapstatus) {
        this.coupondesctieleWapstatus = coupondesctieleWapstatus;
    }

    public String getCoupondesctieleWapimgurl() {
        return coupondesctieleWapimgurl;
    }

    public void setCoupondesctieleWapimgurl(String coupondesctieleWapimgurl) {
        this.coupondesctieleWapimgurl = coupondesctieleWapimgurl == null ? null : coupondesctieleWapimgurl.trim();
    }

    public Integer getCoupondesctielePcstatus() {
        return coupondesctielePcstatus;
    }

    public void setCoupondesctielePcstatus(Integer coupondesctielePcstatus) {
        this.coupondesctielePcstatus = coupondesctielePcstatus;
    }

    public String getCoupondesctielePcimgurl() {
        return coupondesctielePcimgurl;
    }

    public void setCoupondesctielePcimgurl(String coupondesctielePcimgurl) {
        this.coupondesctielePcimgurl = coupondesctielePcimgurl == null ? null : coupondesctielePcimgurl.trim();
    }

    public String getCoupondesctieleCreatetime() {
        return coupondesctieleCreatetime;
    }

    public void setCoupondesctieleCreatetime(String coupondesctieleCreatetime) {
        this.coupondesctieleCreatetime = coupondesctieleCreatetime == null ? null : coupondesctieleCreatetime.trim();
    }

    public String getCoupondesctieleMotifytime() {
        return coupondesctieleMotifytime;
    }

    public void setCoupondesctieleMotifytime(String coupondesctieleMotifytime) {
        this.coupondesctieleMotifytime = coupondesctieleMotifytime == null ? null : coupondesctieleMotifytime.trim();
    }

	public MlbackCouponDescTitle() {
		super();
	}

	public MlbackCouponDescTitle(Integer coupondesctieleId, String coupondesctieleName,
			String coupondesctieleTieledetail, Integer coupondesctieleWapstatus, String coupondesctieleWapimgurl,
			Integer coupondesctielePcstatus, String coupondesctielePcimgurl, String coupondesctieleCreatetime,
			String coupondesctieleMotifytime) {
		super();
		this.coupondesctieleId = coupondesctieleId;
		this.coupondesctieleName = coupondesctieleName;
		this.coupondesctieleTieledetail = coupondesctieleTieledetail;
		this.coupondesctieleWapstatus = coupondesctieleWapstatus;
		this.coupondesctieleWapimgurl = coupondesctieleWapimgurl;
		this.coupondesctielePcstatus = coupondesctielePcstatus;
		this.coupondesctielePcimgurl = coupondesctielePcimgurl;
		this.coupondesctieleCreatetime = coupondesctieleCreatetime;
		this.coupondesctieleMotifytime = coupondesctieleMotifytime;
	}

	@Override
	public String toString() {
		return "MlbackCouponDescTitle [coupondesctieleId=" + coupondesctieleId + ", coupondesctieleName="
				+ coupondesctieleName + ", coupondesctieleTieledetail=" + coupondesctieleTieledetail
				+ ", coupondesctieleWapstatus=" + coupondesctieleWapstatus + ", coupondesctieleWapimgurl="
				+ coupondesctieleWapimgurl + ", coupondesctielePcstatus=" + coupondesctielePcstatus
				+ ", coupondesctielePcimgurl=" + coupondesctielePcimgurl + ", coupondesctieleCreatetime="
				+ coupondesctieleCreatetime + ", coupondesctieleMotifytime=" + coupondesctieleMotifytime + "]";
	}
    
}