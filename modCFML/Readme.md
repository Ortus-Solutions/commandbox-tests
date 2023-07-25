# ModCFML

[Test Files](modCFML)

Test ModCFML integration.  Run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.

## Matrix

We need every combination of each of these items

- Lucee CF Engine
- Adobe CF Engine

Turn on `modCFML.enable` flag and ModCFML secret and AJP on port 8009.

Set up Apache

- To proxy to CommandBox AJP port
- To use ModCFML secret
- Create 3 Apache virtual hosts pointing to 3 web roots

## Tests

- http://site1.com:8080/ returns "Site 1"
- http://site1.com:8080/static.txt returns "site1 static file"
- http://site2.com:8080/ returns "Site 2"
- http://site2.com:8080/static.txt returns "site2 static file"
- http://site3.com:8080/ returns "Site 3"
- http://site3.com:8080/static.txt returns "site3 static file"
