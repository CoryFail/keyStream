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

<cfparam name="FORM.username" type="string" default="" />
<cfparam name="FORM.password" type="string" default="" />
<cfparam name="FORM.remember_me" type="boolean" default="false" />

<cfif ((FORM.username EQ SESSION.adminUser) AND (hash(FORM.password) EQ SESSION.adminPassword))>
	
	<cfset SESSION.User.ID = 1 />
	<cfset strRememberMe = ( CreateUUID() & ":" & SESSION.User.ID & ":" & CreateUUID() ) />
	<cfset strRememberMe = Encrypt( strRememberMe, APPLICATION.EncryptionKey, "cfmx_compat", "hex" ) />

	<cfcookie name="RememberMe" value="#strRememberMe#" expires="never" />

	<cflocation	url="index.cfm"	addtoken="false" />

</cfif>

<cfinclude template="includes/header.cfm" />
<cfoutput>
	<div id="wrapper">
		<div class="content-wrapper clear">
			<div class="section-title">
				<h1 class="title">Admin <span>manage your media server</span></h1>
			</div>
			<div class="one">
				<form action="#CGI.script_name#" method="post">
					<label>
						Username:
						<input type="text" name="username" size="20" />
					</label>
					<br />
					<br />
					<label>
						Password:
						<input type="password" name="password" size="20" />
					</label>
					<br />
					<br />
					<input type="submit" value="Login" />
				</form>
			</div>
		</div>
	</div>
</cfoutput>