<cfoutput>
    Page is missing: #request['javax.servlet.error.request_uri']#
    <cfheader statuscode="404">
</cfoutput>