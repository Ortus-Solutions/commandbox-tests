component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'Tuckey Legacy server' : {
				serverConfigFile : resolvePath( '../server.json' )
			}
		];

	}
}