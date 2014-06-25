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
	<cfset ratings = createobject("component","ratings") />
	<cffunction name="GET">
		<cfargument name="category" required="true">
		<cfargument name="genre" required="true">
		<cfset var videoList = "" />
		<cfdirectory action="list" directory="#application.uploadsDirectory#" name="qVideos" />
		<cfloop query="qVideos">
            <cftry>
                <cffile action="read" file="#directory#/#name#/data.json" variable="videoData" />
                <cfset aVideo = deserializeJSON(videoData) />
                <cfif (aVideo[1].category EQ ARGUMENTS.category) AND ((ARGUMENTS.genre EQ aVideo[1].categoryGenre) OR (ARGUMENTS.genre EQ "All")) AND ((ratings.GETid(aVideo[1].rating) LTE ratings.GETid(SESSION.defaultRatingLimit)) OR  (SESSION.User.ID EQ 1))>	
                    <cfset videoList = ListAppend(videoList, name) />
                </cfif>
                <cfcatch>
                    <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
                </cfcatch>
            </cftry>
		</cfloop>
		<cfreturn videoList />
	</cffunction>
</cfcomponent>