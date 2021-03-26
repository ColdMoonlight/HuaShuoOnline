package com.atguigu.bean;

public class MlbackBlog {
    private Integer blogId;

    private String blogSeoname;

    private String blogName;

    private String blogMetaTitle;

    private String blogMetaKeyword;

    private String blogMetaDesc;

    private String blogBannerimg;

    private String blogAuthorCreatetime;

    private Integer blogStatus;

    private String blogCreatetime;

    private String blogMotifytime;

    private String blogContentrichtext;

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public String getBlogSeoname() {
        return blogSeoname;
    }

    public void setBlogSeoname(String blogSeoname) {
        this.blogSeoname = blogSeoname == null ? null : blogSeoname.trim();
    }

    public String getBlogName() {
        return blogName;
    }

    public void setBlogName(String blogName) {
        this.blogName = blogName == null ? null : blogName.trim();
    }

    public String getBlogMetaTitle() {
        return blogMetaTitle;
    }

    public void setBlogMetaTitle(String blogMetaTitle) {
        this.blogMetaTitle = blogMetaTitle == null ? null : blogMetaTitle.trim();
    }

    public String getBlogMetaKeyword() {
        return blogMetaKeyword;
    }

    public void setBlogMetaKeyword(String blogMetaKeyword) {
        this.blogMetaKeyword = blogMetaKeyword == null ? null : blogMetaKeyword.trim();
    }

    public String getBlogMetaDesc() {
        return blogMetaDesc;
    }

    public void setBlogMetaDesc(String blogMetaDesc) {
        this.blogMetaDesc = blogMetaDesc == null ? null : blogMetaDesc.trim();
    }

    public String getBlogBannerimg() {
        return blogBannerimg;
    }

    public void setBlogBannerimg(String blogBannerimg) {
        this.blogBannerimg = blogBannerimg == null ? null : blogBannerimg.trim();
    }

    public String getBlogAuthorCreatetime() {
        return blogAuthorCreatetime;
    }

    public void setBlogAuthorCreatetime(String blogAuthorCreatetime) {
        this.blogAuthorCreatetime = blogAuthorCreatetime == null ? null : blogAuthorCreatetime.trim();
    }

    public Integer getBlogStatus() {
        return blogStatus;
    }

    public void setBlogStatus(Integer blogStatus) {
        this.blogStatus = blogStatus;
    }

    public String getBlogCreatetime() {
        return blogCreatetime;
    }

    public void setBlogCreatetime(String blogCreatetime) {
        this.blogCreatetime = blogCreatetime == null ? null : blogCreatetime.trim();
    }

    public String getBlogMotifytime() {
        return blogMotifytime;
    }

    public void setBlogMotifytime(String blogMotifytime) {
        this.blogMotifytime = blogMotifytime == null ? null : blogMotifytime.trim();
    }

    public String getBlogContentrichtext() {
        return blogContentrichtext;
    }

    public void setBlogContentrichtext(String blogContentrichtext) {
        this.blogContentrichtext = blogContentrichtext == null ? null : blogContentrichtext.trim();
    }
}