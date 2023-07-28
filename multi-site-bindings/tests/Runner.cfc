component extends="../../BaseRunner" {

	function preTask() {
		startAJP = true;

		fixtures = [
			'Lucee' : {
				serverConfigFile : resolvePath( '../server.json' )
			}
		];

	}

}