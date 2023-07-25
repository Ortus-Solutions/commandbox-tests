# Multi Site with bindings

SNI (Server Name Indication) is the ability to have more than on SSL cert configured for a single SSL binding (IP/Port) and for the server to automatically select the correct SSL cert to use based on the incoming host header of the request.  CommandBox will scan the subject common name as well as any Subject Alternative Names (SANs) and automatically register which hostnames each cert applies to.  Wildcard certs are also handled.

Run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.

## Setup

Add host file entires for

- site1.com
- site2.com
- site3.com

For this test, define default settings in the `web` block and 3 `sites` in the `server.json`.

- site1 with `sites.site1.hostAlias=site1.com`
- site2 with `sites.site2.hostAlias=site2.com`
- site3 no host alias

Create the following top level bindings (will be shared by all sites)

- legacy `web.HTTP` binding on port 80
- legacy `web.SSL` binding on port 443
- legacy `web.AJP` binding on port 8009 with a unique AJP secret
- modern `binding.http` binding on port 8080
- modern `binding.ssl` binding on port 8443
- modern `binding.ajp` binding on port 16009 with a unique AJP secret

Create the following site-specific bindings

- legacy `sites.sites1.http` binding on port 81
- legacy `sites.sites1.ssl` binding on port 444
- legacy `sites.sites1.ajp` binding on port 8010 with a unique AJP secret
- Two modern `sites.site2.binding.http` bindings on ports 80 and 82
- modern `sites.site2.binding.ssl` binding on port 446
- modern `sites.site2.binding.ajp` binding on port 8011 with a unique AJP secret

## Tests

The following URLs SHOULD match to the following sites

- http://site1.com:80 - site1
- http://site1.com:8080 - site1
- http://site1.com:81 - site1
- http://site1.com:82 - site not found 404
- https://site1.com:443 - site1
- https://site1.com:8443 - site1
- https://site1.com:444 - site1
- https://site1.com:446 - site not found 404
- http://site1.com:8084 -> ajp://site1.com:8009 - site1
- http://site1.com:8082 -> ajp://site1.com:16009 - site1
- http://site1.com:8081 -> ajp://site1.com:8010 - site1
- http://site1.com:8083 -> ajp://site1.com:8011 - site not found 404

- http://site2.com:80 - site2
- http://site2.com:8080 - site2
- http://site2.com:81 - site not found 404
- http://site2.com:82 - site2
- https://site2.com:443 - site2
- https://site2.com:8443 - site2
- https://site2.com:444 - site not found 404
- https://site2.com:446 - site2
- http://site2.com:8084 -> ajp://site2.com:8009 - site2
- http://site2.com:8082 -> ajp://site2.com:16009 - site2
- http://site2.com:8081 -> ajp://site2.com:8010 - site not found 404
- http://site2.com:8083 -> ajp://site2.com:8011 - site2

- http://site3.com:80 - site3
- http://site3.com:8080 - site3
- http://site3.com:81 - site not found 404
- http://site3.com:82 - site not found 404
- https://site3.com:443 - site3
- https://site3.com:8443 - site3
- https://site3.com:444 - site not found 404
- https://site3.com:446 - site not found 404
- http://site3.com:8084 -> ajp://site3.com:8009 - site3
- http://site3.com:8082 -> ajp://site3.com:16009 - site3
- http://site3.com:8081 -> ajp://site3.com:8010 - site not found 404
- http://site3.com:8083 -> ajp://site3.com:8011 - site not found 404
