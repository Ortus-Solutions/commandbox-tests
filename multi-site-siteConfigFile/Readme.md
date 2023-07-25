# Multi Site with explicit `siteConfigFile`

This test is the same as `Multi Site Basic` test, but all the site-specific settings have been moved out of the `server.json` INCLUDING the web root of each site. The site-specific settings have been placed in `site1.json`, `site2.json`, etc files in a folder above the web roots. Note it was neccessary to edit the relative virtual directory path to be relative to the folder each `.site.json` file lives in. The `sites` block in the main `server.json` uses the `siteConfigFile` key to point to the file for each site. All the same tests for `Multi Site Basic` should work here with the same results.

## Tests

Same as [Multi Site Basic](../multi-site-basic/Readme.md)