<cfinclude template="includes/header.cfm" />
<cfoutput>
    <div class="main">
    	<div class="container" style="min-height:500px;">
    		<div class="row">
    			<div class="box-wrapper  span12">
    				<div class="login-content span4 offset4">
                        <div class="header-login well">
                            <h3>Login</h3>
                        </div>
                        <form id="login_form" class="well">
                            <label>Username</label>
                            <input type="text" id="username" class="input" placeholder="Type something...">
                            <label>Password</label>
                            <input type="password" id="password" class="input" placeholder="Type something...">
                            <input type="submit" class="btn btn-info" value="Login">
                            <p class="sign-up-lg">Don't have an account? <a href="sign-up.html">Sign Up.</a></p>
                        </form>	
                    </div>				
    			</div><!-- end  -->
    		</div><!-- row -->
        </div><!-- end container -->
    </div><!-- end main -->
    <script type="text/javascript">
        $(document).ready(function() {
            var userID = "#encodeForJavaScript(session.user.id)#";
            if(userID == 0){
                $("##login_form").on("submit", function(e) {
                    
                    e.preventDefault(); 
                    var usernameValue = $("##username").val();
                    var passwordValue = $("##password").val();
                    
                    $.ajax({
                        url:"components/login.cfc?method=GET&returnformat=plain",
                        dataType: "json",
                        data: {
                            username: usernameValue,
                            password: passwordValue
                        },
                        success: function (result) {
                            if(result == true){
                                window.location.href = "index.cfm";
                            }
                            else{
                                alert("Incorrect username or password.");
                            }
                        }
                    });

                });
            }
            else{
                window.location.href = "index.cfm";
            }
        });
    </script>
</cfoutput>
<cfinclude template="includes/footer.cfm" />