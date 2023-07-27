component extends="../../../BaseTest" {

	function run(){

		describe( "Case Sensitivity", function(){

			it( "Correct case", function(){
				http url='http://site1.com/bradWOOD.txt' throwOnError=true;
				success( cfhttp, 'bradWOOD' )
			});

			it( "Wrong case", function(){
				http url='http://site1.com/bradwood.txt';

				if( systemSettings.getSystemSetting( 'box_server_web_caseSensitivePaths', false ) == true ) {
					error( cfhttp, 404 )
				} else {
					success( cfhttp, 'bradWOOD' )
				}
			});

		});
	}

}

