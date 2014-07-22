component name="test" output="true"{
   
    this.name = "keyStream";
    this.applicationTimeout = createTimeSpan(0, 1, 0, 0);       
    this.clientManagement = false;
    this.datasources["keystream"] = { class: 'org.sqlite.JDBC' , connectionString: 'jdbc:sqlite:webapps/ROOT/data/keystream.db' };
    this.datasource = "keystream";
    this.sessionManagement  = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
    this.setClientCookies = true;
     
    public boolean function OnApplicationStart(){
        //Handle OnApplicationStart Callback
        
        application.utils = createobject("component","components.utils");

        application.rootDirectory = getDirectoryFromPath(getCurrentTemplatePath());  

        var settings = createobject("component","components.settings");
        application.settings.currentVersion = settings.get()[1].currentVersion;
        application.settings.defaultRatingID = settings.get()[1].defaultRatingID;

        if(settings.get()[1].videoPath GT "") {
            application.settings.videoPath = settings.get()[1].videoPath;
        }
        else {
            application.settings.videoPath = expandPath("data/videos/");
        }

        return true;
    }
    public void function OnSessionStart(){
        //Handle OnSessionStart Callback
        session.user.id = 0;
        session.user.username = "Guest";
        session.user.bAdmin = 0;
        session.user.ratingLimitID = application.settings.defaultRatingID;
    }
    public void function OnSessionEnd(required struct SessionScope, struct ApplicationScope=structNew()){
        //Handle OnSessionEnd Callback
    }
    
}