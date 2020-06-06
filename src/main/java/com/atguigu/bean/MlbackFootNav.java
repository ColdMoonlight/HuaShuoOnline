package com.atguigu.bean;

public class MlbackFootNav {
	
    private Integer footnavId;

    private String footnavName;

    private Integer footnavHang;

    private Integer footnavLie;

    private String footnavCreatetime;

    private String footnavMotifytime;

    private Integer footnavIfincome;

    private Integer footnavIfshow;

    private String footnavDesc;

    public Integer getFootnavId() {
        return footnavId;
    }

    public void setFootnavId(Integer footnavId) {
        this.footnavId = footnavId;
    }

    public String getFootnavName() {
        return footnavName;
    }

    public void setFootnavName(String footnavName) {
        this.footnavName = footnavName == null ? null : footnavName.trim();
    }

    public Integer getFootnavHang() {
        return footnavHang;
    }

    public void setFootnavHang(Integer footnavHang) {
        this.footnavHang = footnavHang;
    }

    public Integer getFootnavLie() {
        return footnavLie;
    }

    public void setFootnavLie(Integer footnavLie) {
        this.footnavLie = footnavLie;
    }

    public String getFootnavCreatetime() {
        return footnavCreatetime;
    }

    public void setFootnavCreatetime(String footnavCreatetime) {
        this.footnavCreatetime = footnavCreatetime == null ? null : footnavCreatetime.trim();
    }

    public String getFootnavMotifytime() {
        return footnavMotifytime;
    }

    public void setFootnavMotifytime(String footnavMotifytime) {
        this.footnavMotifytime = footnavMotifytime == null ? null : footnavMotifytime.trim();
    }

    public Integer getFootnavIfincome() {
        return footnavIfincome;
    }

    public void setFootnavIfincome(Integer footnavIfincome) {
        this.footnavIfincome = footnavIfincome;
    }

    public Integer getFootnavIfshow() {
        return footnavIfshow;
    }

    public void setFootnavIfshow(Integer footnavIfshow) {
        this.footnavIfshow = footnavIfshow;
    }

    public String getFootnavDesc() {
        return footnavDesc;
    }

    public void setFootnavDesc(String footnavDesc) {
        this.footnavDesc = footnavDesc == null ? null : footnavDesc.trim();
    }

	public MlbackFootNav() {
		super();
	}

	public MlbackFootNav(Integer footnavId, String footnavName, Integer footnavHang, Integer footnavLie,
			String footnavCreatetime, String footnavMotifytime, Integer footnavIfincome, Integer footnavIfshow,
			String footnavDesc) {
		super();
		this.footnavId = footnavId;
		this.footnavName = footnavName;
		this.footnavHang = footnavHang;
		this.footnavLie = footnavLie;
		this.footnavCreatetime = footnavCreatetime;
		this.footnavMotifytime = footnavMotifytime;
		this.footnavIfincome = footnavIfincome;
		this.footnavIfshow = footnavIfshow;
		this.footnavDesc = footnavDesc;
	}

	@Override
	public String toString() {
		return "MlbackFootNav [footnavId=" + footnavId + ", footnavName=" + footnavName + ", footnavHang=" + footnavHang
				+ ", footnavLie=" + footnavLie + ", footnavCreatetime=" + footnavCreatetime + ", footnavMotifytime="
				+ footnavMotifytime + ", footnavIfincome=" + footnavIfincome + ", footnavIfshow=" + footnavIfshow
				+ ", footnavDesc=" + footnavDesc + "]";
	}
    
}