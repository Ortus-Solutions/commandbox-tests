component extends="../../../BaseTest" {

	function run(){

		describe( "ModCFML", function(){

			it( "Site 1 CF", function(){
				http url='http://site1.com:8080/';
				success( cfhttp, 'Site 1' )
			});

			it( "Site 1 Static", function(){
				http url='http://site1.com:8080/static.txt';
				success( cfhttp, 'site1 static file' )
			});

			it( "Site 2 CF", function(){
				http url='http://site2.com:8080/';
				success( cfhttp, 'Site 2' )
			});

			it( "Site 2 Static", function(){
				http url='http://site2.com:8080/static.txt';
				success( cfhttp, 'site2 static file' )
			});

			it( "Site 3 CF", function(){
				http url='http://site3.com:8080/';
				success( cfhttp, 'Site 3' )
			});

			it( "Site 3 Static", function(){
				http url='http://site3.com:8080/static.txt';
				success( cfhttp, 'site3 static file' )
			});

		});
	}

}

