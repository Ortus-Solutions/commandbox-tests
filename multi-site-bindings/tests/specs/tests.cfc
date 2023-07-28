component extends="../../../BaseTest" {

	function beforeAll() {
		try {
			sslcertificateinstall( 'site1.com' )
		} catch( any e ) {
			systemOutput( e.message, 1 )
		}
		super.beforeAll();
	}

	function run(){

		describe( "Multi-Site Bindings", function(){

			describe( "Site 1", function(){

				it( "port 80", function(){
					http url='http://site1.com:80/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 8080", function(){
					http url='http://site1.com:8080/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 81", function(){
					http url='http://site1.com:81/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 82", function(){
					http url='http://site1.com:82/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 443", function(){
					http url='https://site1.com:443/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 8443", function(){
					http url='https://site1.com:8443/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 444", function(){
					http url='https://site1.com:444/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 446", function(){
					http url='https://site1.com:446/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 8084", function(){
					http url='http://site1.com:8084/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 8082", function(){
					http url='http://site1.com:8082/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 8081", function(){
					http url='http://site1.com:8081/';
					success( cfhttp, 'Site 1' )
				});

				it( "port 8083", function(){
					http url='http://site1.com:8083/';
					error( cfhttp, 404, 'site not found' )
				});

			});

			describe( "Site 2", function(){

				it( "port 80", function(){
					http url='http://site2.com:80/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 8080", function(){
					http url='http://site2.com:8080/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 81", function(){
					http url='http://site2.com:81/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 82", function(){
					http url='http://site2.com:82/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 443", function(){
					http url='https://site2.com:443/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 8443", function(){
					http url='https://site2.com:8443/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 444", function(){
					http url='https://site2.com:444/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 446", function(){
					http url='https://site2.com:446/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 8084", function(){
					http url='http://site2.com:8084/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 8082", function(){
					http url='http://site2.com:8082/';
					success( cfhttp, 'Site 2' )
				});

				it( "port 8081", function(){
					http url='http://site2.com:8081/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 8083", function(){
					http url='http://site2.com:8083/';
					success( cfhttp, 'Site 2' )
				});

			});

			describe( "Site 3", function(){

				it( "port 80", function(){
					http url='http://site3.com:80/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 8080", function(){
					http url='http://site3.com:8080/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 81", function(){
					http url='http://site3.com:81/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 82", function(){
					http url='http://site3.com:82/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 443", function(){
					http url='https://site3.com:443/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 8443", function(){
					http url='https://site3.com:8443/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 444", function(){
					http url='https://site3.com:444/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 446", function(){
					http url='https://site3.com:446/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 8084", function(){
					http url='http://site3.com:8084/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 8082", function(){
					http url='http://site3.com:8082/';
					success( cfhttp, 'Site 3' )
				});

				it( "port 8081", function(){
					http url='http://site3.com:8081/';
					error( cfhttp, 404, 'site not found' )
				});

				it( "port 8083", function(){
					http url='http://site3.com:8083/';
					error( cfhttp, 404, 'site not found' )
				});

			});

		});
	}

}

