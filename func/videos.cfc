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
		<cfargument name="video" />
		<cfset dataPath = application.uploadsDirectory & arguments.video & "/data.json" />
		<cffile action="read" file="#dataPath#" variable="videoJSON" />
		<cfreturn DeserializeJSON(videoJSON) />
	</cffunction>
	<cffunction name="PUT">
		<cfargument name="video" />
		<cfargument name="category" />
		<cfargument name="categoryGenre" />
		<cfargument name="title" />
		<cfargument name="description" />
		<cfargument name="rating" />
		<cfset var currentData = get(arguments.video) />
		<cfif len(trim(arguments.category)) gt 0>
			<cfset categoryData = arguments.category />
		<cfelse>
			<cfset categoryData = currentData[1].category />
		</cfif>
		<cfif len(trim(arguments.categoryGenre)) gt 0>
			<cfset categoryGenreData = arguments.categoryGenre />
		<cfelse>
			<cfset categoryGenreData = currentData[1].categoryGenre />
		</cfif>
		<cfif len(trim(arguments.title)) gt 0>
			<cfset titleData = arguments.title />
		<cfelse>
			<cfset titleData = currentData[1].title />
		</cfif>
		<cfif len(trim(arguments.description)) gt 0>
			<cfset descriptionData = arguments.description />
		<cfelse>
			<cfset descriptionData = currentData[1].description />
		</cfif>
		<cfif len(trim(arguments.rating)) gt 0>
			<cfset ratingData = arguments.rating />
		<cfelse>
			<cfset ratingData = currentData[1].rating />
		</cfif>
		<cfoutput>
			<cfset var settingsValues =	[
					{
						fileName = currentData[1].fileName,
						originalFileName = currentData[1].originalFileName,
						dateCreated = currentData[1].dateCreated,
						category = categoryData,
						categoryGenre = categoryGenreData,
						title = titleData,
						description = descriptionData,
						rating = ratingData
					}
			] />
		</cfoutput>
		<cffile action="write" file="#dataPath#" output="#serializeJSON(settingsValues)#" />
		<cfreturn true />
	</cffunction>
</cfcomponent>