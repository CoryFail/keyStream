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
<cfparam name="URL.g" default="All" />
<cfset var libraryVideos = createobject("component","func.library") />
<cfset var videoData = createobject("component","func.videos") />
<cfset videoList = libraryVideos.get(URL.c, URL.g) />
<cfoutput>
	<div id="wrapper">	
		<div class="content-wrapper clear">
			<div class="section-title">
				<h1 class="title">#URL.c# <span> / #URL.g#</span></h1>
			</div>
			<div class="filterable">
				<ul>
					<li<cfif URL.g EQ "All"> class="current"</cfif>><a href="?c=#URL.c#&g=All" id="all">All</a><span>/</span></li>
					<cfloop list="#categories.get()[URL.c]#" index="genre">
						<li<cfif URL.g EQ genre> class="current"</cfif>>
							<a href="?c=#urlencodedformat(URL.c)#&g=#urlencodedformat(genre)#" id="#genre#">#genre#</a><span>/</span>
						</li>
					</cfloop>
				</ul>
			</div>
			<div class="portfolio-grid">
				<cfif videoList GT "">
					<ul id="thumbs">
						<cfloop list="#videoList#" index="video">
							<cfset aVideo = videoData.get(video) />
							<li class="col4 item #aVideo[1].categoryGenre#">
								<!--- need blank image --->
								<img src="data/videos/#video#/thumbnails/large.jpg" alt="" />
								<div class="col4 item-info">
									<h3 class="title"><a href="video.cfm?v=#video#">#aVideo[1].title#</a></h3>
								</div><	
								<div class="item-info-overlay">
									<div>
										<h4>#aVideo[1].categoryGenre#</h4>	
										<p>Rated #aVideo[1].rating#</p>
										<p>#aVideo[1].description#</p>
										<a href="video.cfm?v=#video#" class="view">details</a>
									</div>					
								</div>
							</li>								
						</cfloop>
					</ul>
				<cfelse>
					<h1 class="title" style="text-align:center; font-size:30px;">You have no videos uploaded for this <cfif URL.g EQ "All">catergory<cfelse>genre</cfif>!</h1>
				</cfif>
			</div>
		</div>
	</div> 
</cfoutput>
<cfinclude template="includes/footer.cfm" />