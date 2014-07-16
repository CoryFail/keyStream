component name="login" output="true"{

    public function get(string username, string password) {
    	var arguments.password = hash(saltTheHash & trim(arguments.password), "SHA");
        var queryLogin = new query();
        querySettings.setSQL("select objectID, username, password, bAdmin, ratingLimitID from user where username = :username and password = :password");
        queryUser.addParam(name="username",value=arguments.password,cfsqltype="VARCHAR");
        queryUser.addParam(name="password",value=arguments.password,cfsqltype="VARCHAR");
        if(queryLogin.execute().getResult().recordCount > 0){
        	var loginReturn = true;
        	session.user.id = queryLogin.objectID;
        	session.user.id = queryLogin.username;
        	session.user.bAdmin = queryLogin.bAdmin;
        	session.user.ratingLimitID = queryLogin.ratingLimitID;
        }
        else{
        	var loginReturn = false;
        }
        return loginReturn;
    } 

}