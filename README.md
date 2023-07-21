# Commandbox Tests

A repo of tests suites for CommandBox.  The sites are already built out and are contained in subfolders.  In most cases, you just need to `cd` to a folder and run `server start`.  For any examples using AJP, you'll also need to run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.  This assumes you have Docker installed.

These tests require the latest version of CommandBox 6.0 and assume you've installed the `commandbox-hostupdater` to help create all the `hosts` file entries while testing.

## Single Site

[Test Files](single-site)

Test all of the server functions of CommandBox

### Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine
- Production profile
- Development profile

Test the basic legacy behavior of starting a single site server

- Single server.json file
- HTTP binding
- SSL Binding (default auto-gen cert)
- AJP binding with AJP secret
- At least one virtual directory defined
- GZip predicate
- custom error page (404.cfm)
- access log enabled
- at least one custom server rule
- at least one custom MIME type (.log -> text/plain)
- custom welcome files (custom.cfm,index.cfm)
- At least one allowed extension (.log)
- at least one custom static file extension (.log)

Tests:
- https://singlesite.com/ returns "home page"
- http://singlesite.com/ returns "home page"
- http://singlesite.com/js/scripts.js returns "JS file" with NO content-encoding header
- http://singlesite.com/downloads/file.txt should have `Content-Encoding: gzip` response header
- http://singlesite.com/not-found should return `Page is missing: /not-found` and 404 status code
- `server info property=accessLogPath` should exist and have contents
- http://singlesite.com/tea should return 418 status code
- http://singlesite.com/boom should return 500 status code
- http://singlesite.com/test.log should return `content-type: text/plain` and text "This is the test log"
- http://singlesite.com/disallowed-extension.foo should return 403 status code
- http://singlesite.com/downloads/ returns 200 and directory listing in development profile, 401 in production profile
- http://singlesite.com/lucee/admin/server.cfm returns 200 and Lucee admin in devlopment profile, 404 in production profile
- http://singlesite.com/server.json should return `Page is missing: /server.json` and 404 status code

Run `server run-script ajp-up` and re-test al the URLs above, but on port 8080, which uses the AJP proxy. Then run `server run-script ajp-down` when finished to stop it.

## Custom SSL Cert

[Test Files](custom-SSL-cert)

Test the basic legacy behavior of starting a single site server with a custom SSL cert configured

Tests
- https://site1.com/ should return 200 status code

### Matrix

We need every combination of each of these items

- .pfx cert with password
- .cer cert file and key file with password

## Basic Auth

[Test Files](basic-auth)

Test the basic legacy behavior of starting a single site server with basic auth and an auth predicate configured

- http://site1.com/ // accessible
- http://site1.com/public // accessible
- http://site1.com/secret // prompts login

## Client Cert Auth

[Test Files](client-cert-auth)

Test the basic legacy behavior of starting a single site server with client cert auth and an auth predicate configured.  You will need to install the client cert [certs\localtestclientcert.cer](certs\localtestclientcert.cer) into your computer's personal key store so your browser will prompt you to choose it when visiting the site.

### Matrix

We need every combination of each of these items

- One or more trust CA cert files
- A trust store file with password

```
/                // accessible
/public          // accessible
/secret          // requires client cert with specific issuer or subject
```

- https://site1.com/public returns "client cert auth this is public"
- https://site1.com/secret returns 403 status code

## Case Sensitivity

[Test Files](case-sensitivity)

Test the forced case sensitivity of the web server. Create different text files in the web root with various spellings for testing.
To test this correctly, we really need to test the forced case insensitity on a case sensitive file system and test the case sensitivity on a case insensitive file system.

### Matrix

We need every combination of each of these items

- `web.caseSensitivePaths` enabled
- `web.caseSensitivePaths` disabled

- http://site1.com:65384/bradWOOD.txt should always return "bradWOOD"
- http://site1.com:65384/bradwood.txt should return 404 when case sensitivity is on
- http://site1.com:65384/bradwood.txt should return "bradWOOD" when case sensitivity is off

## ModCFML

[Test Files](modCFML)

Test ModCFML integration.  Run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.

### Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine

Turn on `modCFML.enable` flag and ModCFML secret and AJP on port 8009.

Set up Apache

- To proxy to CommandBox AJP port
- To use ModCFML secret
- Create 3 Apache virtual hosts pointing to 3 web roots

Here are the tests
- http://site1.com:8080/ returns "Site 1"
- http://site1.com:8080/static.txt returns "site1 static file"
- http://site2.com:8080/ returns "Site 2"
- http://site2.com:8080/static.txt returns "site2 static file"
- http://site3.com:8080/ returns "Site 3"
- http://site3.com:8080/static.txt returns "site3 static file"

## Multi Site Basic

[Test Files](multi-site-basic)

Test the multi site features of CommandBox

### Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine
- Production profile
- Development profile

For this test, define default settings in the `web` block and 3 `sites` in the `server.json`. Each site gets its own web root and should override some settings from the default config. Each site needs at least one `hostAlias`. Declare a top level HTTP binding that all sites share

- site1
- site2
- site3

Need to verify that each setting for each site is picked up separately. Each site has its own access logs on disk that contain only its requests. Settings to configure on a per-site basis are

- rewrites enabled/disabled
- Single server.json file
- HTTP binding
- SSL Binding (default auto-gen cert)
- AJP binding (recommend including dockerFile for Apache server with basic AJP proxy)
- At least one virtual directory defined using a RELATIVE path which should be relative to the `server.json` file's containing directory.
- GZip predicate
- access log enabled
- custom error page (404.cfm)
- at least one custom server rule
- at least one custom MIME type (.log -> text/plain)
- custom welcome files (custom.cfm,index.cfm)
- At least one allowed extension (.log)
- at least one custom static file extension (.log)


Tests:
- http://site1.com/ returns "Site1 home page"
- http://site1.com/js/scripts.js returns "Global JS file" with NO content-encoding header
- http://site1.com/downloads/file.txt should have `Content-Encoding: gzip` response header
- http://site1.com/not-found should return `Site 1 Page is missing: /not-found` and 404 status code
- `server info property=sites.site1.accessLogPath` should exist and have contents
- http://site1.com/tea should return 418 status code
- http://site1.com/boom should return 500 status code
- http://site1.com/test.log should return `content-type: text/plain` and text "This is the test log"
- http://site1.com/disallowed-extension.foo should return 403 status code
- http://site1.com/downloads/ returns 200 and directory listing in development profile, 401 in production profile
- http://site1.com/lucee/admin/server.cfm returns 200 and Lucee admin in devlopment profile, 404 in production profile
- http://site1.com/server.json should return `Site 1 Page is missing: /server.json` and 404 status code
- http://site2.com/ returns "Site2 home page"
- http://site2.com/js/scripts.js returns "JS file for site 2" with NO content-encoding header
- http://site2.com/downloads/file.txt should have NO content-encoding header
- http://site2.com/not-found should return `Site 2 Page is missing: /not-found` and 404 status code
- `server info property=sites.site2.accessLogPath` should not exist
- http://site2.com/tea should return 418 status code
- http://site2.com/boom should return 500 status code
- http://site2.com/test.log should return 403
- http://site2.com/test.log2 should return `content-type: application/xml` and text `<root>This is the test log2</root>`
- http://site2.com/downloads/ returns 200 and directory listing in all profiles
- http://site2.com/lucee/admin/server.cfm returns `Site 2 Page is missing: /lucee/admin/server.cfm` in all profiles
- http://site2.com/server.json should return `Site 2 Page is missing: /server.json` and 404 status code

- http://site3.com/ returns "site3 main"
- http://site3.com/js/scripts.js returns "// Global JS file"
- http://site3.com/js-brad/scripts.js returns "// JS file for site 3"
- http://site3.com/not-found should return `Site 3 Page is missing: /not-found` and 200 status code
- `server info property=sites.site3.accessLogPath` should exist and have contents
- http://site3.com/tea should return 418 status code
- http://site3.com/boom should return 500 status code
- http://site3.com/downloads/ returns 403 in all profiles
- http://site3.com/lucee/admin/server.cfm returns 200 and Lucee admin in all profiles
- http://site3.com/server.json should return `Site 3 Page is missing: /server.json` and 404 status code

- http://siteMissing.com/ returns `Dude, where's my site?`
- http://sitemissing.com/index.cfm returns `Dude, where's my site?`
- http://sitemissing.com/boom returns `Dude, where's my site?`
- http://sitemissing.com/lucee/admin/web.cfm returns `Dude, where's my site?`
- http://sitemissing.com/tea returns `Dude, where's my site?`

## Multi Site with `.site.json` files found by web root convention

[Test Files](multi-site-json-webroot-convention)

This test is the same as the `Multi Site Basic` test, but all the site-specific settings have been moved out of the `server.json` except the web root of each site. The site-specific settings have been placed in a `.site.json` file in each web root. Note, it was necessary to edit the relative virtual directory path to now be relative to the webroot (which is the folder the `.site.json` file lives in). All the same tests for `Multi Site Basic` should work here with the same results.

## Multi Site with explicit `siteConfigFile`

[Test Files](multi-site-siteConfigFile)

This test is the same as `Multi Site Basic` test, but all the site-specific settings have been moved out of the `server.json` INCLUDING the web root of each site. The site-specific settings have been placed in `site1.json`, `site2.json`, etc files in a folder above the web roots. Note it was neccessary to edit the relative virtual directory path to be relative to the folder each `.site.json` file lives in. The `sites` block in the main `server.json` uses the `siteConfigFile` key to point to the file for each site. All the same tests for `Multi Site Basic` should work here with the same results.

## Multi Site with `siteConfigFiles` file glob pattern

[Test Files](multi-site-siteConfigFiles-globbing)

This test is the same as `Multi Site Basic` test, but all the site-specific settings have been moved out of the `server.json` INCLUDING the web root of each site. The site-specific settings have been placed in `site1.json`, `site2.json`, etc files in a `sites-available` folder above the web roots. We removed the `sites` block entirely from the main `server.json` and set a `siteConfigFiles` key with the value `sites-available/*.json`. Note it was neccessary to edit the relative virtual directory path to now be relative to the folder the site JSON files live in. All the same tests for `Multi Site Basic` should work here with the same results.

## Multi Site with default site

[Test Files](multi-site-default-site)

Test the default site

### Matrix

We need every combination of each of these items

- One site tagged as `default`
- No `default` site

For this test, define default settings in the `web` block and 3 `sites` in the `server.json`. Each site needs at least one `hostAlias`. Declare a top level HTTP binding that all sites share

- site1
- site2
- site3

Hit site on domain not bound and ensure 404 "site not found" is displayed when there is no default and then ensure the default site is used when one is set.

TESTS
```
start server.json
```
- http://site1.com/ should return "Site 1"
- http://site2.com/ should return "Site 2"
- http://site3.com/ should return "Site 3"
- http://sitemissing.com/ should return "Site 1"

```
start server-no-default.json
```
- http://site1.com/ should return "Site 1"
- http://site2.com/ should return "Site 2"
- http://site3.com/ should return "Site 3"
- http://sitemissing.com/ should return 404 "Oops! Site Not Found"



## Multi Site with bindings

[Test Files](multi-site-bindings)

Test all the possible ways bindings can be set. Run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.

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

## Multi Site with Wildcard bindings

[Test Files](multi-site-wildcard-bindings)

Test all the possible ways hostnames can be bound with wilcards

Add host file entries for

- site1.com
- www.site1.com
- admin.site1.com
- site1.net
- site5.com
- site15.com

Create 2 sites

- site1
- site2

Create the following site1 bindings

- `sites.site1.HTTP` binding on port 80

Define the following settings in an array in `sites.site1.hostAlias` in the `server.json`.

- site1.com
- site1.\*
- \*.site1.com
- ~^site[0-9]\.com$

Site 2 will have no bindings, which is fine. We only it to kick into multi-site mode so bindings are actually processed.

The following URLs SHOULD match to the following sites

- http://site1.com - site1
- http://site1.net - site1
- http://www.site1.com - site1
- http://admin.site1.com - site1
- http://site5.com - site1
- http://site15.com - site not found 404

## SSL SNI

[Test Files](SSL-SNI)

Create a server with two sites

- site1
- site2

Add the following hosts file entries

- site1.com
- www.site1.com
- site2.com
- admin.site2.com

Add the following bindings

- `sites.site1.ssl` on port 443 with `host` of `site1.com,www.site1.com` and an SSL cert with a common name of `site1.com` and a SAN of `www.site1.com`
- `sites.site2.ssl` on port 443 with `host` of `site2.com,*.site2.com` and a wildcard SSL cert with a common name of `site2.com` and a SAN of `*.site2.com`

Notes on how I generated the SSL server certs for this test. You don't need to run these commands, the test certs are already present in the `certs` folder.
```
# Generate CA cert and key
openssl req -new -newkey rsa:2048 -days 3650 -extensions v3_ca -subj "/C=US/ST=KS/L=Kansas City/O=Ortus/OU=IT/CN=Server CA/" -nodes -x509 -sha256 -set_serial 0 -keyout ServerCA.key -out ServerCA.cer

# Generate request for new site1 cert
openssl req -newkey rsa:2048 -subj "/C=US/ST=KS/L=Kansas City/O=Ortus/OU=IT/CN=site1.com/" -nodes -sha256 -keyout serverCert1-san.key -out csr.csr -config serverCert1-san.cnf

# Sign new site1 cert
openssl x509 -req -in csr.csr -CA ServerCA.cer -CAkey ServerCA.key -CAcreateserial -out ServerCert1-SAN.pem -days 3065 -sha256 -extensions v3_req -extfile serverCert1-san.cnf

# Generate request for new site1 cert
openssl req -newkey rsa:2048 -subj "/C=US/ST=KS/L=Kansas City/O=Ortus/OU=IT/CN=site2.com/" -nodes -sha256 -keyout serverCert2-san.key -out csr2.csr -config serverCert2-san.cnf

# Sign new site2 cert
openssl x509 -req -in csr2.csr -CA ServerCA.cer -CAkey ServerCA.key -CAcreateserial -out ServerCert2-SAN.pem -days 3065 -sha256 -extensions v3_req -extfile serverCert2-san.cnf
```


The following URLs should match the following sites

- https://site1.com - site1 and cert_server_subject contains `CN=site1.com`
- https://www.site1.com - site1 and cert_server_subject contains `CN=site1.com`
- https://site2.com - site2 and and cert_server_subject contains `CN=site2.com`
- https://admin.site2.com - site2 and cert_server_subject contains `CN=site2.com`
