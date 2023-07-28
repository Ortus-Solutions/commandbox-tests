component {
	property name='CommandService' inject;
	param startAJP = false;

	function run( boolean skipServer=false ) {

		param variables.fixtures = {};

		fixtures.each( ( testName, t )=>{
			print.line( testName ).toConsole();
			runTests( t.serverConfigFile, t.env ?: {}, skipServer );
		} );

	}

	function runTests( required string serverConfigFile, struct env={}, boolean skipServer=false ) {
		// Running resolvePath() inside the clsoure below will resolve to the wrong path since the closure executes inside the CommandService
		var testboxPath = resolvePath( getDirectoryFromPath( serverConfigFile ) & "/../testbox/" );
		var specsPath = resolvePath( getDirectoryFromPath( serverConfigFile ) & "/tests/specs" );

		// run in a "sub-shell" so we can load env vars via dot env which only apply to this site
		CommandService.runInEnvironment(
			'runTests',
			()=>{
				systemSettings.setSystemSettings( env );
				systemSettings.setSystemSetting( 'box_server_openBrowser', false )
				systemSettings.setSystemSetting( 'box_server_fusionreactor_enable', false )

				try {
					if( !skipServer ) {
						print.line( 'Starting Server [#serverConfigFile#]' ).toConsole();
						command( 'server start' )
							.params( serverConfigFile=serverConfigFile )
							.flags( 'verbose' )
							.run( returnOutput=true );

						sleep( 2000 )
					}

					fileSystemUtil.createMapping( '/testbox', testboxPath )
					var testbox = new testbox.system.TestBox();
					testbox.addDirectories( fileSystemUtil.makePathRelative( specsPath ) );
					var results = deserializeJSON( testbox.run( reporter="JSON" ) );
					getInstance( "CLIRenderer@testbox-commands" ).render( print, results, true )
					print.toConsole()
				} finally {
					if( !skipServer ) {
						print.line( 'Stopping Server [#serverConfigFile#]' ).toConsole();
						command( 'server stop' )
							.params( serverConfigFile=serverConfigFile )
							.run( returnOutput=true );

						sleep( 5000 )
					}
				}

			}
		);

	}

	function preRun() {
		if( !startAJP || (taskArgs.skipServer ?: false) ) return;

		print.line( 'Starting Docker AJP Proxy' ).toConsole();
		command( 'server run-script ajp-up' )
			.run( returnOutput=true );
	}

	function postRun() {
		if( !startAJP || (taskArgs.skipServer ?: false) ) return;

		print.line( 'Stopping Docker AJP Proxy' ).toConsole();
		command( 'server run-script ajp-down' )
			.run( returnOutput=true );
	}
}
