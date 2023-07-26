component {
	property name='CommandService' inject;

	function run() {

		var fixtures = {
			'Production Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'production',
					box_server_web_blockCFAdmin : true
				}
			},
			'Development Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development'
				}
			},
			'Adobe 2023' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2023'
				}
			},
			'Adobe 2021' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2021'
				}
			},
			'Adobe 2018' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2018',
					box_server_jvm_javaVersion : 'openjdk11'
				}
			},
			'Adobe 2016' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2016',
					box_server_jvm_javaVersion : 'openjdk11'
				}
			},
			'Adobe 11' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@11',
					box_server_jvm_javaVersion : 'openjdk8'
				}
			}
		};

		fixtures.each( ( testName, t )=>{
			print.line( testName ).toConsole();
			runTests( t.serverConfigFile, t.env );
		} );

	}

	function runTests( required string serverConfigFile, struct env={} ) {
		// Running resolvePath() inside the clsoure below will resolve to the wrong path since the closure executes inside the CommandService
		var testboxPath = resolvePath( "../../testbox/" );
		var specsPath = resolvePath( "specs" );

		// run in a "sub-shell" so we can load env vars via dot env which only apply to this site
		CommandService.runInEnvironment(
			'runTests',
			()=>{
				systemSettings.setSystemSettings( env );
				systemSettings.setSystemSetting( 'box_server_openBrowser', false )
				systemSettings.setSystemSetting( 'box_server_fusionreactor_enable', false )

				try {

					print.line( 'Starting Server [#serverConfigFile#]' ).toConsole();
					command( 'server start' )
						.params( serverConfigFile=serverConfigFile )
						.flags( 'verbose' )
						.run( returnOutput=true );

					sleep( 2000 )

					fileSystemUtil.createMapping( '/testbox', testboxPath )
					var testbox = new testbox.system.TestBox();
					testbox.addDirectories( fileSystemUtil.makePathRelative( specsPath ) );
					var results = deserializeJSON( testbox.run( reporter="JSON" ) );
					getInstance( "CLIRenderer@testbox-commands" ).render( print, results, true )
					print.toConsole()
				} finally {
					print.line( 'Stopping Server [#serverConfigFile#]' ).toConsole();
					command( 'server stop' )
						.params( serverConfigFile=serverConfigFile )
						.run( returnOutput=true );

					sleep( 5000 )
				}

			}
		);

	}

}
