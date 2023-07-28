component extends="../../../BaseTest" {

	function run(){

		describe( "Wildcard Bindings Sensitivity", function(){

			it( "site1.com", function(){
				http url='http://site1.com';
				success( cfhttp, 'Site 1' )
			});

			it( "site1.net", function(){
				http url='http://site1.net';
				success( cfhttp, 'Site 1' )
			});

			it( "www.site1.net", function(){
				http url='http://www.site1.com';
				success( cfhttp, 'Site 1' )
			});

			it( "admin.site1.net", function(){
				http url='http://admin.site1.com';
				success( cfhttp, 'Site 1' )
			});

			it( "site5.net", function(){
				http url='http://site5.com';
				success( cfhttp, 'Site 1' )
			});

			it( "site15.net", function(){
				http url='http://site15.com';
				error( cfhttp, 404, 'site not found' )
			});

		});
	}

}

