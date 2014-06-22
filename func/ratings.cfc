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
		<cfset var ratings = "G,PG,PG13,R,NC17" />
		<cfreturn ratings />
	</cffunction>
	<cffunction name="GETid">
		<cfargument name="rating" required="false" />
		<cfset var id = ListFind(GET(), arguments.rating) />
		<cfreturn id />
	</cffunction>
</cfcomponent>