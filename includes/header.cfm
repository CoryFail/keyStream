<!---
This file is part of keyStream.

keyStream is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

keyStream is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with keyStream.  If not, see <http://www.gnu.org/licenses/>.
--->
<cfparam name="URL.c" default="" />
<cfset var categories = createobject("component","func.categories") />
<cfoutput>
	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
			<meta name="viewport" content="initial-scale=1, maximum-scale=1" />
			<meta name="viewport" content="width=device-width" />
			<title>keyStream - The open source personal media server.</title>

			<link rel="stylesheet" type="text/css" href="assets/css/style.css" media="screen" />
			<link rel="stylesheet" type="text/css" href="assets/css/blog.css" media="screen" />
			<link rel="stylesheet" type="text/css" href="assets/css/socialize-bookmarks.css" media="screen" />
			<link rel="stylesheet" type="text/css" href="assets/css/oswald.css" />
			<link rel="stylesheet" type="text/css" href="assets/css/video-js.css" />

			<script type="text/javascript" src="assets/javascript/jquery.min.js"></script>
			<script type="text/javascript" src="assets/javascript/custom.js"></script>
			<script type="text/javascript" src="assets/javascript/video.js"></script>
			<script type="text/javascript" src="assets/javascript/header.js"></script>
			<script type="text/javascript" src="assets/javascript/twitter.js"></script>

			<!-- PrettyPhoto --> 
			<link rel="stylesheet" href="assets/css/prettyPhoto.css" type="text/css" media="screen" />
			<script type="text/javascript" src="assets/javascript/prettyPhoto.js"></script>	

			<!-- Photostream Javascript --> 
			<script type="text/javascript" src="assets/javascript/bra.photostream.js"></script>

			<!-- Flexslider JavaScript Files -->	
			<script type="text/javascript" src="assets/javascript/jquery.flexslider.js"></script>
			<link rel="stylesheet" href="assets/css/flexslider.css" type="text/css" media="screen" />	

			<!-- Masonry Javascript File --> 
			<script type="text/javascript" src="assets/javascript/jquery.isotope.min.js"></script>	
			
			<script>
		   		videojs.options.flash.swf = "assets/swf/video-js.swf";
		  	</script>
			<style>
				.* {max-width: 100%} /* the usual RWD shebang */

				.video-js {
				    width: auto !important; /* override the plugin's inline dims to let vids scale fluidly */
				    height: auto !important;
				}
				
				.video-js video {position: relative !important;}
			</style>
		</head>
		<body id="top">
			<div id="header-wrapper">
				<div class="header clear">
					<div id="logo">	
						<a href="index.cfm"><img src="assets/images/logo.png" alt="" /></a>		
					</div>
					<div id="primary-menu">
						<ul class="menu">
							<li><a href="index.cfm" <cfif URL.c EQ "">class="current"</cfif>>Home#CGI.PATH_INFO#</a></li>
							<!-- grab from category array -->
							<cfloop collection="#categories.get()#"  item="category">
								<li><a href="library.cfm?c=#category#" <cfif URL.c EQ category>class="current"</cfif>>#replace(category, "_", " ")#</a>		
									<ul>
										<cfloop list="#ListSort(categories.get()[category], "Text")#" index="genre">
											<li><a href="library.cfm?c=#category#&g=#urlencodedformat(genre)#">#genre#</a></li>
										</cfloop>
									</ul>
								</li>
							</cfloop>
							<cfif SESSION.user.id EQ 1>
								<li><a href="admin/index.cfm">Dashboard</a></li>
							</cfif>
						</ul>
					</div>
				</div>
			</div>
</cfoutput>