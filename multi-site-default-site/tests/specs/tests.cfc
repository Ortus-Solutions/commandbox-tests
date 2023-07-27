component extends="../../../BaseTest" {

	function run(){

		describe( "Default Site", function(){

			it( "Site 1", function(){
				http url='http://site1.com/';
				success( cfhttp, 'Site 1' )
			});

			it( "Site 2", function(){
				http url='http://site2.com/';
				success( cfhttp, 'Site 2' )
			});

			it( "Site 3", function(){
				http url='http://site3.com/';
				success( cfhttp, 'Site 3' )
			});

			it( "Site sitemissing", function(){
				http url='http://sitemissing.com/';

				if( systemSettings.getSystemSetting( 'default_site', 'false' ) ==  'true' ) {
					success( cfhttp, 'Site 1' )
				} else {
					error( cfhttp, 404, 'Oops! Site Not Found' )
				}
			});

		});
	}

}

