component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'Lucee' : {
				serverConfigFile : resolvePath( '../server.json' )
			}
		];

	}
}