<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute(" APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MEGALOOK ADMIN</title>
		<jsp:include page="common/backheader.jsp" flush="true"></jsp:include>
	</head>

	<body class="c-app">
		<jsp:include page="layout/backheader.jsp" flush="true"></jsp:include>
		<jsp:include page="layout/backsidebar.jsp" flush="true"></jsp:include>
		<div class="c-wrapper">
			<div class="c-body">
				<div class="c-main">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header">3d Switch</div>
								<div class="card-body">
									<label class="c-switch c-switch-3d c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked="" disabled=""><span
											class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-3d c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											disabled=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch default</div>
								<div class="card-body">
									<label class="c-switch c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch default - pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-pill
										c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch outline</div>
								<div class="card-body">
									<label class="c-switch c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch outline - pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-pill
										c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch opposite</div>
								<div class="card-body">
									<label class="c-switch c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch opposite - pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-pill
										c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
									<label class="c-switch c-switch-pill
										c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text - pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text outline</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text outline -
									pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text opposite</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with text opposite -
									pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="On" data-unchecked="Off"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon - pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon outline</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon outline -
									pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-outline-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon opposite</div>
								<div class="card-body">
									<label class="c-switch c-switch-label
										c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label
										c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Switch with icon opposite -
									pills</div>
								<div class="card-body">
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-primary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-secondary">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-success">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-warning">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-info">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
									<label class="c-switch c-switch-label c-switch-pill
										c-switch-opposite-danger">
										<input class="c-switch-input" type="checkbox"
											checked=""><span class="c-switch-slider"
											data-checked="✓" data-unchecked="✕"></span>
									</label>
								</div>
							</div>
						</div>
						<div class="c-form">
							<div class="form-group">
		                        <label class="col-form-label" for="tagsinput">Tagsinput</label>
		                        <div class="controls">
			                         <input class="form-control" id="tagsinput" type="text" />
		                        </div>
	                      	</div>
							<div class="form-group">
		                        <label class="col-form-label" for="summernote">Summernote</label>
		                        <div class="controls">
			                        <textarea class="form-control" id="summernote" size="16" type="text"></textarea>
		                        </div>
	                      	</div>
						</div>
						<!-- /.col-->
					</div>
				</div>
			</div>
			<jsp:include page="layout/backfooter.jsp" flush="true"></jsp:include>
		</div>

		<jsp:include page="common/backfooter.jsp" flush="true"></jsp:include>
		<script>
			// tagsinput
			$('#tagsinput').tagsinput({
				onTagExists: function(item, $tag) {
					toastr.error('Youve already used the option "'+ item + '"');
				}
			});
			$('.bootstrap-tagsinput input').on('focus', function(e) {
				$(this).parent().addClass('active')
			});
			$('.bootstrap-tagsinput input').on('blur', function(e) {
				$(this).parent().removeClass('active')
			});
			// rich text
			$('#summernote').summernote({
				height: 300,
		        toolbar: [
					['style', ['style', 'bold', 'italic', 'underline', 'clear']],
					['fontsize', ['fontsize']],
					['height', ['height']],
					['color', ['color']],
					['para', ['ul', 'ol', 'paragraph']],
					['table', ['table']],
					['insert', ['link', 'picture', 'video']],
					['view', ['codeview']]
		        ]
		   	});
		</script>
	</body>
</html>