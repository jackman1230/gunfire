(function () {
    'use strict';

    class GameConfig {
        constructor() { }
        static init() {
            var reg = Laya.ClassUtils.regClass;
        }
    }
    GameConfig.width = 1334;
    GameConfig.height = 750;
    GameConfig.scaleMode = Laya.Stage.SCALE_EXACTFIT;
    GameConfig.screenMode = Laya.Stage.SCREEN_HORIZONTAL;
    GameConfig.alignV = Laya.Stage.ALIGN_CENTER;
    GameConfig.alignH = Laya.Stage.ALIGN_MIDDLE;
    GameConfig.startScene = "";
    GameConfig.sceneRoot = "";
    GameConfig.debug = false;
    GameConfig.stat = false;
    GameConfig.physicsDebug = false;
    GameConfig.exportSceneToJson = true;
    GameConfig.init();

    class BackGroundView {
        constructor() { }
        initView() {
            this.view = fairygui.UIPackage.createObject("Game", "BackGround");
            this.bg = this.view.getChildAt(0);
            this.bg.url = "res/map_1.jpg";
        }
        ;
    }

    class WarView {
        constructor() { }
        initView() {
        }
        ;
    }

    class PlayerAni {
        constructor() { }
        initView() {
            this.body_1 = fairygui.UIPackage.createObject("Game", "body_1").asMovieClip;
            this.body_2 = fairygui.UIPackage.createObject("Game", "body_2").asMovieClip;
            this.boomAni_1 = fairygui.UIPackage.createObject("Game", "boom_1").asMovieClip;
            this.boomAni_2 = fairygui.UIPackage.createObject("Game", "boom_2").asMovieClip;
            this.legJump = fairygui.UIPackage.createObject("Game", "legJump").asMovieClip;
            this.legMove = fairygui.UIPackage.createObject("Game", "legMove").asMovieClip;
            this.legStay = fairygui.UIPackage.createObject("Game", "legStay").asImage;
            this.fire_1 = fairygui.UIPackage.createObject("Game", "fire_1").asMovieClip;
            this.fire_2 = fairygui.UIPackage.createObject("Game", "fire_2").asMovieClip;
        }
    }

    class Player {
        constructor() {
            this.direction = 0;
            this.sRun = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 10;
            this.jumpHigh = 150;
        }
        initView() {
            this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player");
            this.rolePlayer.setPivot(0.5, 0.5);
            this.leg = this.rolePlayer.getChildAt(0);
            this.body = this.rolePlayer.getChildAt(1);
            this.playerAni = new PlayerAni();
            this.playerAni.initView();
            this.leg.url = "";
            this.body.url = "";
            this.leg.displayObject.removeChildren();
            this.body.displayObject.removeChildren();
            this.leg.displayObject.addChild(this.playerAni.legStay.displayObject);
            this.body.displayObject.addChild(this.playerAni.body_1.displayObject);
            Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
            Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
        }
        ;
        keyUpEvent(e) {
            var keyCode = e["keyCode"];
            switch (keyCode) {
                case 65:
                    this.keyLeft = false;
                    if (this.keyRight == false) {
                        this.sRun = false;
                        if (this.keyJump == false)
                            this.setStay();
                    }
                    break;
                case 68:
                    this.keyRight = false;
                    if (this.keyLeft == false) {
                        this.sRun = false;
                        if (this.keyJump == false)
                            this.setStay();
                    }
                    break;
            }
        }
        keyDowmEvent(e) {
            var keyCode = e["keyCode"];
            console.log(keyCode);
            switch (keyCode) {
                case 87:
                    console.log("上");
                    break;
                case 83:
                    console.log("下");
                    break;
                case 65:
                    this.keyLeft = true;
                    console.log("左");
                    this.setLeft();
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 68:
                    this.keyRight = true;
                    console.log("右");
                    this.setRight();
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 32:
                    console.log("跳");
                    if (this.keyJump)
                        return;
                    this.setJump();
                    break;
            }
        }
        setLeft() {
            if (this.direction == -1)
                return;
            this.direction = -1;
            this.rolePlayer.skewY = 0;
        }
        setRight() {
            if (this.direction == 1)
                return;
            this.direction = 1;
            this.rolePlayer.skewY = 180;
        }
        setJump() {
            this.keyJump = true;
            this.leg.displayObject.removeChildren();
            this.leg.displayObject.addChild(this.playerAni.legJump.displayObject);
            this.playerAni.legJump.setPlaySettings(1, -1, 1, 5);
            Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y - this.jumpHigh }, 400, null, Laya.Handler.create(this, this.jumpEnd));
        }
        setRun() {
            if (this.sRun)
                return;
            this.leg.displayObject.removeChildren();
            this.leg.displayObject.addChild(this.playerAni.legMove.displayObject);
            this.sRun = true;
            Laya.timer.clear(this, this.stillRun);
            Laya.timer.loop(50, this, this.stillRun);
        }
        stillRun() {
            if (this.direction == 1) {
                this.rolePlayer.x += this.speed;
            }
            else {
                this.rolePlayer.x -= this.speed;
                if (this.rolePlayer.x < 1)
                    this.rolePlayer.x = 1;
            }
            console.log("人物X坐标---", this.rolePlayer.x);
        }
        setFire() {
            this.leg.displayObject.removeChildren();
        }
        setBoom() {
            this.body.displayObject.removeChildren();
            this.body.asMovieClip.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.setBoomComplete));
        }
        setStay() {
            this.leg.displayObject.removeChildren();
            this.leg.displayObject.addChild(this.playerAni.legStay.displayObject);
            this.playerAni.legStay.x = 5;
            this.playerAni.legStay.y = 10;
            this.keyLeft = false;
            this.keyRight = false;
            this.sRun = false;
            Laya.timer.clear(this, this.stillRun);
        }
        jumpEnd() {
            this.keyJump = false;
            Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y + this.jumpHigh }, 400);
            this.leg.displayObject.removeChildren();
            if (this.sRun) {
                this.leg.displayObject.addChild(this.playerAni.legMove.displayObject);
                return;
            }
            this.setStay();
        }
        setBoomComplete() {
            this.setStay();
            console.log("rengshouliudan");
        }
    }

    class ViewManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new ViewManager();
            return this._instance;
        }
        showStartView() {
            this.initView();
            Laya.stage.addChild(this.bgView.view.displayObject);
            this.bgView.view.addChild(this.player.rolePlayer);
            this.player.rolePlayer.x = 200;
            this.player.rolePlayer.y = 400;
            this.player.setJump();
            console.log("开始初始化界面");
        }
        initView() {
            this.bgView = new BackGroundView();
            this.warView = new WarView();
            this.player = new Player();
            this.bgView.initView();
            this.player.initView();
            this.warView.initView();
        }
        getRolePlayer() {
            if (this.player) {
                return this.player.rolePlayer;
            }
            return null;
        }
    }

    class GameManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new GameManager();
            return this._instance;
        }
        startGame() {
            ViewManager.instance.showStartView();
        }
    }
    GameManager.assetsData = [];

    class AssetsManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new AssetsManager();
            return this._instance;
        }
        loadAssetsData() {
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
            console.log(AssetsManager.assetsData);
            Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete() {
            fairygui.UIPackage.addPackage("res/Game");
            console.log("资源加载完成");
            GameManager.instance.startGame();
        }
    }
    AssetsManager.assetsData = [];

    class Main {
        constructor() {
            if (window["Laya3D"])
                Laya3D.init(GameConfig.width, GameConfig.height);
            else
                Laya.init(GameConfig.width, GameConfig.height, Laya["WebGL"]);
            Laya["Physics"] && Laya["Physics"].enable();
            Laya["DebugPanel"] && Laya["DebugPanel"].enable();
            Laya.stage.scaleMode = GameConfig.scaleMode;
            Laya.stage.screenMode = GameConfig.screenMode;
            Laya.stage.alignV = GameConfig.alignV;
            Laya.stage.alignH = GameConfig.alignH;
            Laya.URL.exportSceneToJson = GameConfig.exportSceneToJson;
            if (GameConfig.debug || Laya.Utils.getQueryString("debug") == "true")
                Laya.enableDebugPanel();
            if (GameConfig.physicsDebug && Laya["PhysicsDebugDraw"])
                Laya["PhysicsDebugDraw"].enable();
            if (GameConfig.stat)
                Laya.Stat.show();
            Laya.alertGlobalError = true;
            Laya.ResourceVersion.enable("version.json", Laya.Handler.create(this, this.onVersionLoaded), Laya.ResourceVersion.FILENAME_VERSION);
            fairygui.UIConfig.packageFileExtension = "wxfui";
            AssetsManager.instance.loadAssetsData();
        }
        onVersionLoaded() {
            Laya.AtlasInfoManager.enable("fileconfig.json", Laya.Handler.create(this, this.onConfigLoaded));
        }
        onConfigLoaded() {
            GameConfig.startScene && Laya.Scene.open(GameConfig.startScene);
        }
    }
    new Main();

}());
