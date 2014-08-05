component name="Utilities" output="true"{

    array function QueryToArray(required query Data){
        var LOCAL = StructNew();
        LOCAL.Columns = ListToArray( ARGUMENTS.Data.ColumnList );
        LOCAL.QueryArray = ArrayNew( 1 );
        for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE ARGUMENTS.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){
            LOCAL.Row = StructNew();
            for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){
                LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];
                LOCAL.Row[ LOCAL.ColumnName ] = ARGUMENTS.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];
            }
            ArrayAppend( LOCAL.QueryArray, LOCAL.Row );
        }
        return( LOCAL.QueryArray );
    } 

}