component extends="../../../BaseTest" {

	function run(){

		describe( "Custom SSL Cert", function(){

			it( "SSL Listener", function(){
				try {
					sslcertificateinstall( 'site1.com' )
				} catch( any e ) {
					systemOutput( e.message, 1 )
				}
				http url='https://site1.com/' throwOnError=true;
				success( cfhttp, 'home page' )
			});

		});
	}

}

