component extends="../../../BaseTest" {

	function run(){

		describe( "Multi-Site Basic", function(){

			describe( "Site 1", function(){

				it( "home page", function(){
					http url='http://site1.com/';
					success( cfhttp, 'Site1 home page' )
				});

				it( "js/scripts.js", function(){
					http url='http://site1.com/js/scripts.js';
					success( cfhttp, 'Global JS file' )
					expect( cfhttp.responseHeader ).notToHaveKey( 'Content-Encoding' )
				});

				it( "downloads/file.txt", function(){
					http url='http://site1.com/downloads/file.txt';
					success( cfhttp, 'file' )
					// CFHTTP removes this header!
					//expect( cfhttp.responseHeader['Content-Encoding'] ?: '' ).toBe( 'gzip', cfhttp.responseHeader.keyList() )
				});

				it( "missing file handler", function(){
					http url='http://site1.com/not-found';
					error( cfhttp, 404, 'Site 1 Page is missing: /not-found' )
				});

				it( "access log", function(){
					var serverInfo = application.wirebox.getInstance('serverService').getServerInfoByName( 'commandbox-test-multi-site-basic' );
					expect( serverInfo.sites.site1.accessLogPath ).notToBeEmpty();
					expect( fileExists( serverInfo.sites.site1.accessLogPath ) ).toBeTrue();
					expect( fileRead( serverInfo.sites.site1.accessLogPath ) ).notToBeEmpty();
				});

				it( "tea", function(){
					http url='http://site1.com/tea';
					error( cfhttp, 418 )
				});

				it( "boom", function(){
					http url='http://site1.com/boom';
					error( cfhttp, 500 )
				});

				it( "test.log", function(){
					http url='http://site1.com/test.log';
					success( cfhttp, 'This is the test log' )
					expect( cfhttp.responseHeader[ 'content-type' ] ).toBe( 'text/plain' )
				});

				it( "disallowed-extension.foo", function(){
					http url='http://site1.com/disallowed-extension.foo';
					error( cfhttp, 403 )
				});

				it( "downloads directory listing", function(){
					http url='http://site1.com/downloads/';

					if( systemSettings.getSystemSetting( 'box_server_profile', '' ) ==  'production' ) {
						error( cfhttp, 403 )
					} else {
						success( cfhttp, 'Directory Listing' )
					}
				});

				it( "CF Admin", function(){
					var adminURL = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? '/CFIDE/administrator/enter.cfm' : '/lucee/admin/server.cfm';
					var adminText = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? 'ColdFusion Administrator' : 'Lucee Server Administrator';
					http url='http://site1.com#adminURL#';

					if( systemSettings.getSystemSetting( 'box_server_profile', '' ) ==  'production' ) {
						error( cfhttp, 404 )
					} else {
						success( cfhttp, adminText )
					}
				});

				it( "server.json", function(){
					http url='http://site1.com/server.json';
					error( cfhttp, 404, 'Site 1 Page is missing: /server.json' )
				});

			});

			describe( "Site 2", function(){

				it( "home page", function(){
					http url='http://site2.com/';
					success( cfhttp, 'site2 home page' )
				});

				it( "js/scripts.js", function(){
					http url='http://site2.com/js/scripts.js';
					success( cfhttp, 'JS file for site 2' )
					expect( cfhttp.responseHeader ).notToHaveKey( 'Content-Encoding' )
				});

				it( "downloads/file.txt", function(){
					http url='http://site2.com/downloads/file.txt';
					success( cfhttp, 'file' )
					// CFHTTP removes this header!
					//expect( cfhttp.responseHeader['Content-Encoding'] ?: '' ).toBe( 'gzip', cfhttp.responseHeader.keyList() )
				});

				it( "missing file handler", function(){
					http url='http://site2.com/not-found';
					error( cfhttp, 404, 'Site 2 Page is missing: /not-found' )
				});

				it( "access log", function(){
					var serverInfo = application.wirebox.getInstance('serverService').getServerInfoByName( 'commandbox-test-multi-site-basic' );
					expect( serverInfo.sites.site2.accessLogPath ).notToBeEmpty();
					expect( fileExists( serverInfo.sites.site2.accessLogPath ) ).toBeFalse();
				});

				it( "tea", function(){
					http url='http://site2.com/tea';
					error( cfhttp, 418 )
				});

				it( "boom", function(){
					http url='http://site2.com/boom';
					error( cfhttp, 500 )
				});

				it( "test.log", function(){
					http url='http://site2.com/test.log';
					error( cfhttp, 403 )
				});

				it( "test.log2", function(){
					http url='http://site2.com/test.log2';
					success( cfhttp, '<root>This is the test log2</root>' )
					expect( cfhttp.responseHeader[ 'content-type' ] ).toBe( 'application/xml' )
				});

				it( "disallowed-extension.foo", function(){
					http url='http://site2.com/disallowed-extension.foo';
					error( cfhttp, 403 )
				});

				it( "downloads directory listing", function(){
					http url='http://site2.com/downloads/';
					success( cfhttp, 'Directory Listing' )
				});

				it( "CF Admin", function(){
					var adminURL = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? '/CFIDE/administrator/enter.cfm' : '/lucee/admin/server.cfm';
					http url='http://site2.com#adminURL#';
					error( cfhttp, 404, 'Site 2 Page is missing:' )
				});

				it( "server.json", function(){
					http url='http://site2.com/server.json';
					error( cfhttp, 404, 'Site 2 Page is missing: /server.json' )
				});

			});

			describe( "Site 3", function(){

				it( "home page", function(){
					http url='http://site3.com/';
					success( cfhttp, 'site3 main' )
				});

				it( "js/scripts.js", function(){
					http url='http://site3.com/js/scripts.js';
					success( cfhttp, '// Global JS file' )
				});

				it( "js-brad/scripts.js", function(){
					http url='http://site3.com/js-brad/scripts.js';
					success( cfhttp, '// JS file for site 3' )
				});

				it( "missing file handler", function(){
					http url='http://site3.com/not-found';
					success( cfhttp, 'Site 3 Page is missing: /not-found' )
				});

				it( "access log", function(){
					var serverInfo = application.wirebox.getInstance('serverService').getServerInfoByName( 'commandbox-test-multi-site-basic' );
					expect( serverInfo.sites.site3.accessLogPath ).notToBeEmpty();
					expect( fileExists( serverInfo.sites.site3.accessLogPath ) ).toBeTrue();
					expect( fileRead( serverInfo.sites.site3.accessLogPath ) ).notToBeEmpty();
				});

				it( "tea", function(){
					http url='http://site3.com/tea';
					error( cfhttp, 418 )
				});

				it( "boom", function(){
					http url='http://site3.com/boom';
					error( cfhttp, 500 )
				});

				it( "downloads directory listing", function(){
					http url='http://site3.com/downloads/';
					error( cfhttp, 403 )
				});

				it( "CF Admin", function(){
					var adminURL = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? '/CFIDE/administrator/enter.cfm' : '/lucee/admin/server.cfm';
					var adminText = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? 'ColdFusion Administrator' : 'Lucee Server Administrator';

					http url='http://site3.com#adminURL#';
					success( cfhttp, adminText )
				});

				it( "server.json", function(){
					http url='http://site3.com/server.json';
					success( cfhttp, 'Site 3 Page is missing: /server.json' )
				});

			});

			describe( "Site 4", function(){

				it( "home page", function(){
					http url='http://siteMissing.com/';
					success( cfhttp, 'Dude, where''s my site?' )
				});

				it( "home page index.cfm", function(){
					http url='http://siteMissing.com/index.cfm';
					success( cfhttp, 'Dude, where''s my site?' )
				});

				it( "boom", function(){
					http url='http://siteMissing.com/boom';
					success( cfhttp, 'Dude, where''s my site?' )
				});

				it( "CF Admin", function(){
					var adminURL = systemSettings.getSystemSetting( 'box_server_app_cfengine', 'lucee' ) contains 'adobe' ? '/CFIDE/administrator/enter.cfm' : '/lucee/admin/server.cfm';

					http url='http://siteMissing.com#adminURL#';
					success( cfhttp, 'Dude, where''s my site?' )
				});

				it( "tea", function(){
					http url='http://siteMissing.com/tea';
					success( cfhttp, 'Dude, where''s my site?' )
				});

			});

		});
	}

}

