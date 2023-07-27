component extends="../../../BaseTest" {

	function beforeAll() {
		try {
			sslcertificateinstall( 'site1.com' )
		} catch( any e ) {
			systemOutput( e.message, 1 )
		}
		super.beforeAll();
		HTTPparams = {
			clientcert : fileSystemUtil.resolvePath('../../../certs/localtestclientcert.pfx', getDirectoryFromPath( getCurrentTemplatePath() ) ),
			clientcertpassword : "test"
		};
	}

	function run(){

		describe( "Client Cert Auth", function(){

			it( "Home page", function(){
				http url='https://site1.com/' attributeCollection=HTTPparams throwOnError=true;
				success( cfhttp, 'client cert auth' )
			});

			it( "public page", function(){
				http url='https://site1.com/public' attributeCollection=HTTPparams throwOnError=true;
				success( cfhttp, 'client cert auth this is public' )
			});

			it( "Secret page no auth", function(){
				// This fails because the auth predicate asks for a cert with a different common name than we have
				http url='https://site1.com/secret' attributeCollection=HTTPparams;
				error( cfhttp, 403 )
			});

		});
	}

}

