component {

	function run() {
		fileSystemUtil.createMapping( '/testbox', resolvePath( "../../testbox/" ) )
		testbox = new testbox.system.TestBox();
		testbox.addDirectories( fileSystemUtil.makePathRelative( resolvePath( "specs" ) ) );
		systemSettings.setSystemSetting( 'box_server_openBrowser', false )

		print.line( 'Production Profile' ).toConsole()
		systemSettings.setSystemSetting( 'box_server_profile', 'production' )
		systemSettings.setSystemSetting( 'box_server_web_blockCFAdmin', true )
		request.__server_profile = 'production'
		command( 'server start' )
			.params( serverConfigFile=resolvePath( '../server.json' ) )
			.flags( 'verbose' )
			.run( returnOutput=true );

		sleep( 2000 )

		results = deserializeJSON( testbox.run( reporter="JSON" ) );
		getInstance( "CLIRenderer@testbox-commands" ).render( print, results, true )
		print.toConsole()

		command( 'server stop' )
			.params( serverConfigFile=resolvePath( '../server.json' ) )
			.run( returnOutput=true );

		sleep( 2000 )

		print.line( 'Development Profile' ).toConsole()
		systemSettings.setSystemSetting( 'box_server_profile', 'development' )
		systemSettings.setSystemSetting( 'box_server_web_blockCFAdmin', false )
		request.__server_profile = 'development'
		command( 'server start' )
			.params( serverConfigFile=resolvePath( '../server.json' ) )
			.flags( 'verbose' )
			.run( returnOutput=true );

		sleep( 2000 )

		results = deserializeJSON( testbox.run( reporter="JSON" ) );
		getInstance( "CLIRenderer@testbox-commands" ).render( print, results, true )
		print.toConsole()

		command( 'server stop' )
			.params( serverConfigFile=resolvePath( '../server.json' ) )
			.run( returnOutput=true );

	}

}
