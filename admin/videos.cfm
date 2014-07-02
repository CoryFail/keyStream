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

<cfparam name="URL.e" default="">
<cfparam name="URL.d" default="">
<cfset var categories = createobject("component","func.categories") />
<cfset var videoData = createobject("component","func.videos") />
<cfset var ratings = createobject("component","func.ratings") />
<cfset sourcePath = APPLICATION.uploadsDirectory & URL.e & "/thumbnails" />
<cfinclude template="includes/header.cfm" />
<cfoutput>
    <div id="wrapper">
        <div class="content-wrapper clear">
            <div class="section-title">
                <h1 class="title">Manage Videos <cfif URL.e GT ""><span><a href="videos.cfm"><< back to videos</a></span><cfelse><span><a href="index.cfm"><< back to dashboard</a></span></cfif></h1>
            </div>
			<cfif URL.e GT "">
				<div class="one">
					<cfif isDefined('FORM.vTitle')>
                        <cftry>
                            <cfset videoData.put(URL.e, FORM.vCategory, FORM.vGenre, FORM.vTitle, FORM.vDescription, FORM.vRating) />
                            <script>
                                alert("#FORM.vTitle# has been updated!");
                            </script>
                            <cfcatch>
                                <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
                            </cfcatch>
                        </cftry>
					</cfif>
					<cfif isDefined('FORM.thumbUpload')>
						<cftry>
							<cffile action="upload" fileField="thumbUpload" destination="#sourcePath#" nameconflict="overwrite" accept="image/*" />
							<cffile action="rename" destination="#sourcePath#/source.#cffile.serverFileExt#" source="#sourcePath#/#cffile.serverFile#">
							<cfset imageSource = sourcePath & "/source." & cffile.serverFileExt />
							<cfset imageLarge = sourcePath & "/large.jpg" />
							<cfset readImage = imageNew(imageSource)>
							<cfif (readImage.width LT 680) OR (readImage.height LT 383)>
								<cfset cropWidth = 480 />
								<cfset cropHeight = 270 />
							<cfelse>
								<cfset cropWidth = 680 />
								<cfset cropHeight = 383 />
							</cfif>
							<cfset imageCrop(readImage, (readImage.width/2) - (cropWidth/2), (readImage.height/2) - (cropHeight/2), cropWidth, cropHeight)>
							<cfimage action="write" destination="#imageLarge#" source="#readImage#" overwrite="true"> 
							<script>
								alert("This video's thumbnail has been updated!");
								window.location = "videos.cfm?e=#URL.e#";
							</script>
							<cfcatch>
                                <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
								<script>
									alert("Error: Please be sure you are uploading an image.");
									window.location = "videos.cfm?e=#URL.e#";
								</script>
							</cfcatch>
						</cftry>
					</cfif>
					<cfset name = URL.e />
					<cfset aVideo = videoData.get(name) />
					<form name="vForm" method="POST">
						<table border="0" style="border-spacing: 10px; border-collapse: separate; width:50%;">
							<tr>
								<td>Title:</td>
								<td><input type="text" name="vTitle" value="#aVideo[1].title#" style="width:100%;" /></td>
							</tr>
							<tr>
								<td>Description:</td>
								<td><textarea name="vDescription" style="width:100%">#aVideo[1].description#</textarea></td>
							</tr>
							<tr>
								<td>Category:</td>
								<td>
									<select name="vCategory" class="vCategory" id="vCategory_#name#">
										<cfloop collection="#categories.get()#" item="category">
											<option>#category#</option>
										</cfloop>
										<option>Uncategorized</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>Genre:</td>
								<td>
									<select name="vGenre" class="vGenre" id="vGenre_#name#">
										<option>Uncategorized</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>Rating:</td>
								<td>
									<select name="vRating" class="vRating" id="vRating_#name#">
										<cfloop list="#ratings.get()#" index="rating">
											<option>#rating#</option>
										</cfloop>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2"><input name="submit" type="submit" value="save" /></td>
							</tr>
						</table>
					</form>
					<form name="tForm" method="POST" enctype="multipart/form-data">
						<table border="0" style="border-spacing: 10px; border-collapse: separate;">
							<cfif FileExists(sourcePath & "/large.jpg")>
							<tr>
								<td colspan="2"><img src="../data/videos/#URL.e#/thumbnails/large.jpg" width="150px"></td>
							</tr>
							</cfif>
							<tr>
								<td>Thumbnail:</td>
								<td><input type="file" name="thumbUpload" /></td>
							</tr>
							<tr>
								<td colspan="2"><input name="submit" type="submit" value="upload" /></td>
							</tr>
						</table>
					</form>
				</div>
			<cfelse>
				<cfif URL.d GT "">
                    <cftry>
                        <cfset DirectoryDelete(APPLICATION.uploadsDirectory & URL.d,true)>
                        <script>
                            alert("The video has been deleted!");
                        </script>
                        <cfcatch>
                            <script>
                                alert("There was an error while deleting this video.");
                            </script>
                            <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
                        </cfcatch>
                    </cftry>
				</cfif>
				<cfdirectory action="list" directory="#application.uploadsDirectory#" name="qVideos" />
				<div class="one-half">
					<h1 class="title">Active Videos</h1>
					<ul class="colored-counter-list">
						<cfloop query="qVideos">
                            <cftry>
                                <cfset aVideo = videoData.get(name) />
                                <li>
                                    <cfif FileExists(ExpandPath("../data/videos/#name#/thumbnails/large.jpg"))><img src="../data/videos/#name#/thumbnails/large.jpg" width="80px"><br></cfif><strong>#aVideo[1].title#</strong><br>[<a href="?e=#name#">edit</a>] [<a href="?d=#name#">delete</a>]
                                </li>
                                <cfcatch>
                                    <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
                                </cfcatch>
                            </cftry>
						</cfloop>
					</ul>
				</div>
				<div class="one-half last">
					<h1 class="title">Add New Video</h1>
					<form action="../func/uploads.cfc?method=post" enctype="multipart/form-data" method="POST" name="uploadVideo">
						Title<br><input type="text" name="videoTitle" style="width:220px;"><br><br>
						<input type="file" name="file" style="width:220px;"><br><br>
						<input type="submit" name="submit_upload" value="Upload Video">
					</form>
				</div>
			</cfif>
        </div>
    </div>
</cfoutput>
<cfinclude template="includes/footer.cfm" />
<cfif URL.e GT "">
	<script>
		<cfoutput>
			$('.vCategory').val('#aVideo[1].category#');
			$('.vRating').val('#aVideo[1].rating#');
		</cfoutput>
		var categoryValue = $(".vCategory").val();
		$.ajax({
			type: "GET",
			url:"func/categoryDropDown.cfc?method=GET",
			dataType: "json",
			data: { 
				category: categoryValue
			},
			success: function (data) {
				$(".vGenre").html("");
				<cfoutput>var div_start="<option value='#aVideo[1].categoryGenre#'>#aVideo[1].categoryGenre#</option>";</cfoutput>
				$(div_start).appendTo('.vGenre'); 
				$.each(data,function(i,obj)
					   {
						  var div_data="<option>"+obj+"</option>";
						   $(div_data).appendTo('.vGenre'); 
					   });
			}
		});
		$('.vCategory').change(function() {  
			var categoryValue = $(".vCategory").val();
			$.ajax({
				type: "GET",
				url:"func/categoryDropDown.cfc?method=GET",
				dataType: "json",
				data: { 
						category: categoryValue
				},
				success: function (data) {
					$(".vGenre").html("");

					$.each(data,function(i,obj)
					   {
						   var div_data="<option>"+obj+"</option>";
						   $(div_data).appendTo('.vGenre'); 
					   });  
				}
			});
		});
	</script>
</cfif>