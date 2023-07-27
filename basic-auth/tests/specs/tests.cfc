component extends="../../../BaseTest" {

	function run(){

		describe( "Basic Auth", function(){

			it( "Home page", function(){
				http url='http://site1.com/';
				success( cfhttp, 'basic auth' )
			});

			it( "public page", function(){
				http url='http://site1.com/public';
				success( cfhttp, 'basic auth this is public' )
			});

			it( "Secret page no auth", function(){
				http url='http://site1.com/secret';
				error( cfhttp, 401 )
				expect( cfhttp.responseheader ).toHaveKey( 'WWW-Authenticate' )
				expect( cfhttp.responseheader[ 'WWW-Authenticate' ] ).toInclude( 'Basic' )
			});

			it( "Secret page with auth", function(){
				http url='http://site1.com/secret' username="brad" password="wood";
				success( cfhttp, 'basic auth  this is secret' )
			});


		});
	}

}

