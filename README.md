# Commandbox Tests

A repo of tests suites for CommandBox.  The sites are already built out and are contained in subfolders.  In most cases, you just need to `cd` to a folder and run `server start`.  For any examples using AJP, you'll also need to run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.  This assumes you have Docker installed.

These tests require the latest version of CommandBox 6.0 and assume you've installed the `commandbox-hostupdater` to help create all the `hosts` file entries while testing.

## Single Site

[Test Files](single-site)

This basic tests, hits all the core features of CommandBox servers across Lucee, Adobe, and production vs development profiles.

## Custom SSL Cert

[Test Files](custom-SSL-cert)

This tests the basic legacy behavior of starting a single site server with a custom SSL cert configured

## Basic Auth

[Test Files](basic-auth)

Test the basic legacy behavior of starting a single site server with basic auth and an auth predicate configured.

## Client Cert Auth

[Test Files](client-cert-auth)

Test the basic legacy behavior of starting a single site server with client cert auth and an auth predicate configured.

## Case Sensitivity

[Test Files](case-sensitivity)

Test the forced case sensitivity or forced case INsensitivity of the web server.

## ModCFML

[Test Files](modCFML)

Test ModCFML integration to have more than one web root inside a single CommandBox server.  We're testing with Apache, but the CommandBox portions work the same whether you are using Nginx, Apache, or IIS.

## Multi Site Basic

[Test Files](multi-site-basic)

This test hits all the basic multi-site features of CommandBox by configuring multuple websites, each with different bindings and settings.

## Multi Site with `.site.json` files found by web root convention

[Test Files](multi-site-json-webroot-convention)

This test hits all the same settings as `Multi Site Basic` above, but instead of configuring everthing in a single `server.json` file, it breaks the settings into `.site.json` files in the web root of each site.

## Multi Site with explicit `siteConfigFile`

[Test Files](multi-site-siteConfigFile)

This test hits all the same settings as `Multi Site with web root convention` above, but instead of finding the site JSON files by convention in the web root, it breaks the settings into JSON files stored in a directory outside the web roots in the web root of each site.


## Multi Site with `siteConfigFiles` file glob pattern

[Test Files](multi-site-siteConfigFiles-globbing)

This test hits all the same settings as `Multi Site with explicit siteConfigFile` above, but instead specifying each site JSON file explicitily, it uses a file globbing pattern to simply load all the JSON files in a directory.

## Multi Site with default site

[Test Files](multi-site-default-site)

Test the ability to set a default site in multi-site mode, as well as what happens when there is no matched binding with no default site set.

## Multi Site with bindings

[Test Files](multi-site-bindings)

Test all the possible ways bindings can be set. Run `server run-script ajp-up` to startup the Apache AJP proxy in Docker and then run `server run-script ajp-down` when finished to stop it.

## Multi Site with Wildcard bindings

[Test Files](multi-site-wildcard-bindings)

Test all the possible ways hostnames can be bound with wildcards

## SSL SNI

[Test Files](SSL-SNI)

SNI (Server Name Indication) is the ability to have more than on SSL cert configured for a single SSL binding (IP/Port) and for the server to automatically select the correct SSL cert to use based on the incoming host header of the request.  CommandBox will scan the subject common name as well as any Subject Alternative Names (SANs) and automatically register which hostnames each cert applies to.  Wildcard certs are also handled.