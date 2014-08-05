component name="search" output="true"{

    remote function username(string username){
        var queryUser = new query();
        var sql = "select objectID, username from user where username = :username";
        queryUser.setSQL(sql);
        queryUser.addParam(name="username",value=arguments.username,cfsqltype="VARCHAR");
        var queryUserResult = queryUser.execute().getResult();
        if(queryUserResult.recordCount > 0){
            return true;
        }
        else{
            return false;
        }
    }

}