<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

	<div class="c-sidebar" id="sidebar-menu">
      <ul class="c-sidebar-nav">
        <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="index.html">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-speedometer"></use>
            </svg><span class="c-text"> Dashboard</span></a></li>
        <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="colors.html">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-drop1"></use>
            </svg><span class="c-text"> Colors</span></a></li>
        <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="typography.html">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-pencil"></use>
            </svg><span class="c-text"> Typography</span></a></li>
        <li class="c-sidebar-nav-item c-sidebar-nav-dropdown"><a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-puzzle"></use>
            </svg><span class="c-text"> Base</span></a>
          <ul class="c-child-menu">
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/breadcrumb.html"><span class="c-sidebar-nav-icon"></span> <span class="c-text">Breadcrumb</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/cards.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Cards</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/carousel.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Carousel</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/collapse.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Collapse</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/forms.html"><span class="c-sidebar-nav-icon"></span><span class="c-text">Forms</span> </a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/jumbotron.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Jumbotron</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/list-group.html"><span class="c-sidebar-nav-icon"></span> <span class="c-text">List group</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/navs.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Navs</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/pagination.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Pagination</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/popovers.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Popovers</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/progress.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Progress</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/scrollspy.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Scrollspy</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/switches.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Switches</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/tables.html"><span class="c-sidebar-nav-icon"></span><span class="c-text">Tables</span> </a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/tabs.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Tabs</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="base/tooltips.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Tooltips</span></a></li>
          </ul>
        </li>
        <li class="c-sidebar-nav-item c-sidebar-nav-dropdown"><a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-cursor"></use>
            </svg><span class="c-text"> Buttons</span></a>
          <ul class="c-child-menu">
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="buttons/buttons.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Buttons</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="buttons/button-group.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Buttons Group</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="buttons/dropdowns.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Dropdowns</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="buttons/brand-buttons.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Brand Buttons</span></a></li>
          </ul>
        </li>
        <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="charts.html">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-chart-pie"></use>
            </svg> <span class="c-text">Charts</span></a></li>
        <li class="c-sidebar-nav-item c-sidebar-nav-dropdown"><a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-star"></use>
            </svg><span class="c-text"> Icons</span></a>
          <ul class="c-child-menu">
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="icons/coreui-icons-free.html"><span class="c-text"> CoreUI Icons</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="icons/coreui-icons-brand.html"><span class="c-text"> CoreUI Icons - Brand</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="icons/coreui-icons-flag.html"><span class="c-text"> CoreUI Icons - Flag</span></a></li>
          </ul>
        </li>
        <li class="c-sidebar-nav-item c-sidebar-nav-dropdown"><a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-bell"></use>
            </svg><span class="c-text"> Notifications</span></a>
          <ul class="c-child-menu">
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="notifications/alerts.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Alerts</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="notifications/badge.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Badge</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="notifications/modals.html"><span class="c-sidebar-nav-icon"></span><span class="c-text"> Modals</span></a></li>
          </ul>
        </li>
        <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="widgets.html">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-calculator"></use>
            </svg><span class="c-text"> Widgets</span></a></li>
        <li class="c-sidebar-nav-item c-sidebar-nav-dropdown"><a class="c-sidebar-nav-link c-sidebar-nav-dropdown-toggle">
            <svg class="c-sidebar-nav-icon">
              <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-star"></use>
            </svg> <span class="c-text">Pages</span></a>
          <ul class="c-child-menu">
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="login.html" target="_top">
                <svg class="c-sidebar-nav-icon">
                  <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-account-logout"></use>
                </svg> <span class="c-text">Login</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="register.html" target="_top">
                <svg class="c-sidebar-nav-icon">
                  <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-account-logout"></use>
                </svg> <span class="c-text">Register</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="404.html" target="_top">
                <svg class="c-sidebar-nav-icon">
                  <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-bug"></use>
                </svg> <span class="c-text">Error 404</span></a></li>
            <li class="c-sidebar-nav-item"><a class="c-sidebar-nav-link" href="500.html" target="_top">
                <svg class="c-sidebar-nav-icon">
                  <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-bug"></use>
                </svg> <span class="c-text">Error 500</span></a></li>
          </ul>
        </li>
      </ul>
    </div>