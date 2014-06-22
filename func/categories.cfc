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
	<cffunction	name="ListDeleteValue" access="public" returntype="string" output="false" hint="Deletes a given value (or list of values) from a list. This is not case sensitive.">
		<cfargument	name="List"	type="string" required="true" hint="The list from which we want to delete values." />
		<cfargument	name="Value" type="string" required="true"	hint="The value or list of values that we want to delete from the first list." />
		<cfargument	name="Delimiters" type="string"	required="false" default="," hint="The delimiting characters used in the given lists."	/>
		<cfset var LOCAL = StructNew() />
		<cfset LOCAL.Result = ArrayNew( 1 ) />
		<cfset LOCAL.ListArray = ListToArray( ARGUMENTS.List,  ARGUMENTS.Delimiters ) />
		<cfset LOCAL.ValueLookup = StructNew() />

		<cfloop	index="LOCAL.ValueItem"	list="#ARGUMENTS.Value#" delimiters="#ARGUMENTS.Delimiters#">
			<cfset LOCAL.ValueLookup[ LOCAL.ValueItem ] = true />
		</cfloop>

		<cfloop	index="LOCAL.ValueIndex" from="1" to="#ArrayLen( LOCAL.ListArray )#" step="1">
			<cfset LOCAL.Value = LOCAL.ListArray[ LOCAL.ValueIndex ] />
			<cfif NOT StructKeyExists( LOCAL.ValueLookup, LOCAL.Value )>
				<cfset ArrayAppend( LOCAL.Result, LOCAL.Value ) />
			</cfif>
		</cfloop>
		<cfreturn ArrayToList( LOCAL.Result, Left( ARGUMENTS.Delimiters, 1 ) ) />
	</cffunction>
	
	<cffunction name="GET">
		<cffile action="read" file="#application.rootDirectory#data/categories.json" variable="categoriesJSON" />
		<cfreturn DeserializeJSON(categoriesJSON) />
	</cffunction>
	
	<cffunction name="PUT">
		<cfargument name="category" />
		<cfargument name="genre" />
		<cfset var currentCategories = get() />
		<cfset var currentCategoriesList = get()[ARGUMENTS.category] />
		<cfset var currentCategoriesList = ListAppend(currentCategoriesList, ARGUMENTS.genre) />
		<cfset StructDelete(currentCategories, ARGUMENTS.category) />
		<cfoutput>
			<cfset newCategory = [
			   {
				   "#ARGUMENTS.category#" = "#currentCategoriesList#"
			   }   
			] />
		</cfoutput>
		<cfset StructAppend(currentCategories, newCategory[1]) />
		<cffile action="write" file="#application.rootDirectory#data/categories.json" output="#serializeJSON(currentCategories)#" />
		<cfreturn true />
	</cffunction>
	
	<cffunction name="POST">
			<cfargument name="category" />
			<cfset var currentCategories = get() />
			<cfoutput>	
				<cfset var newCategory = [
					   {
						   "#ARGUMENTS.category#" = ""
					   }   
					] />
			</cfoutput>
			<cfset StructAppend(currentCategories, newCategory[1]) />
			<cffile action="write" file="#application.rootDirectory#data/categories.json" output="#serializeJSON(currentCategories)#" />
		<cfreturn true />
	</cffunction>
	
	<cffunction name="DELETE" hint="Only include the genre argument if you want a specific genre deleted. Otherwise it will delete the entire category.">
		<cfset video = createobject("component","videos") />
		<cfargument name="category" required="true" />
		<cfargument name="genre" required="false" />
		<cfset ARGUMENTS.category = REPLACE(ARGUMENTS.category, "_amp;", "&") />
		<cfset ARGUMENTS.genre = REPLACE(ARGUMENTS.genre, "_amp;", "&") />
		<cfset var currentCategories = get() />
		<cfoutput>
			<cfif ARGUMENTS.genre GT "">
				<cfset var currentCategoriesList = get()[ARGUMENTS.category] />
				<cfset var currentCategoriesList = ListDeleteValue(currentCategoriesList, ARGUMENTS.genre) />
				<cfset StructDelete(currentCategories, ARGUMENTS.category) />

				<cfset newCategory = [
					   {
						"#ARGUMENTS.category#" = "#currentCategoriesList#"
					   }   
				] />

				<cfset StructAppend(currentCategories, newCategory[1]) />

				<!--- mark all as Uncategorized --->
				<cfdirectory action="list" directory="#application.uploadsDirectory#" name="qVideos" />
				<cfloop query="qVideos">
					<cffile action="read" file="#directory#/#name#/data.json" variable="videoData" />
					<cfset aVideo = deserializeJSON(videoData) />
					<cfif (aVideo[1].category EQ ARGUMENTS.category) AND (ARGUMENTS.genre EQ aVideo[1].categoryGenre)>	
						<cfset video.put(name, ARGUMENTS.category, "Uncategorized") />
					</cfif>
				</cfloop>
				
			<cfelse>
				
				<cfset StructDelete(currentCategories, ARGUMENTS.category) />
				
				<!--- mark all as Uncategorized --->
				<cfdirectory action="list" directory="#application.uploadsDirectory#" name="qVideos" />
				<cfloop query="qVideos">
					<cffile action="read" file="#directory#/#name#/data.json" variable="videoData" />
					<cfset aVideo = deserializeJSON(videoData) />
					<cfif aVideo[1].category EQ ARGUMENTS.category>	
						<cfset video.put(name, "Uncategorized", "Uncategorized") />
					</cfif>
				</cfloop>
				
			</cfif>
		</cfoutput>
		<cffile action="write" file="#application.rootDirectory#data/categories.json" output="#serializeJSON(currentCategories)#" />
		<cfreturn true />
	</cffunction>
</cfcomponent>