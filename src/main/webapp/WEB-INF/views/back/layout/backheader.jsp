<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<div class="c-header">
    <div class="c-header-nav">
      <div class="c-avatar" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
        <img class="c-avatar-img" src="assets/img/avatars/6.jpg" alt="user@email.com">
      </div>
      <div class="dropdown-menu">
        <a class="dropdown-item">
          <svg class="c-icon">
            <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-user"></use>
          </svg> Profile</a>
        <a class="dropdown-item">
          <svg class="c-icon">
            <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-settings"></use>
          </svg> Settings</a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item">
          <svg class="c-icon">
            <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-lock-locked"></use>
          </svg> Lock Account</a>
        <a class="dropdown-item">
          <svg class="c-icon">
            <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-account-logout"></use>
          </svg> Logout</a>
      </div>
    </div>
  </div>