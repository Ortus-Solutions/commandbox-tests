# Custom SSL Cert

This tests the basic legacy behavior of starting a single site server with a custom SSL cert configured

## Matrix

We need to test each of each of these items:

- .pfx cert with password
- .cer cert file and key file with password

## Tests

- https://site1.com/ should return 200 status code
