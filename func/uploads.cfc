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
	<cffunction name="PUT" access="remote">
		<cfdirectory action="list" directory="#application.rootDirectory#/uploads" name="qUploads" />
        
        <cfloop query="qUploads">
            <cfset var videoName = "video_" & RandRange(0, 999999) />
            <cfset fileExtension = ListLast(name, ".") />
            <!--- let's create the file structure --->
            <cfif NOT DirectoryExists("#application.uploadsDirectory##videoName#")>
                <cfset DirectoryCreate("#application.uploadsDirectory##videoName#") />
                <cfset DirectoryCreate("#application.uploadsDirectory##videoName#/thumbnails") />
            </cfif>

            <!--- Save the file to the uploads directory. --->
            <cffile	action="move" source="#application.rootDirectory#uploads/#name#" destination="#application.uploadsDirectory##videoName#/#name#" />
            <cffile action="rename"	source="#application.uploadsDirectory##videoName#/#name#" destination="#application.uploadsDirectory##videoName#/video.#fileExtension#" />

            <!--- create the data file --->
            <cfset var newFileName = "video." & fileExtension />
            <cfset var settingsValues =	[
                    {
                        fileName = newFileName,
                        originalFileName = name,
                        dateCreated = now(),
                        category = "Uncategorized",
                        categoryGenre = "Uncategorized",
                        title = name,
                        description = "There is no description added yet.",
                        rating = "G"
                    }
            ] />
            <cffile action="write" file="#application.uploadsDirectory##videoName#/data.json" output="#SerializeJSON(settingsValues)#" mode="777" />
        </cfloop>
        
		<cfreturn true />
	</cffunction>
</cfcomponent>