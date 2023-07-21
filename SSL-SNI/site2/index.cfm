Site 2
<!--- Assumes using Lucee and FusionReactor --->
<cfdump var="#getPageContext().getRequest().getOriginalRequest().getRequest().getExchange().getConnection().getSslSessionInfo().getSSLSession().getLocalCertificates()[1].getSubjectDN().toString()#">