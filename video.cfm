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
	<cfset var videoData = createobject("component","func.videos") />
	<cfset aVideo = videoData.get(URL.v) />
	<div id="wrapper">	
		<div class="content-wrapper clear">
			<div class="section-title">
				<h1 class="title">#aVideo[1].title#</h1>			
			</div>	
			<div class="one-third">	
				<p>#aVideo[1].description#</p>
				<a href="library.cfm?c=#aVideo[1].category#" class="button small rectangle orange">#aVideo[1].category#</a>	<a href="library.cfm?c=#aVideo[1].category#&g=#aVideo[1].categoryGenre#" class="button small rectangle red">#aVideo[1].categoryGenre#</a><br /><br />								<h2 class="title">Rated: #aVideo[1].rating#</h2>	
			</div>
			<div class="two-third last">
				<div class="flexslider">
					<video id="example_video_1" class="video-js vjs-default-skin" controls preload="none"
				      poster="data/videos/#URL.v#/thumbnails/large.jpg"
				      data-setup="{}">
						<source src="data/videos/#URL.v#/#aVideo[1].filename#" type="video/#ListLast(aVideo[1].filename, ".")#" />
				    	<!--- feature coming soon
				    	<track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track> --->
				    	<track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track>
				   		<p class="vjs-no-js">To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
				  </video>
				</div>	
			</div>		
		</div>
	</div>
	<cfinclude template="includes/footer.cfm" />
</cfoutput>