component extends="testbox.system.BaseSpec"{

	function run(){

		describe( "Single Site", function(){

			it( "SSL Listener", function(){
				sslcertificateinstall( 'singlesite.com' )
				http url='https://127.0.0.1/' throwOnError=true;
				success( cfhttp, 'home page' )
			});

			it( "HTTP Listener", function(){
				http url='http://singlesite.com/';
				success( cfhttp, 'home page' )
			});

			it( "GZip disabled", function(){
				http url='http://singlesite.com/js/scripts.js';
				success( cfhttp, 'JS file' )
				expect( cfhttp.responseHeader ).notToHaveKey( 'Content-Encoding' )
			});

			it( "GZip enabled", function(){
				http url='http://singlesite.com/downloads/file.txt';
				success( cfhttp, 'file' )
				// CFHTTP removes this header!
				//expect( cfhttp.responseHeader['Content-Encoding'] ?: '' ).toBe( 'gzip', cfhttp.responseHeader.keyList() )
			});

			it( "missing file handler", function(){
				http url='http://singlesite.com/not-found';
				error( cfhttp, 404, 'Page is missing: /not-found' )
			});

			it( "access log", function(){
				var serverInfo = application.wirebox.getInstance('serverService').getServerInfoByName( 'commandbox-test-single-site' );
				expect( serverInfo.accessLogPath ).notToBeEmpty();
				expect( fileExists( serverInfo.accessLogPath ) ).toBeTrue();
				expect( fileRead( serverInfo.accessLogPath ) ).notToBeEmpty();
			});

			it( "custom default error page", function(){
				http url='http://singlesite.com/tea';
				error( cfhttp, 418 )
			});

			it( "custom 500 error page", function(){
				http url='http://singlesite.com/boom';
				error( cfhttp, 500 )
			});

			it( "custom mime type and allowed static extension", function(){
				http url='http://singlesite.com/test.log';
				success( cfhttp, 'This is the test log' )
				expect( cfhttp.responseHeader['content-type'] ?: '' ).toBe( 'text/plain' )
			});

			it( "disallowed extension", function(){
				http url='http://singlesite.com/disallowed-extension.foo';
				error( cfhttp, 403 )
			});

			it( "directory listing", function(){
				http url='http://singlesite.com/downloads/';
				if( request.__server_profile == 'production' ) {
					error( cfhttp, 403 )
				} else {
					success( cfhttp, 'Directory Listing' )
				}
			});

			it( "Admin URL", function(){
				http url='http://singlesite.com/lucee/admin/server.cfm';
				if( request.__server_profile == 'production' ) {
					error( cfhttp, 404 )
				} else {
					success( cfhttp, 'Lucee Server Administrator' )
				}
			});

			it( "sensitive path", function(){
				http url='http://singlesite.com/server.json';
				error( cfhttp, 404, 'Page is missing: /server.json' )
			});

		});
	}

	function success( cfhttp, content='' ) {
		expect( cfhttp.status_code ).toBe( 200 )
		if( len( content ) ) {
			expect( cfhttp.fileContent ).toInclude( content )
		}
	}
	function error( cfhttp, status, content='' ) {
		expect( cfhttp.status_code ).toBe( status )
		if( len( content ) ) {
			expect( cfhttp.fileContent ).toInclude( content )
		}
	}
}

