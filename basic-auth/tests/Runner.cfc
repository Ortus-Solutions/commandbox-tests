component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'Basic auth server' : {
				serverConfigFile : resolvePath( '../server.json' )
			}
		];

	}
}