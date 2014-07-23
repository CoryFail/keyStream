component name="update" output="true"{

    public function connect(){
        // try and ctach this to determine internet connection
        try{
            http method="GET" url="http://keystream.co/remote/versionOutput.xml" result="updateXML" timeout="3";
            var parse = xmlParse(updateXML.filecontent);
            return parse.xmlRoot.xmlChildren[1].xmlChildren;
        }
         catch(any e){
            return false;
        }
    }

    remote function get(){
        try{
            if(StructKeyExists(connect()[1], 1)){
                application.update.internetAccess = true;
                application.update.version = connect()[1].xmlText;
                application.update.downloadURL = connect()[2].xmlText;
                application.update.description = connect()[3].xmlText;
            }
        }
        catch(any e){
            application.update.internetAccess = false;
            application.update.version = application.settings.currentVersion;
            application.update.downloadURL = "N/A";
            application.update.description = "No updates available.";
        }
        return application.update.internetAccess;
    }

    remote function delete(){
        application.update.internetAccess = false;
        application.update.version = application.settings.currentVersion;
        application.update.downloadURL = "N/A";
        application.update.description = "No updates available.";
        return true;
    }

}