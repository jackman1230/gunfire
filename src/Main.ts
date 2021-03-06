import GameConfig from "./GameConfig";
import { AssetsManager } from "./Manager/AssetsManager";
import GameBinder from "./fui/Game/GameBinder";
import loadingBinder from "./fui/loading/loadingBinder";
import { MooSnowSDK } from "./Manager/MooSnowSDK";
import { GameManager } from "./Manager/GameManager";
class Main {
	constructor() {
		//根据IDE设置初始化引擎		
		// if (window["Laya3D"])
		// 	Laya3D.init(GameConfig.width, GameConfig.height);
		// else
		Laya.init(1334, 750, Laya["WebGL"]);
		Laya["Physics"] && Laya["Physics"].enable();
		Laya["DebugPanel"] && Laya["DebugPanel"].enable();
		Laya.stage.scaleMode = Laya.Stage.SCALE_FIXED_HEIGHT;
		Laya.stage.screenMode = Laya.Stage.SCREEN_HORIZONTAL;
		Laya.stage.alignV = Laya.Stage.ALIGN_CENTER;
		Laya.stage.alignH = Laya.Stage.ALIGN_MIDDLE;
		//兼容微信不支持加载scene后缀场景
		Laya.URL.exportSceneToJson = GameConfig.exportSceneToJson;
		if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ)
			Config.useRetinalCanvas = true
		//打开调试面板（通过IDE设置调试模式，或者url地址增加debug=true参数，均可打开调试面板）
		if (GameConfig.debug || Laya.Utils.getQueryString("debug") == "true") Laya.enableDebugPanel();
		if (GameConfig.physicsDebug && Laya["PhysicsDebugDraw"]) Laya["PhysicsDebugDraw"].enable();
		if (GameConfig.stat) Laya.Stat.show();
		// Laya.alertGlobalError = true;

		//激活资源版本控制，version.json由IDE发布功能自动生成，如果没有也不影响后续流程
		Laya.ResourceVersion.enable("version.json", Laya.Handler.create(this, this.onVersionLoaded), Laya.ResourceVersion.FILENAME_VERSION);

		fairygui.UIConfig.packageFileExtension = "proto";
		GameBinder.bindAll();
		loadingBinder.bindAll();
		MooSnowSDK.login();


	}

	onVersionLoaded(): void {
		AssetsManager.instance.loadLoadingAssetsData();
		//激活大小图映射，加载小图的时候，如果发现小图在大图合集里面，则优先加载大图合集，而不是小图
		// Laya.AtlasInfoManager.enable("fileconfig.json", Laya.Handler.create(this, this.onConfigLoaded));
	}

	onConfigLoaded(): void {
		//加载IDE指定的场景
		// GameConfig.startScene && Laya.Scene.open(GameConfig.startScene);
	}
}
//激活启动类
new Main();
