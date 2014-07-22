<CFSCRIPT>
    http method="GET" url="http://keystream.co/remote/versionOutput.xml" result="webPage";
    parse = xmlParse(webPage.filecontent);
    writedump(parse.xmlRoot.xmlChildren[1].xmlChildren);
</CFSCRIPT>