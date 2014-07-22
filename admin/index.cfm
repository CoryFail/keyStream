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
                                            <p><strong>keyStream Version:</strong> #application.settings.currentVersion#</p>
                                            <p><strong>Railo Version:</strong> #server.railo.version#</p>
                                            <p><strong>Local Host:</strong> #cgi.local_host#</p>
                                            <p><strong>Local Address:</strong> #cgi.local_addr#</p>
                                            <p><strong>Internet Access:</strong> Yes</p>
                                            <p><strong>Video Path:</strong> #application.settings.videoPath#</p>
                                        </li>
                                    </ul>
                                </div>
                            </div><!-- end style-button -->
                        </div>
                        <!-- end Table1 -->
                    </div><!-- end tab-content -->
                </div><!-- end table -->
                <div class="list-menu box-wrapper span3">
                    <div class="row">
                        <div class="title bg-title span3">
                            <h3>Admin Navigation</h3>
                        </div>
                    </div>
                    <ul class="nav nav-list">
                        <li class="active"><a href="index.cfm"><i class="icon-home"></i>Dashboard</a></li>
                        <li><a href="##"><i class="icon-book"></i>Manage Videos</a></li>
                        <li><a href="##"><i class="icon-book"></i>Manage Categories</a></li>
                        <li><a href="##"><i class="icon-book"></i>Manage Users</a></li>
                        <li><a href="##"><i class="icon-book"></i>Application Settings</a></li>
                    </ul>
                </div><!-- end list-menu -->
            </div>
        </div><!-- end container -->
    </div><!-- end main -->
</cfoutput>
<cfinclude template="includes/footer.cfm" />