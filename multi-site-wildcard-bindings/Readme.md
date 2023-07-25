# Multi Site with Wildcard bindings

Test all the possible ways hostnames can be bound, including exact match, starts-with wildcard, ends-with wildcard, and regex matching of host name.

## Setup

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

## Tests

The following URLs SHOULD match to the following sites

- http://site1.com - site1
- http://site1.net - site1
- http://www.site1.com - site1
- http://admin.site1.com - site1
- http://site5.com - site1
- http://site15.com - site not found 404
