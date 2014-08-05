<cfinclude template="includes/header.cfm" />
<div class="main">
	<div class="container">
		<div class="row">
			<div class="tabbable span9">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab2" data-toggle="tab">View Users</a></li>
					<li><a href="#tab3" data-toggle="tab">Add User</a></li>
				</ul>

				<div class="tab-content">
					
					<div class="tab-pane active" id="tab2">

						<div class="box-table widget">
							<div class="widget-content">
						     	<div class="title">
						      		<h3>Users</h3>
						      	</div><!-- end title -->

						      	<table class="table table-striped table-bordered table-condensed">
						        	<thead>
					          			<tr>
								            <th>#</th>
								            <th>Username</th>
								            <th>Default Rating</th>
								            <th>Admin</th>
								            <th>Active</th>
								            <th></th>
					          			</tr>
						        	</thead>

						        	<tbody id="userTableBody">
						          		
						        	</tbody>
						      	</table>
						    </div>
					    </div><!-- end box-table style1-->
					</div><!-- end Table2 -->

					<div class="tab-pane" id="tab3">
						<div class="box-form widget">
							<div class="widget-content">
								<div class="title" id="editTitle">
							      	<h3>Add User</h3>
							    </div>
								<form class="form-horizontal" id="addUserForm">
									<fieldset>
										<div class="control-group" id="usernameGroup">
											<label class="control-label" for="usernameInput">Username<span>(*)</span></label>
											<div class="controls">
												<input type="text" class="input-xlarge" id="usernameInput">
												<span class="help-inline" id="usernameHelp"></span>
									      	</div>
										</div>
										<div class="control-group" id="passwordGroup">
											<label class="control-label" for="passwordInput">Password<span>(*)</span></label>
											<div class="controls">
												<input type="password" class="input-xlarge" id="passwordInput">
												<span class="help-inline" id="passwordHelp"></span>
									      	</div>
										</div>
										<div class="control-group">
								        	<label class="control-label" for="ratingInput">Default Rating<span>(*)</span></label>
								            <div class="controls">
							              		<select id="ratingInput">
							              		</select>
								            </div>
								        </div>
								        <div class="control-group">
								            <label class="control-label" for="adminInput">Is Admin</label>
								            <div class="controls">
								             	<label class="checkbox">
								             		<input type="checkbox" id="adminInput" value="1">
								                	Is this user an Admin?
								            	</label>
								            </div>
								        </div>
								        <div class="control-group">
								        	<label class="control-label" for="activeInput">Is Active</label>
								            <div class="controls">
								            	<label class="checkbox">
								                	<input type="checkbox" id="activeInput" value="1">
								                	Is this user Active?
								              	</label>
								            </div>
								        </div>										
										<div class="form-actions border-rd4">
											<button type="submit" class="btn btn-primary">Save changes</button>
							            	<button class="btn" id="cancelBtn">Cancel</button>
										</div><!-- form-actions -->
		      						</fieldset>
								</form><!-- end form-horizontal -->
							</div>
						</div><!-- end box-form -->					
					</div><!-- end table3 -->
				</div><!-- end tab-content -->
			</div><!-- end table -->
			<div id="someDiv"></div>
			<cfinclude template="includes/navigation.cfm" />
		</div>
	</div><!-- end container -->
</div><!-- end main -->
<cfoutput>
	<script type="text/javascript">
		$(document).ready(function(){

			// Functions

			function getUsers() {
				$.ajax({
					type: "GET",
					url:"../components/user.cfc?method=GET",
					dataType: "json",
					data: {
						objectid: 0
					},
					success: function (data) {
						$("##userTableBody").html("");
						$.each(data,function(i,obj){
							var adminStatus = obj.BADMIN ? 'Yes' : 'No';
							var activeStatus = obj.BACTIVE ? 'Yes' : 'No';
							var deleteButton = '<a href="' + obj.OBJECTID + '" class="btn btn-red-s4 delete">Delete</a>';
							var div_data= '<tr><td>' + obj.OBJECTID + '</td><td>' + '<a href="' + obj.OBJECTID + '" class="editUser">' + obj.USERNAME + '</a></td><td>' + obj.RATINGLIMIT + '</td><td>' + adminStatus + '</td><td>' + activeStatus +'</td><td>' + deleteButton + '</td></tr>';

							$(div_data).appendTo('##userTableBody');
						});
					}
				});
			}

			function getRatings() {
				$.ajax({
					type: "GET",
					url:"../components/rating.cfc?method=GET",
					dataType: "json",
					data: {
						objectid: 0
					},
					success: function (data) {
						$("##ratingInput").html("");
						$.each(data,function(i,obj)
						{
							var div_data= '<option value="' + obj.OBJECTID + '">' + obj.TITLE + '</option>';
							$(div_data).appendTo('##ratingInput');
						});
					}
				});
			}

			// Actions

			$("body").on("click",".delete",function(e){
				e.preventDefault()
				var linkID = $(this).attr("href");
				var confirmDelete = confirm("Delete User?")
				if (confirmDelete){
					$.ajax({
						type: "DELETE",
						url:"../components/user.cfc?method=DELETE",
						dataType: "json",
						data: {
							objectid: linkID
						},
						success: function (data) {
							getUsers();
						}
					});
				}
			});

			$("##addUserForm").on("submit", function(e) { 
		    	e.preventDefault();
		    	var username = $('##usernameInput').val();
		    	var password = $('##passwordInput').val();
		    	var bAdmin = $("##adminInput").attr("checked") ? 1 : 0;
		    	var ratingLimitID = $('##ratingInput').val();
		    	var error = false;
		    	if(username.length < 2){
		    		$("##usernameGroup").attr("class", "control-group error");
                    $("##usernameHelp").html("Username must be at least 3 charcters long.");
                    var error = true;
		    	}
		    	if(password.length < 4){
		    		$("##passwordGroup").attr("class", "control-group error");
                    $("##passwordHelp").html("Password must be at least 5 charcters long.");
                    var error = true;
		    	}
		    	if(error == false){
		    		$.ajax({
						type: "POST",
						url:"../components/user.cfc?method=POST",
						dataType: "json",
						data: {
							username: username, password: password, bAdmin: bAdmin, ratingLimitID: ratingLimitID
						},
						success: function (data) {
							alert(username + " has been successfully added.");
							location.reload();
						}
					});
		    	}
		    });


		     $("##usernameInput").autocomplete({
                source: function(query, response) {
                    $.ajax({
                        url: "../components/search.cfc?method=username",
                        dataType: "json",
                        data: {
                            username: query.term
                        },
                        success: function(result) {
                            if(result == true){
                            	$("##usernameGroup").attr("class", "control-group error");
                            	$("##usernameHelp").html("Username is already taken.");
                            }
                            else{
                            	$("##usernameGroup").attr("class", "control-group success");
                            	$("##usernameHelp").html("Available!");
                            }
                        }
                    });
                },
                minLength: 1,
			    create: function () {
			        $(this).autocomplete("search", '');
			    }
            });

			$("body").on("click",".editUser",function(e){
				e.preventDefault();
				var userID = $(this).attr("href");
				$.ajax({
					type: "GET",
					url:"../components/user.cfc?method=GET",
					dataType: "json",
					data: {
						objectid: userID
					},
					success: function (data) {
						$.each(data,function(i,obj){
							$(".nav-tabs").html('<li><a href="##tab3" data-toggle="tab">Edit ' + obj.USERNAME + '</a></li>');
							$("##editTitle").html('<h3>Edit User</h3>');
							$('##usernameInput').val(obj.USERNAME);
							$('##ratingInput option[value="' + obj.RATINGLIMITID + '"]').attr("selected",true);
							$('##adminInput').prop('checked', obj.BADMIN);
							$('##activeInput').prop('checked', obj.BACTIVE);
							$('##addUserForm').attr('id','editUserForm');
							$("##passwordHelp").html("Leave blank to keep password the same.");
							$('.nav-tabs a[href="##tab3"]').tab('show');

							$(".form-horizontal").on("submit", function(e) { 
						    	e.preventDefault();
						    	var username = $('##usernameInput').val();
						    	var password = $('##passwordInput').val();
						    	var bAdmin = $("##adminInput").attr("checked") ? 1 : 0;
						    	var bActive = $("##activeInput").attr("checked") ? 1 : 0;
						    	var ratingLimitID = $('##ratingInput').val();
						    	var error = false;
						    	if(username.length < 2){
						    		$("##usernameGroup").attr("class", "control-group error");
				                    $("##usernameHelp").html("Username must be at least 3 charcters long.");
				                    var error = true;
						    	}
						    	if(error == false){
						    		$.ajax({
										type: "PUT",
										url:"../components/user.cfc?method=PUT",
										dataType: "json",
										data: {
											objectID: obj.OBJECTID, username: username, password: password, bAdmin: bAdmin, ratingLimitID: ratingLimitID, bActive: bActive
										},
										success: function (data) {
											alert(username + " has been successfully saved.");
											location.reload();
										}
									});
						    	}
						    });

						});
					}
				});
			});

			$("body").on("click","##cancelBtn",function(e){
				e.preventDefault()
				location.reload();
			});

			// Execute on Start

			getUsers();
			getRatings();

		});
	</script>
</cfoutput>
<cfinclude template="includes/footer.cfm" />