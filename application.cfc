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

<cfcomponent output="false" hint="I define the application and root-level event handlers.">


	<cfset THIS.name="keyStream" />
	<cfset THIS.applicationTimeout = CreateTimeSpan( 0, 0, 5, 0 ) />
	<cfset THIS.sessionManagement = true />
	<cfset THIS.sessionTimeout = CreateTimeSpan( 0, 0, 0, 20 ) />
	<cfset THIS.setClientCookies = true />
	
	<cfset settings = createobject("component","func.settings") />
	
	<cfsetting showdebugoutput="false" requesttimeout="10" />


	<cffunction name="OnApplicationStart" access="public" returntype="boolean" output="false" hint="I run when the application boots up. If I return false, the application initialization will hault.">
		
		<cfset APPLICATION.rootDirectory = getDirectoryFromPath( getCurrentTemplatePath() ) />

		<cfset APPLICATION.uploadsDirectory = (APPLICATION.rootDirectory & "data/videos/")  />

		<cfset APPLICATION.encryptionKey="m0Vi3sR0x" />
		
		<cfif (NOT FileExists(APPLICATION.rootDirectory & "data/settings.json")) OR (NOT DirectoryExists(APPLICATION.rootDirectory & "data/"))>
			<cfset settings.POST() />
		</cfif>
		
		<cfreturn true />
	</cffunction>


	<cffunction name="OnSessionStart" access="public" returntype="void" output="false" hint="I run when a session boots up.">
		
		<cfset var LOCAL = { } />

		<cfset LOCAL.CFID = SESSION.CFID />
		<cfset LOCAL.CFTOKEN = SESSION.CFTOKEN />

		<cfset StructClear( SESSION ) />


		<cfset SESSION.CFID = LOCAL.CFID />
		<cfset SESSION.CFTOKEN = LOCAL.CFTOKEN />

		<cfset SESSION.User = { ID=0 , DateCreated= Now() } />

		<cftry>

			<cfset LOCAL.RememberMe = Decrypt( COOKIE.rememberMe, APPLICATION.encryptionKey, "cfmx_compat", "hex" ) />
			<cfset LOCAL.RememberMe = ListGetAt( LOCAL.rememberMe, 2, ":" ) />

			<cfif IsNumeric( LOCAL.rememberMe )>

				<cfset SESSION.user.id = LOCAL.rememberMe />

			</cfif>

			<cfcatch></cfcatch>
		</cftry>
		
		<!--- let's grab the settings --->
		<cfset SESSION.adminUser = settings.get()[1].adminUser />
		<cfset SESSION.adminPassword = settings.get()[1].adminPassword />
		<cfset SESSION.defaultRatingLimit = settings.get()[1].defaultRatingLimit />
		
		<cfreturn />
	</cffunction>


	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="I perform pre page processing. If I return false, I hault the rest of the page from processing.">


		<cfif StructKeyExists( URL, "reset" )>

			<cfset THIS.onApplicationStart() />
			<cfset THIS.onSessionStart() />

		</cfif>

		<cfreturn true />
	</cffunction>


	<cffunction name="OnRequest" access="public" returntype="void" output="true" hint="I execute the primary template.">

		<cfargument name="Page" type="string" required="true" hint="The page template requested by the user." />
		<cfinclude template="#ARGUMENTS.page#" />

		<cfreturn />
	</cffunction>

</cfcomponent>