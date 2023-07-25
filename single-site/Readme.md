# Single Site

Test all of the server functions of CommandBox

## Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine
- Production profile
- Development profile

## Setup

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

## Tests:
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
