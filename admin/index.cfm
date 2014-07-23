<cfinclude template="includes/header.cfm" />
<cfoutput>
    <div class="main">
        <div class="container">
            <div class="row">
                <div class="tabbable span9">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab1">
                            <div class="style-button widget">
                                <div class="widget-content">
                                    <h3 class="title">Dashboard</h3>
                                    <ul class="nav nav-pills">
                                        <li style="color:##c6c6c6;">
                                            <p id="keyStreamVersion"></p>
                                            <p id="railoVersion"></p>
                                            <p id="localHost"></p>
                                            <p id="localAddress"></p>
                                            <p id="internetAccess"></p>
                                            <p id="videoPath"></p>
                                        </li>
                                    </ul>
                                </div>
                            </div><!-- end style-button -->
                        </div>
                        <!-- end Table1 -->
                    </div><!-- end tab-content -->
                </div><!-- end table -->
                <cfinclude template="includes/navigation.cfm" />
            </div>
        </div><!-- end container -->
    </div><!-- end main -->
    <script type="text/javascript">
        $(document).ready(function() {
            // keyStreamVersion
            var currentVersion = "#encodeForJavaScript(application.settings.currentVersion)#";
            var updateVersion = "#encodeForJavaScript(application.update.version)#";
            if(currentVersion != updateVersion){
                var updateNow = "<br>Version " + updateVersion + " available." + "<br><button class='btn btn-blue-s4'>Update Now!</button>";
            }
            else{
                var updateNow = "";
            }
            $("##keyStreamVersion").html("<strong>keyStream Version:</strong> " + currentVersion + updateNow);

            // railoVersion
            var railoVersion = "#encodeForJavaScript(server.railo.version)#";
            $("##railoVersion").html("<strong>Railo Version:</strong> " + railoVersion);

             // localHost
            var localHost = "#encodeForJavaScript(cgi.local_host)#";
            $("##localHost").html("<strong>Local Host:</strong> " + localHost);

            // localAddress
            var localAddress = "#encodeForJavaScript(cgi.local_addr)#";
            $("##localAddress").html("<strong>Local Address:</strong> " + localAddress);

            // internetAccess
            var internetAccess = "#encodeForJavaScript(application.update.internetAccess)#";
            if(internetAccess == "false"){
                var retryConnection = " <a href='##' id='retyConnection'>Retry Connection</a>";
            }
            else{
                var retryConnection = "";
            }
            $("##internetAccess").html("<strong>Internet Access:</strong> " + internetAccess + retryConnection);

             // videoPath
            var videoPath = "#encodeForJavaScript(application.settings.videoPath)#";
            $("##videoPath").html("<strong>Video Path:</strong> " + videoPath);

            $("##retyConnection").on("click", function(e) {
                e.preventDefault()
                $.ajax({
                    url:"../components/update.cfc?method=GET&returnformat=plain",
                    dataType: "json",
                    success: function (result) {
                        if(result == true){
                           alert("Application now has access to the internet.");
                           location.reload();
                        }
                        else{
                            alert("Could not find a connection. Please check your network.");
                        }
                    }
                });
            });
        });
    </script>
</cfoutput>
<cfinclude template="includes/footer.cfm" />