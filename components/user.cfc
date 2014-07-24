component name="user" output="true"{

    public function get(numeric objectid = 0) {
        var queryUser = new query();
        var hasParams = arguments.objectid > 0;
        var sql = "select objectID, username, password, bAdmin, ratingLimitID, bActive from user";
        if(hasParams){
            sql = sql & " where objectid = :objectid";
        }
        queryUser.setSQL(sql);
        if(hasParams){
            queryUser.addParam(name="objectid",value=arguments.objectid,cfsqltype="INT");
        }
        return application.utils.queryToArray(queryUser.execute().getResult());
    }

    public function put(
        numeric objectid, 
        string username = get(arguments.objectid)[1].username,
        string password = get(arguments.objectid)[1].password,
        numeric bAdmin = get(arguments.objectid)[1].bAdmin,
        numeric bActive = get(arguments.objectid)[1].bActive,
        numeric ratingLimitID = get(arguments.objectid)[1].ratingLimitID
    ){
        if(arguments.password NEQ get(arguments.objectid)[1].password){
            var saltTheHash = "tooManyTires";
            var hashedPassword = hash(saltTheHash & trim(arguments.password), "SHA");
        }
        else{
            var hashedPassword = arguments.password;
        }
        var queryUser = new query();
        queryUser.setSQL("update user set username = :username, password = :password, bAdmin = :bAdmin, bActive = :bActive, ratingLimitID = :ratingLimitID where objectid = :objectid");
        queryUser.addParam(name="objectid",value=arguments.objectid,cfsqltype="INT");
        queryUser.addParam(name="username",value=arguments.username,cfsqltype="VARCHAR");
        queryUser.addParam(name="password",value=hashedPassword,cfsqltype="VARCHAR");
        queryUser.addParam(name="bAdmin",value=arguments.bAdmin,cfsqltype="INT");
        queryUser.addParam(name="bActive",value=arguments.bActive,cfsqltype="INT");
        queryUser.addParam(name="ratingLimitID",value=arguments.ratingLimitID,cfsqltype="INT");
        return queryUser.execute().getResult();
    }

    public function post(
        string username, string password, numeric bAdmin, numeric ratingLimitID
    ) {
        var saltTheHash = "tooManyTires";
        var hashedPassword = hash(saltTheHash & trim(arguments.password), "SHA");
        var queryUser = new query();
        queryUser.setSQL("insert into user (username, password, bAdmin, ratingLimitID) values (:username, :password, :bAdmin, :ratingLimitID)");
        queryUser.addParam(name="username",value=arguments.username,cfsqltype="VARCHAR");
        queryUser.addParam(name="password",value=hashedPassword,cfsqltype="VARCHAR");
        queryUser.addParam(name="bAdmin",value=arguments.bAdmin,cfsqltype="INT");
        queryUser.addParam(name="ratingLimitID",value=arguments.ratingLimitID,cfsqltype="INT");
        return queryUser.execute().getResult();
    }

    public function delete(numeric objectid) {
        var queryUser = new query();
        queryUser.setSQL("delete user where objectid = :objectID");
        queryUser.addParam(name="objectid",value=arguments.objectid,cfsqltype="INT");
        return queryUser.execute().getResult();
    }

}