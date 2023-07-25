# Multi Site with default site

Test the ability to set a default site in multi-site mode, as well as what happens when there is no matched binding with no default site set.

## Setup

We need every combination of each of these items

- One site tagged as `default`
- No `default` site

For this test, define default settings in the `web` block and 3 `sites` in the `server.json`. Each site needs at least one `hostAlias`. Declare a top level HTTP binding that all sites share

- site1
- site2
- site3

Hit site on domain not bound and ensure 404 "site not found" is displayed when there is no default and then ensure the default site is used when one is set.

## Tests

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


