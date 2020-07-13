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
		<!-- product -->
		<li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
			<a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-cursor"></use>
				</svg>
				<span class="c-text">Products</span>
			</a>
			<ul class="c-child-menu">
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackSuperCate/toMlbackSuperCatePage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">SuperCate</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackCategory/toMlbackCategoryPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Collections</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackProduct/toMlbackProductPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">All Products</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlfrontReview/toMlfrontReviewPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Reviews</span>
					</a>
				</li>
			</ul>
		</li>
		<li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
			<a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-cursor"></use>
				</svg>
				<span class="c-text">Coupon</span>
			</a>
			<ul class="c-child-menu">
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackCoupon/toMlbackCouponPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Coupon list</span>
					</a>
				</li>
			</ul>
		</li>
		<li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
			<a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-cursor"></use>
				</svg>
				<span class="c-text">Marketing</span>
			</a>
			<ul class="c-child-menu">
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackCatalog/toMlbackCatalogPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">CateLog</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackSlides/toMlbackSlidePage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Carousel</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackActShowPro/toMlbackActShowProPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Activity Product</span>
					</a>
				</li>
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackShowArea/toMlbackShowAreaPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Display Area</span>
					</a>
				</li>				
				<li class="c-sidebar-nav-item">
					<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackVideoShowArea/toMlbackVideoShowAreaPage">
						<span class="c-sidebar-nav-icon"></span>
						<span class="c-text">Video Area</span>
					</a>
				</li>
			</ul>
		</li>
		<li class="c-sidebar-nav-item">
			<a class="c-sidebar-nav-link" href="${APP_PATH}/MlbackFootNav/toMlbackFootNavPage">
				<svg class="c-sidebar-nav-icon">
					<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-calculator"></use>
				</svg>
				<span class="c-text">Footer Nav</span>
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