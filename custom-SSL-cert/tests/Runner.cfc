component extends="../../BaseRunner" {

	function preTask() {
		fixtures = [
			'PFX Cert File' : {
				serverConfigFile : resolvePath( '../server.json' )
			},
			'PEM Cert File and Key File' : {
				serverConfigFile : resolvePath( '../server.json' ),
				env : {
					box_server_web_ssl_certfile : "../certs/serverCert1-san.cer",
					box_server_web_ssl_keyfile : "../certs/serverCert1-san.key",
					box_server_web_ssl_keyPass : ""
				}
			}
		];

	}
}