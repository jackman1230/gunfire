/**
 * 设置LayaNative屏幕方向，可设置以下值
 * landscape           横屏
 * portrait            竖屏
 * sensor_landscape    横屏(双方向)
 * sensor_portrait     竖屏(双方向)
 */
window.screenOrientation = "sensor_landscape";

//-----libs-begin-----
loadLib("libs/laya.core.min.js")
loadLib("libs/laya.ani.min.js")
loadLib("libs/laya.html.min.js")
loadLib("libs/laya.ui.min.js")
loadLib("libs/laya.physics.min.js")
loadLib("libs/fairygui.js")
loadLib("libs/moosnow.conf.js")
loadLib("libs/moosnow.platform.sdk.min.js")
//-----libs-end-------
loadLib("js/bundle.js");
