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
				</svg>
				<span>Profile</span>
			</a>
			<a class="dropdown-item">
				<svg class="c-icon">
					<use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-settings"></use>
				</svg>
				<span>Settings</span>
			</a>
			<a class="dropdown-item">
				<svg class="c-icon">
					<use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-lock-locked"></use>
				</svg>
				<span>Lock Account</span>
			</a>
			<a class="dropdown-item">
				<svg class="c-icon">
					<use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-account-logout"></use>
				</svg>
				<span>Logout</span>
			</a>
		</div>
    </div>
</div>