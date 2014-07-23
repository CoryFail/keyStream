component name="settings" output="true"{

    public function get() {
        var querySettings = new query();
        querySettings.setSQL("
            select videoPath, defaultRatingID, currentVersion from settings
        ");
        return application.utils.queryToArray(querySettings.execute().getResult());
    }

    public function put(
	        string videoPath = get()[1].videoPath,
	        numeric defaultRatingID = get()[1].defaultRatingID,
	        string currentVersion = get()[1].currentVersion
    	){
        var querySettings = new query();
        querySettings.setSQL("
            update settings set videoPath = :videoPath, defaultRatingID = :defaultRatingID, currentVersion = :currentVersion
        ");
        querySettings.addParam(name="videoPath",value=arguments.videoPath,cfsqltype="VARCHAR");
        querySettings.addParam(name="defaultRatingID",value=arguments.defaultRatingID,cfsqltype="INT");
        querySettings.addParam(name="currentVersion",value=arguments.currentVersion,cfsqltype="VARCHAR");
        return querySettings.execute().getResult();
    }

}