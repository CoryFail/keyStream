<cfoutput>
    <cfif session.user.bAdmin EQ 0>
        <cflocation url="../login.cfm" addtoken="false" />
    </cfif>
	<!DOCTYPE html>
	<html>
	<head>
		<title>keyStream</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="../assets/css/global.css" />
		<link type="text/css" rel="stylesheet" href="../assets/css/color-button.css" />
		<!-- js Boots_from -->
		<script src="../assets/js/jquery.js"></script>
		<script src="../assets/js/jquery.validate.min.js"></script>
		<script src="../assets/js/jquery-ui.js"></script>
	    <script src="../assets/js/bootstrap.min.js"></script>
	    <script src="../assets/js/custom.js"></script>
		<!-- end Boots_from -->
	</head>

	<body data-spy="scroll" data-target=".subnav" data-offset="50" data-twttr-rendered="true">

	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="##">
					<span>key</span><span class="cl-blue">Stream</span>
				</a>
				<div class="nav-collapse">
					<ul class="nav pull-right">
	              		<li><a href="../index.cfm">Home</a></li>
	              		<li class="divider-vertical"></li>

	              		
	            		<li class="dropdown">
	            			<a class="dropdown-toggle" href="##" data-toggle="dropdown">
		            			hi #session.user.username#!
		            			<b class="caret"></b>
	            			</a>
	            			<ul class="dropdown-menu">
								<li>
									<a href="profile.html">
										<i class="icon-user"></i>
										Account Setting  </a>
								</li>
								<cfif session.user.bAdmin EQ 1>
									<li>
										<a href="/admin">
											<i class="icon-lock"></i> Admin Dashboard
                                        </a>
									</li>
								</cfif>
								<li class="divider"></li>
								<li>
									<a href="logout.cfm"><i class="icon-off"></i> Logout</a>
								</li>
							</ul>
	            		</li>
	            	</ul>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
<!-- end navbar -->