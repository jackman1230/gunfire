if ((typeof swan !== 'undefined') && (typeof swanGlobal !== 'undefined')) {
	require("swan-game-adapter.js");
	require("libs/laya.bdmini.js");
} else if (typeof wx !== "undefined") {
	require("weapp-adapter.js");
	require("libs/laya.wxmini.js");
} else if (typeof qq !== "undefined") {
	require("libs/laya.qqmini.js");
}
window.loadLib = require;
require("index-c8c06416e1.js");
require("utils/ald-game.js");