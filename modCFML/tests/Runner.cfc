component extends="../../BaseRunner" {

	function preTask() {
		startAJP = true;

		fixtures = [
			'Lucee' : {
				serverConfigFile : resolvePath( '../server.json' )
			},
			'Adobe 2023' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_app_cfengine : 'adobe@2023'
				}
			}
		];

	}

}