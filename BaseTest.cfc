component extends="testbox.system.BaseSpec"{

	function beforeAll() {
		systemSettings = application.wirebox.getInstance( 'systemSettings' );
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

