# Multi Site Basic

Test the multi site features of CommandBox

## Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine
- Production profile
- Development profile

## Setup

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


## Tests

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

