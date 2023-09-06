# Tuckey Legacy

Use Legacy Tuckey rewrites.  This requires short-circuiting the new ResourceHandler and sending all static files to the servlet.  It also means you don't get the new error pages.

## Tests

- http://tuckeylegacy.com // 200 OK
- http://tuckeylegacy.com/hidden/ - My Tuckey 404 page
- http://tuckeylegacy.com/hidden/foo.txt - My Tuckey 404 page
- http://tuckeylegacy.com/hidden/blah - My Tuckey 404 page