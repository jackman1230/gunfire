if ((typeof swan !== 'undefined') && (typeof swanGlobal !== 'undefined')) {
	require("swan-game-adapter.js");
	require("libs/laya.bdmini.js");
} else if (typeof wx !== "undefined") {
	require("weapp-adapter.js");
	require("libs/laya.wxmini.js");
} 
window.loadLib = require;
require("index-6869202ff7.js");
require("utils/ald-game.js");