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

<cfset var ratings = createobject("component","func.ratings") />
<cfset var settings = createobject("component","func.settings") />
<cfif isDefined('FORM.ratings')>
	<cfset settings.put(FORM.newPassword, FORM.ratings) />
	<cflocation addtoken="false" url="settings.cfm?r=true" />
</cfif>
<cfinclude template="includes/header.cfm" />
<cfoutput>
	<cfif isDefined('URL.r')>
		<script>
			alert("Your settings has been changed!");
		</script>		 
	</cfif>
    <div id="wrapper">
        <div class="content-wrapper clear">

            <div class="section-title">

				<h1 class="title">General Settings <span><a href="index.cfm"><< back to dashboard</a></span></h1>

            </div>

            <div class="one">
				<form name="formSettings" method="POST">
					<p><strong>Max Video Rating</strong></p>
					<p>
						This allows you to set the highest rating a non-admin user can watch.
					</p>
					<p>
						<select name="ratings">
							<cfloop list="#ratings.get()#" index="rating">
								<option value="#rating#"<cfif trim(SESSION.defaultRatingLimit) EQ trim(rating)> selected</cfif>>
									#rating#
								</option>
							</cfloop>
						</select> 
					</p>
					<p><strong>Change Password</strong></p>
					<p>Leave this field blank if you would like to keep your old password.</p>
					<p>
						<table>
							<tr>
								<td>New Password:&nbsp;&nbsp;</td>
								<td><input name="newPassword" type="password" /></td>
							</tr>
						</table>
					</p>
					<p>
						<input name="submit" type="submit" value="Save Changes" />
					</p>
				</form>
            </div>

        </div>
    </div>

</cfoutput>
<cfinclude template="includes/footer.cfm" />