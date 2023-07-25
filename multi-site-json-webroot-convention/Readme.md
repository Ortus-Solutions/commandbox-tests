# Multi Site with `.site.json` files found by web root convention

This test is the same as the `Multi Site Basic` test, but all the site-specific settings have been moved out of the `server.json` except the web root of each site. The site-specific settings have been placed in a `.site.json` file in each web root. Note, it was necessary to edit the relative virtual directory path to now be relative to the webroot (which is the folder the `.site.json` file lives in). All the same tests for `Multi Site Basic` should work here with the same results.

## Tests

Same as [Multi Site Basic](../multi-site-basic/Readme.md)