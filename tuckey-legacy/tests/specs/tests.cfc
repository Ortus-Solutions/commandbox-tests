component extends="../../../BaseTest" {

	function run(){

		describe( "Tuckey Legacy", function(){

			it( "Home page", function(){
				http url='http://tuckeylegacy.com';
				success( cfhttp, 'Directory Listing' )
			});

			it( "hidden folder", function(){
				http url='http://tuckeylegacy.com/hidden/';
				error( cfhttp, 404, 'My Tuckey 404 page' )
			});

			it( "hidden folder real file", function(){
				http url='http://tuckeylegacy.com/hidden/foo/txt';
				error( cfhttp, 404, 'My Tuckey 404 page' )
			});

			it( "hidden folder fake file", function(){
				http url='http://tuckeylegacy.com/hidden/blah';
				error( cfhttp, 404, 'My Tuckey 404 page' )
			});

		});
	}

}

