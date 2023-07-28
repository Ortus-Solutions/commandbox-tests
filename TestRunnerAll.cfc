component {

	function run() {
		var testRunners = globber( resolvePath( '*/tests/Runner.cfc' ) ).matches();
		testRunners.each( (r)=>{
			print.line( r ).toConsole()
			task( r ).run()
		} );

	}
}
