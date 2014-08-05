component name="rating" output="true"{

    remote function get(numeric objectid = 0){
        var queryRating = new query();
        var hasParams = arguments.objectid > 0;
        var sql = "select title, objectID from rating";
        if(hasParams){
            sql = sql & " where objectid = :objectid";
        }
        queryRating.setSQL(sql);
        if(hasParams){
            queryRating.addParam(name="objectid",value=arguments.objectid,cfsqltype="INT");
        }
        return application.utils.queryToArray(queryRating.execute().getResult());
    }

}