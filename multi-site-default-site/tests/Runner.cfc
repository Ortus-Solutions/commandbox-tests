component extends="../../BaseRunner" {

	function preTask() {

		fixtures = [
			'Default Site' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					default_site : true
				}
			},
			'No Default Site' : {
				serverConfigFile : resolvePath( '../server-no-default.json' )
			}
		];

	}

}