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

<cfinclude template="includes/header.cfm" />
<cfoutput>
	<cfif isDefined('URL.u')>
		<cfset uploads = createobject("component","func.uploads") />
		<cfset uploads.put() />
		<script>
			alert("All videos have been uploaded!");
		</script>
	</cfif>
	<cfdirectory action="list" directory="#application.rootDirectory#/uploads" name="qUploads" />
	<div id="wrapper">
		<div class="content-wrapper clear">
			
			<cfif qUploads.recordCount GT "0">
				<div style="margin-top:-20px;margin-bottom:20px;">
					<strong>You have #qUploads.recordCount# videos in the uploads queue. <a href="index.cfm?u=true">Upload them now.</a></strong>
				</div>
			</cfif>
			
			<div class="section-title">
				<h1 class="title">
					Admin <span>manage your media server <a href="../index.cfm"><br><< back to media library</a></span>
				</h1>
			</div>

			<div class="one-half">
				<h3 class="title">Manage Videos</h3>
				<p>You can easily, upload, modify, or remove a video from the library from keyStream.</p>
				<p><a href="videos.cfm" class="button large rounded grey">Manage</a>
				</p>
			</div>

			<div class="one-half last">
				<h3 class="title">Manage Categories</h3>
				<p>Would you like to add more genres to the current category list? We have a management area for that.</p>
				<p><a href="categories.cfm" class="button large rounded grey">Manage</a>
				</p>
			</div>

			<div class="divider-border"></div>

			<div class="one-half">
				<h3 class="title">Quick Upload</h3>
				<form action="upload_files.cfm" enctype="multipart/form-data" method="POST" name="uploadVideo">
					Title<br><input type="text" name="videoTitle" style="width:220px;"><br><br>
					<input type="file" name="file" style="width:220px;"><br><br>
					<input type="submit" name="submit_upload" value="Upload Video">
				</form>
			</div>


			<div class="one-half last">
				<h3 class="title">General Settings</h3>
				<p>Change around the general settings to personalize this media server.</p>
				<p><a href="settings.cfm" class="button large rounded grey">Manage</a>
				</p>
			</div>

		</div>
	</div>
</cfoutput>
<cfinclude template="includes/footer.cfm" />