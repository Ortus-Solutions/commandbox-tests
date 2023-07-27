component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'client cert auth server' : {
				serverConfigFile : resolvePath( '../server.json' )
			}
		];

	}
}