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

<cfcomponent>
	<cffunction name="GET">
		<cffile action="read" file="#application.rootDirectory#data/settings.json" variable="settingsJSON" />
		<cfreturn DeserializeJSON(settingsJSON) />
	</cffunction>
	
	<cffunction name="POST" hint="Runs on very first start up to create default settings.">
		<!--- creates directories --->
		<cfdirectory action="create" directory="#APPLICATION.rootDirectory#data/" mode="666" />
		<cfdirectory action="create" directory="#APPLICATION.rootDirectory#data/videos/" mode="666" />
        <cfdirectory action="create" directory="#APPLICATION.rootDirectory#uploads/" mode="666" />
		
		<!--- creates the default categories --->
		<cfset currentCategories = '{"Movies":"Action & Adventure,Children & Family,Classics,Comedies,Documentaries,Dramas,Foreign,Horror,Independent,Musicals,Romance,Sci-Fi & Fantasy,Thrillers","TV Shows":"Action & Adventure,Children & Family,Classics,Comedies,Documentaries,Dramas,Foreign,Horror,Independent,Musicals,Romance,Sci-Fi & Fantasy,Thrillers"}' />
		<cffile action="write" file="#application.rootDirectory#data/categories.json" output="#currentCategories#" mode="666" />
		
		<!--- create settings file --->
		<cfset var newPassword = hash("password") />
		<cfoutput>
			<cfset var settingsValues =	[
				   {
					   defaultRatingLimit = "PG13",
					   adminUser = "admin",
					   adminPassword = newPassword
				   }
			] />
		</cfoutput>
		<cffile action="write" file="#application.rootDirectory#data/settings.json" output="#serializeJSON(settingsValues)#" mode="666" />
		<cfset SESSION.defaultRatingLimit = "PG13" />
		<cfset SESSION.adminPassword = newPassword />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="PUT">
		<cfargument name="newPassword" />
		<cfargument name="ratings" />
		<cfif trim(ARGUMENTS.newPassword) GT "">
			<cfset var newPassword = hash(ARGUMENTS.newPassword) />
		<cfelse>
			<cfset var newPassword = SESSION.adminPassword />
		</cfif>
		<cfoutput>
			<cfset var settingsValues =	[
				   {
					   defaultRatingLimit = ARGUMENTS.ratings,
					   adminUser = "admin",
					   adminPassword = newPassword
				   }
			] />
		</cfoutput>

		<cffile action="write" file="#application.rootDirectory#data/settings.json" output="#serializeJSON(settingsValues)#" mode="666" />
		<cfset SESSION.defaultRatingLimit = ARGUMENTS.ratings />
		<cfset SESSION.adminPassword = newPassword />
		<cfreturn true />
	</cffunction>
		
</cfcomponent>