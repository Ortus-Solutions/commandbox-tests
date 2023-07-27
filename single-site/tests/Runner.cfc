component extends="../../BaseRunner" {

	function preTask() {
		startAJP = true;

		fixtures = [
			'Production Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'production',
					box_server_web_blockCFAdmin : true
				}
			},
			'Development Lucee' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development'
				}
			},
			'Adobe 2023' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2023'
				}
			},
			'Adobe 2021' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2021'
				}
			},
			'Adobe 2018' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2018',
					box_server_jvm_javaVersion : 'openjdk11'
				}
			},
			'Adobe 2016' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@2016',
					box_server_jvm_javaVersion : 'openjdk11'
				}
			},
			'Adobe 11' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_profile : 'development',
					box_server_app_cfengine : 'adobe@11',
					box_server_jvm_javaVersion : 'openjdk8'
				}
			}
		];

	}

}