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
<cfset var videoData = createobject("component","func.videos") />
<cfset var ratings = createobject("component","func.ratings") />
<cfoutput>
	<cfdirectory action="list" directory="#application.uploadsDirectory#" name="qVideos" />
	<div id="wrapper">	
		<div class="content-wrapper clear">
			<div class="section-title text-align-center">
				<h1 class="title">Thank you for using keyStream. The open source personal media server.</h1>
				<p>Enjoy your recently uploaded videos below.</p>	
			</div>
			<div class="filterable">	
				<ul id="portfolio-nav">
					<li class="current"><a href="##" data-filter="*">All</a><span>/</span></li>
					<cfloop collection="#categories.get()#" item="category">
						<cfset catReplace = REReplace(category, " ", "_") />
						<li><a data-filter=".#catReplace#" href="##">#category#</a><span>/</span></li>
					</cfloop>
				</ul>
			</div>
			<div class="portfolio-grid">
				<cfif qVideos.recordCount GT "0">
					<ul id="thumbs">
						<cfloop query="qVideos" endrow="20">
                            <cftry>
                                <cfset aVideo = videoData.get(name) />
                                <cfif (ratings.GETid(aVideo[1].rating) LTE ratings.GETid(SESSION.defaultRatingLimit)) OR  (SESSION.User.ID EQ 1)>
                                    <cfset catReplace = Replace(aVideo[1].category, " ", "_") />
                                    <li class="col4 item #catReplace#">
                                        <cfif FileExists("data/videos/#name#/thumbnails/large.jpg")>
                                            <img src="data/videos/#name#/thumbnails/large.jpg" alt="" />
                                        <cfelse>
                                            <img src="assets/images/default-video.jpg" alt="" />
                                        </cfif>
                                        <div class="col4 item-info">
                                            <h3 class="title"><a href="video.cfm?v=#name#">#aVideo[1].title#</a></h3>
                                        </div>
                                        <div class="item-info-overlay">
                                            <div>
                                                <h4>#aVideo[1].category#</h4>	
                                                <p>Rated #aVideo[1].rating#</p>
                                                <p>#Left(aVideo[1].description, 120)#...</p>
                                                <a href="video.cfm?v=#name#" class="view">details</a>
                                            </div>					
                                        </div>
                                    </li>
                                </cfif>
                                <cfcatch>
                                    <cflog application="true" log="Application" type="error" text="#cfcatch.message#" />
                                </cfcatch>
                            </cftry>
						</cfloop>
					</ul>
				<cfelse>
					<h1 class="title" style="text-align:center; font-size:30px;">You have no videos uploaded!</h1>
				</cfif>
			</div>
		</div>
	</div> 
</cfoutput>
<cfinclude template="includes/footer.cfm" />