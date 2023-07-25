# Case Sensitivity

Test the forced case sensitivity of the web server. Create different text files in the web root with various spellings for testing.
To test this correctly, we really need to test the forced case insensitity on a case sensitive file system and test the case sensitivity on a case insensitive file system.

## Setup

Test both combinations of settings

- `web.caseSensitivePaths` enabled
- `web.caseSensitivePaths` disabled

## Tests

- http://site1.com:65384/bradWOOD.txt should always return "bradWOOD"
- http://site1.com:65384/bradwood.txt should return 404 when case sensitivity is on
- http://site1.com:65384/bradwood.txt should return "bradWOOD" when case sensitivity is off

