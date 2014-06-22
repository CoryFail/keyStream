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
		<div id="footer">
			<div id="footer-bottom" class="clear">
				<div class="one-half">
					<p>Copyright &copy; 2014 <a href="http://coryfail.com" target="_blank">Cory Fail</a>. All rights reserved.</p>
				</div>
				<div class="one-half text-align-right last">
					<cfif SESSION.user.id EQ 1>
						<p><a href="logout.cfm">Logout</a>
						</p>
						<cfelse>
							<p><a href="login.cfm">Login</a>
							</p>
					</cfif>
				</div>
			</div>
		</div>
	</body>
</html>