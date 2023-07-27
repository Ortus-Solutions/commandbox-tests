component extends="../../BaseRunner" {

	function preTask() {

		fixtures = [
			'Production Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'production',
					box_server_web_blockCFAdmin : true,
					box_server_web_blockCFAdmin : true
				}
			},
			'Development Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development'
				}
			},
			'Production Adobe 2023' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'production',
					box_server_web_blockCFAdmin : true,
					box_server_app_cfengine : 'adobe@2023'
				}
			},
			'Development Adobe 2023' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2023'
				}
			}
		];

	}

}