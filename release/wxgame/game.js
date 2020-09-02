if ((typeof swan !== 'undefined') && (typeof swanGlobal !== 'undefined')) {
	require("swan-game-adapter.js");
	require("libs/laya.bdmini.js");
} else if (typeof wx!=="undefined") {
	require("weapp-adapter.js");
	require("libs/laya-08f0cce6a1.wxmini.js");
}
window.loadLib = require;
require("index-a05bed90de.js");
require("utils/ald-game.js");