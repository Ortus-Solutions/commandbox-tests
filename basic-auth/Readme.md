# Basic Auth

Test the basic legacy behavior of starting a single site server with basic auth and an auth predicate configured.

## Tests

- http://site1.com/ // accessible
- http://site1.com/public // accessible
- http://site1.com/secret // prompts login