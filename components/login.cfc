component name="login" output="true"{

    remote function get(string username, string password) {
        var saltTheHash = "tooManyTires";
    	var hashedPassword = hash(saltTheHash & trim(arguments.password), "SHA");
        var queryLogin = new query();
        queryLogin.setSQL("select objectID, username, password, bAdmin, bActive, ratingLimitID from user where username = :username and password = :password");
        queryLogin.addParam(name="username",value=arguments.username,cfsqltype="VARCHAR");
        queryLogin.addParam(name="password",value=hashedPassword,cfsqltype="VARCHAR");
        var queryLoginResult = queryLogin.execute().getResult();
        if(queryLoginResult.recordCount > 0 && queryLoginResult.bActive == 1){
        	session.user.id = queryLoginResult.objectID;
        	session.user.username = queryLoginResult.username;
        	session.user.bAdmin = queryLoginResult.bAdmin;
        	session.user.ratingLimitID = queryLoginResult.ratingLimitID;
            return true;
        }
        else{
        	return false;
        }
    } 

}