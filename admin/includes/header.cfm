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

<cfif SESSION.User.ID NEQ 1>
	<cflocation url="../login.cfm" addtoken="false" />
</cfif>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<meta name="viewport" content="initial-scale=1, maximum-scale=1" />
		<meta name="viewport" content="width=device-width" />
		<title>keyStream - The open source personal media server.</title>

		<link rel="stylesheet" type="text/css" href="../assets/css/style.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="../assets/css/blog.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="../assets/css/socialize-bookmarks.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="../assets/css/oswald.css" />
		<link rel="stylesheet" type="text/css" href="assets/css/demo.css"></link>

			
		<script type="text/javascript" src="../assets/javascript/jquery.min.js"></script>
		<script type="text/javascript" src="../assets/javascript/custom.js"></script>
		<script	type="text/javascript" src="assets/require/require.js" data-main="assets/main.js"></script>

		<!-- Masonry Javascript File --> 
		<script type="text/javascript" src="../assets/javascript/jquery.isotope.min.js"></script>	
	</head>
	<body>