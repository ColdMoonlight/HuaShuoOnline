<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<div class="c-sidebar" id="sidebar-menu">
	<ul class="c-sidebar-nav">
		<li class="c-sidebar-nav-item">
			<a class="c-sidebar-nav-link" href="${APP_PATH}/BackHome/BackHomePage">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-speedometer"></use>
				</svg>
				<span class="c-text">Dashboard</span>
			</a>
		</li>
		<li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
			<a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-cursor"></use>
				</svg>
				<span class="c-text">Products</span>
			</a>
			<ul class="c-child-menu">
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackCategory/toMlbackProductPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">All Products</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackCategory/toMlbackCategoryPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Collections</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackSuperCate/toMlbackSuperCatePage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">SuperCate</span>
					</a>
				</li>
			</ul>
		</li>
		<li class="c-sidebar-nav-item">
			<a class="c-sidebar-nav-link" href="widgets.html">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-calculator"></use>
				</svg>
				<span class="c-text">Widgets</span>
			</a>
		</li>
		<li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
			<a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-star"></use>
				</svg>
				<span class="c-text">Pages</span>
			</a>
			<ul class="c-child-menu">
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="login.html" target="_top">
						<svg class="c-sidebar-nav-icon">
							<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-account-logout"></use>
						</svg>
						<span class="c-text">Login</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="register.html" target="_top">
						<svg class="c-sidebar-nav-icon">
							<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-account-logout"></use>
						</svg>
						<span class="c-text">Register</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="404.html" target="_top">
						<svg class="c-sidebar-nav-icon">
							<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-bug"></use>
						</svg>
						<span class="c-text">Error 404</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="500.html" target="_top">
						<svg class="c-sidebar-nav-icon">
							<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-bug"></use>
						</svg>
						<span class="c-text">Error 500</span>
					</a>
				</li>
			</ul>
		</li>
	</ul>
</div>