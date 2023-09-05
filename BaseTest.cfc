component extends="testbox.system.BaseSpec"{

	function beforeAll() {
		systemSettings = application.wirebox.getInstance( 'systemSettings' );
		fileSystemUtil = application.wirebox.getInstance( 'fileSystem' );
		// Stop caching DNS lookups, including hosts file entries
		createObject( 'java', 'java.lang.System' ).setProperty( 'networkaddress.cache.ttl', 0 )
	}

	function success( cfhttp, content='' ) {
		expect( cfhttp.status_code ).toBe( 200 )
		if( len( content ) ) {
			expect( cfhttp.fileContent ).toInclude( content )
		}
	}
	function error( cfhttp, status, content='' ) {
		expect( cfhttp.status_code ).toBe( status )
		if( len( content ) ) {
			expect( cfhttp.fileContent ).toInclude( content )
		}
	}

}

