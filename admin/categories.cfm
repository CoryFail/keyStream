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

<cfset var categories = createobject("component","func.categories") />
<cfinclude template="includes/header.cfm" />
<cfoutput>
	<cfif isDefined('FORM.addCategory')>
		<cfset categories.post(FORM.addCategory) />
		<script>
			alert("The category #FORM.addCategory# has been added!");
		</script>
	</cfif>
	<cfif isDefined('FORM.genreSubmit')>
		<cfset categories.put(FORM.genreCategory, FORM.addGenre) />
		<script>
			alert("The genre #FORM.addGenre# has been added!");
		</script>
	</cfif>
	<cfif isDefined('URL.c')>
		<cfif isDefined('URL.g')>
			<cfset categories.delete(URL.c, URL.g) />
			<script>
				alert("The genre #URL.g# has been removed!");
			</script>
		<cfelse>
			<cfset categories.delete(URL.c) />
			<script>
				alert("The category #URL.c# has been removed!");
			</script>
		</cfif>
	</cfif>
    <div id="wrapper">
        <div class="content-wrapper clear">
            <div class="section-title">
				<h1 class="title">Manage Categories <span><a href="index.cfm"><< back to dashboard</a></span></h1>
            </div>
            <div class="one">
				<div style="margin-bottom:20px;">
					<form method="POST">
						<input type="text" name="addCategory" style="width:200px;"> 
						<input type="Submit" name="Submit" value="Add New Category">
					</form>
				</div>
				<cfloop collection="#categories.get()#" item="category">
					<div class="toggle-wrap">
						<span class="trigger"><a href="##">#category#</a></span>
						<div class="toggle-container" style="width:97%">
							<div class="one-half">
								<ul class="star-list" style="margin-bottom:20px;"> 
									<cfloop list="#ListSort(categories.get()[category], "Text")#" index="genre">
										<li>#genre# <a href="categories.cfm?c=#REPLACE(category, "&", "_amp;")#&g=#REPLACE(genre, "&", "_amp;")#">[delete]</a></li> 
									</cfloop>									
								</ul>
								<form method="POST">
									<input type="text" name="addGenre">
									<input type="hidden" name="genreCategory" value="#category#"> 
									<input type="Submit" name="genreSubmit"  value="Add Genre"> 
								</form>
							</div>
							<div class="one-half last" style="text-align:right;">
								<a href="categories.cfm?c=#category#" class="button medium red">delete category</a>
							</div>
						</div>
					</div>
				</cfloop>
            </div>
        </div>
    </div>
</cfoutput>
<cfinclude template="includes/footer.cfm" />