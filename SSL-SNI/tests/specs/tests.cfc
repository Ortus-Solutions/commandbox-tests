component extends="../../../BaseTest" {

	function beforeAll() {
		try {
			sslcertificateinstall( 'site1.com' )
		} catch( any e ) {
			systemOutput( e.message, 1 )
		}
		try {
			sslcertificateinstall( 'site2.com' )
		} catch( any e ) {
			systemOutput( e.message, 1 )
		}
		super.beforeAll();
	}


	function run(){

		describe( "Wildcard Bindings Sensitivity", function(){

			it( "site1.com", function(){
				http url='https://site1.com';
				success( cfhttp, 'Site 1' )
				success( cfhttp, 'CN=site1.com' )
			});

			it( "www.site1.net", function(){
				http url='https://www.site1.com';
				success( cfhttp, 'Site 1' )
				success( cfhttp, 'CN=site1.com' )
			});

			it( "site2.com", function(){
				http url='https://site2.com';
				success( cfhttp, 'Site 2' )
				success( cfhttp, 'CN=site2.com' )
			});

			it( "admin.site2.com", function(){
				http url='https://admin.site2.com';
				success( cfhttp, 'Site 2' )
				success( cfhttp, 'CN=site2.com' )
			});

		});
	}

}

