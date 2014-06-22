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

<cfoutput>
	<cftry>
		<cfparam name="form.videoTitle" type="string" />
		<cfparam name="form.file" type="string" />

		<!--- assign the video a unique name --->
		<cfset var videoName = "video_" & RandRange(0, 999999) />

		<!--- let's create the file structure --->
		<cfif NOT DirectoryExists("#application.uploadsDirectory##videoName#")>
			<cfset DirectoryCreate("#application.uploadsDirectory##videoName#") />
			<cfset DirectoryCreate("#application.uploadsDirectory##videoName#/thumbnails") />
		</cfif>

		<!--- Save the file to the uploads directory. --->
		<cffile	result="upload"	action="upload" filefield="file" destination="#application.uploadsDirectory##videoName#" nameconflict="makeunique" accept="video/*" />
		<cffile action="rename"	source="#application.uploadsDirectory##videoName#/#upload.serverFile#" destination="#application.uploadsDirectory##videoName#/video.#upload.serverFileExt#" />

		<!--- create the data file --->
		<cfset var newFileName = "video." & upload.serverFileExt />
		<cfset var settingsValues =	[
				{
					fileName = newFileName,
					originalFileName = upload.serverFile,
					dateCreated = now(),
					category = "Uncategorized",
					categoryGenre = "Uncategorized",
					title = FORM.videoTitle,
					description = "There is no description added yet.",
					rating = "G"
				}
		] />
		<cffile action="write" file="#application.uploadsDirectory##videoName#/data.json" output="#SerializeJSON(settingsValues)#" mode="777" />

		<!--- redirect to modify page --->
		<cflocation url="videos.cfm?e=#videoName#" addtoken="false" />
		<cfcatch>
			<cfset DirectoryDelete("#application.uploadsDirectory##videoName#", True) />
			<script>
				alert("Error: Please be sure you are uploading a video.");
				window.location = "videos.cfm";
			</script>
		</cfcatch>
	</cftry>
</cfoutput>