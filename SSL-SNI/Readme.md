# SSL SNI

SNI (Server Name Indication) is the ability to have more than on SSL cert configured for a single SSL binding (IP/Port) and for the server to automatically select the correct SSL cert to use based on the incoming host header of the request.  CommandBox will scan the subject common name as well as any Subject Alternative Names (SANs) and automatically register which hostnames each cert applies to.  Wildcard certs are also handled.

## Setup

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


## Tests

The following URLs should match the following sites

- https://site1.com - site1 and cert_server_subject contains `CN=site1.com`
- https://www.site1.com - site1 and cert_server_subject contains `CN=site1.com`
- https://site2.com - site2 and and cert_server_subject contains `CN=site2.com`
- https://admin.site2.com - site2 and cert_server_subject contains `CN=site2.com`


## Notes

This is how I generated the SSL server certs for this test. You don't need to run these commands, the test certs are already present in the `certs` folder.
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

# Create PFX out of cert and key
openssl pkcs12 -export -out ServerCert-all-SAN.pfx -inkey ServerCert-all-SAN.key -in ServerCert-all-SAN.pem

```
