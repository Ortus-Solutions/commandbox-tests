# Client Cert Auth

Test the basic legacy behavior of starting a single site server with client cert auth and an auth predicate configured.  You will need to install the client cert [certs\localtestclientcert.cer](certs\localtestclientcert.cer) into your computer's personal key store so your browser will prompt you to choose it when visiting the site.

## Setup

Test both of these scenarios.

- One or more trust CA cert files
- A trust store file with password

## Tests

- https://site1.com/ returns "client cert auth this is public"
- https://site1.com/public returns "client cert auth this is public"
- https://site1.com/secret returns 403 status code