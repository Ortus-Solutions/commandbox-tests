component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'Case Sensitivity On' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					'box_server_web_caseSensitivePaths' : true
				}
			},
			'Case Sensitivity Off' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					'box_server_web_caseSensitivePaths' : false
				}
			}
		];

	}
}