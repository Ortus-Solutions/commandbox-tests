component extends="../../../BaseTest" {

	function run(){

		describe( "Single Site", function(){

			// Can't connect to SSL on Java 8 for some reason.  Prolly a mismatch in ciphers or TLS versions.
			it( title="SSL Listener", skip=application.wirebox.getInstance( 'systemSettings' ).getSystemSetting( 'box_server_jvm_javaVersion', '' ) ==  'openjdk8', body=function(){
				try {
					sslcertificateinstall( 'singlesite.com' )
				} catch( any e ) {
					systemOutput( e.message, 1 )
				}
				http url='https://127.0.0.1/' throwOnError=true;
				success( cfhttp, 'home page' )
			});

			it( "HTTP Listener", function(){
				http url='http://singlesite.com/';
				success( cfhttp, 'home page' )
			});

			it( "AJP Listener", function(){
				http url='http://singlesite.com:8080/';
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
				if( systemSettings.getSystemSetting( 'box_server_profile', '' ) ==  'production' ) {
					error( cfhttp, 403 )
				} else {
					success( cfhttp, 'Directory Listing' )
				}
			});

			it( "Admin URL", function(){
				var adminURL = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? '/CFIDE/administrator/enter.cfm' : '/lucee/admin/server.cfm';
				var adminText = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? 'ColdFusion Administrator' : 'Lucee Server Administrator';

				http url='http://singlesite.com#adminURL#';
				if( systemSettings.getSystemSetting( 'box_server_profile', '' ) == 'production' ) {
					error( cfhttp, 404 )
				} else {
					success( cfhttp, adminText )
				}
			});

			it( "sensitive path", function(){
				http url='http://singlesite.com/server.json';
				error( cfhttp, 404, 'Page is missing: /server.json' )
			});

			it( "is right CF engine", function(){
				var CFEngineVar = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' );
				var engine = CFEngineVar.listFirst( '@' );
				var version = CFEngineVar.listLen( '@' )>1 ? CFEngineVar.listLast( '@' ) : '';
				http url='http://singlesite.com/echo.cfm';
				success( cfhttp, engine )
				success( cfhttp, version )
			});

		});
	}

}

