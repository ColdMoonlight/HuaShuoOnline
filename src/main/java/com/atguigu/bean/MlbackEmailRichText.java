package com.atguigu.bean;

public class MlbackEmailRichText {
    private Integer emailrichtextId;

    private String emailrichtextSeoname;

    private String emailrichtextTitle;

    private String emailrichtextSendfrom;

    private String emailrichtextTemplate;

    private String emailrichtextKeynamestr;

    private String emailrichtextValuenamestr;

    public Integer getEmailrichtextId() {
        return emailrichtextId;
    }

    public void setEmailrichtextId(Integer emailrichtextId) {
        this.emailrichtextId = emailrichtextId;
    }

    public String getEmailrichtextSeoname() {
        return emailrichtextSeoname;
    }

    public void setEmailrichtextSeoname(String emailrichtextSeoname) {
        this.emailrichtextSeoname = emailrichtextSeoname == null ? null : emailrichtextSeoname.trim();
    }

    public String getEmailrichtextTitle() {
        return emailrichtextTitle;
    }

    public void setEmailrichtextTitle(String emailrichtextTitle) {
        this.emailrichtextTitle = emailrichtextTitle == null ? null : emailrichtextTitle.trim();
    }

    public String getEmailrichtextSendfrom() {
        return emailrichtextSendfrom;
    }

    public void setEmailrichtextSendfrom(String emailrichtextSendfrom) {
        this.emailrichtextSendfrom = emailrichtextSendfrom == null ? null : emailrichtextSendfrom.trim();
    }

    public String getEmailrichtextTemplate() {
        return emailrichtextTemplate;
    }

    public void setEmailrichtextTemplate(String emailrichtextTemplate) {
        this.emailrichtextTemplate = emailrichtextTemplate == null ? null : emailrichtextTemplate.trim();
    }

    public String getEmailrichtextKeynamestr() {
        return emailrichtextKeynamestr;
    }

    public void setEmailrichtextKeynamestr(String emailrichtextKeynamestr) {
        this.emailrichtextKeynamestr = emailrichtextKeynamestr == null ? null : emailrichtextKeynamestr.trim();
    }

    public String getEmailrichtextValuenamestr() {
        return emailrichtextValuenamestr;
    }

    public void setEmailrichtextValuenamestr(String emailrichtextValuenamestr) {
        this.emailrichtextValuenamestr = emailrichtextValuenamestr == null ? null : emailrichtextValuenamestr.trim();
    }

	public MlbackEmailRichText() {
		super();
	}

	public MlbackEmailRichText(Integer emailrichtextId, String emailrichtextSeoname, String emailrichtextTitle,
			String emailrichtextSendfrom, String emailrichtextTemplate, String emailrichtextKeynamestr,
			String emailrichtextValuenamestr) {
		super();
		this.emailrichtextId = emailrichtextId;
		this.emailrichtextSeoname = emailrichtextSeoname;
		this.emailrichtextTitle = emailrichtextTitle;
		this.emailrichtextSendfrom = emailrichtextSendfrom;
		this.emailrichtextTemplate = emailrichtextTemplate;
		this.emailrichtextKeynamestr = emailrichtextKeynamestr;
		this.emailrichtextValuenamestr = emailrichtextValuenamestr;
	}

	@Override
	public String toString() {
		return "MlbackEmailRichText [emailrichtextId=" + emailrichtextId + ", emailrichtextSeoname="
				+ emailrichtextSeoname + ", emailrichtextTitle=" + emailrichtextTitle + ", emailrichtextSendfrom="
				+ emailrichtextSendfrom + ", emailrichtextTemplate=" + emailrichtextTemplate
				+ ", emailrichtextKeynamestr=" + emailrichtextKeynamestr + ", emailrichtextValuenamestr="
				+ emailrichtextValuenamestr + "]";
	}
    
}