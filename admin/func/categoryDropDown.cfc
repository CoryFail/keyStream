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
	<cffunction name="GET" access="remote">
		<cfargument name="category" required="true" />
		<cfif arguments.category EQ "Uncategorized">
			<cfset var aGenre = ListToArray("Uncategorized") />
			<cfreturn aGenre />
		<cfelse>
			<cffile action="read" file="#application.rootDirectory#data/categories.json" variable="categories" />
			<cfset var sGenre = deserializeJSON(categories) />
			<cfset var lGenre = sGenre[arguments.category] />
			<cfset var lGenre = ListAppend(lGenre, "Uncategorized") />
			<cfset var aGenre = ListToArray(lGenre) />
			<cfreturn aGenre />
		</cfif>
	</cffunction>
</cfcomponent>