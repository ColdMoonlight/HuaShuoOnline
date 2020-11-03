package com.atguigu.bean;

public class MlbackSearch {
    private Integer searchId;

    private String searchContent;

    private String searchCreatetime;

    private String searchMotifytime;

    public Integer getSearchId() {
        return searchId;
    }

    public void setSearchId(Integer searchId) {
        this.searchId = searchId;
    }

    public String getSearchContent() {
        return searchContent;
    }

    public void setSearchContent(String searchContent) {
        this.searchContent = searchContent == null ? null : searchContent.trim();
    }

    public String getSearchCreatetime() {
        return searchCreatetime;
    }

    public void setSearchCreatetime(String searchCreatetime) {
        this.searchCreatetime = searchCreatetime == null ? null : searchCreatetime.trim();
    }

    public String getSearchMotifytime() {
        return searchMotifytime;
    }

    public void setSearchMotifytime(String searchMotifytime) {
        this.searchMotifytime = searchMotifytime == null ? null : searchMotifytime.trim();
    }
}