component name="test" output="true"{
   
    this.name = "keyStream";
    this.applicationTimeout = createTimeSpan(0, 1, 0, 0);       
    this.clientManagement = false;
    this.datasources["keystream"] = { class: 'org.sqlite.JDBC' , connectionString: 'jdbc:sqlite:webapps/ROOT/data/keystream.db' };
    this.datasource = "keystream";
    this.loginStorage = "cookie";
    this.serverSideFormValidation = true;
    this.sessionManagement  = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
    this.setClientCookies = true;
    this.setDomainCookies  = false;
    this.scriptProtect  = false;
     
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
    public void function OnApplicationEnd(struct ApplicationScope=structNew()){
        //Handle OnApplicationEnd Callback
    }
    public void function OnRequest(required string TargetPage){
        //Handle OnRequest Callback
    }
    public boolean function OnRequestStart(required string TargetPage){
        //Handle OnRequestStart Callback
        include arguments.TargetPage;                           
        return true;
    }
    public void function OnRequestEnd(){
        //Handle OnRequestEnd Callback
    }
    public void function OnCFCRequest(string cfc, string method, struct args){
        //Handle OnCFCRequest Callback
    }
    public void function OnSessionStart(){
        
        //Handle OnSessionStart Callback
    }
    public void function OnSessionEnd(required struct SessionScope, struct ApplicationScope=structNew()){
        //Handle OnSessionEnd Callback
    }
    
    public boolean function OnMissingTemplate(required string TargetPage){
        //Handle OnMissingTemplate Callback
        return true;
    }
    
}