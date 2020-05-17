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

    class WarView {
        constructor() { }
        initView() {
            this.warView = fairygui.UIPackage.createObject("Game", "WarView");
            this.bg = this.warView.getChildAt(0);
            this.bg.url = "res/map_1.jpg";
            this.bg.setScale(3.5, 3.5);
            this.img = this.warView.getChildAt(1);
            this.img.displayObject.addComponent(Laya.RigidBody);
            this.img.displayObject.addComponent(Laya.BoxCollider);
            this.boxCollider = this.img.displayObject.getComponent(Laya.BoxCollider);
            this.rigidBody = this.img.displayObject.getComponent(Laya.RigidBody);
            this.boxCollider.width = this.img.displayObject.width;
            this.boxCollider.height = this.img.displayObject.height;
            this.rigidBody.type = "static";
            Laya.Physics.I.worldRoot = this.warView.displayObject;
        }
        ;
        updateViewPort(moveX) {
            this.warView.x -= moveX;
            console.log("this.warView.x:" + this.warView.x);
        }
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

    class PlayerData {
    }
    PlayerData.WEAPON_TYPE = 1;
    PlayerData.WEAPON_PIS = 1;
    PlayerData.WEAPON_MAC = 2;
    PlayerData.WEAPON_MAX = 2;
    PlayerData.ENEMY_PIS = 1;
    PlayerData.ENEMY_GRE = 2;
    PlayerData.ENEMY_MAC = 3;
    PlayerData.ENEMY_FIRE = 4;
    PlayerData.ENEMY_MOR = 4;

    class Player {
        constructor() {
            this.direction = 0;
            this.sRun = false;
            this.sFire = false;
            this.sBoom = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 5;
            this.jumpHigh = 200;
            this.weaponType = 1;
            this.stillFireNum = 1;
        }
        initView() {
            this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player");
            this.rolePlayer.setPivot(0.5, 0.5);
            this.body = this.rolePlayer.getChildAt(0);
            this.firePos1 = this.rolePlayer.getChildAt(1);
            this.firePos2 = this.rolePlayer.getChildAt(2);
            this.firePosCtl = this.rolePlayer.getController("firePos");
            this.fireTypeCtl = this.rolePlayer.getController("fireType");
            this.fireTypeCtl.selectedIndex = this.firePosCtl.selectedIndex = 0;
            this.firePos1.visible = this.firePos2.visible = false;
            this.playerAni = new PlayerAni();
            this.playerAni.initView();
            this.rolePlayer.displayObject.addComponent(Laya.RigidBody);
            this.rolePlayer.displayObject.addComponent(Laya.BoxCollider);
            this.rigidBody = this.rolePlayer.displayObject.getComponent(Laya.RigidBody);
            this.boxCollider = this.rolePlayer.displayObject.getComponent(Laya.BoxCollider);
            this.rigidBody.linearDamping = 0;
            this.boxCollider.width = this.rolePlayer.displayObject.width;
            this.boxCollider.height = this.rolePlayer.displayObject.height;
            this.boxCollider.friction = 0;
            console.log(this.boxCollider);
            this.setStay();
            this.setRight();
            Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
            Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
            Laya.stage.on(Laya.Event.MOUSE_DOWN, this, this.setFire);
            Laya.stage.on(Laya.Event.MOUSE_UP, this, this.setFireEnd);
            var nu = 0;
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
                            this.stopMove();
                    }
                    break;
                case 68:
                    this.keyRight = false;
                    if (this.keyLeft == false) {
                        this.sRun = false;
                        if (this.keyJump == false)
                            this.stopMove();
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
                case 81:
                    console.log("扔雷");
                    if (this.sBoom)
                        return;
                    this.setBoom();
                    break;
                case 69:
                    console.log("切枪");
                    this.changeWeaponType();
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
            this.setBoomComplete();
            this.keyJump = true;
            this.bodyLeg.url = "ui://Game/legJump";
            Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y - this.jumpHigh }, 300, null, Laya.Handler.create(this, this.jumpEnd));
        }
        jumpEnd() {
            Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y + this.jumpHigh }, 300, null, Laya.Handler.create(this, () => {
                this.keyJump = false;
                if (this.sBoom) {
                    this.setBoomComplete();
                }
                else if (this.sFire) {
                    this.body.url = "ui://Game/player_fire_" + this.weaponType;
                }
                if (this.sRun) {
                    this.bodyLeg.url = "ui://Game/legMove";
                    this.bodyLeg.content.rewind();
                    return;
                }
                this.stopMove();
            }));
        }
        setRun() {
            if (this.sRun)
                return;
            if (this.sFire) {
                this.body.url = "ui://Game/player_fire_" + this.weaponType;
            }
            else {
                this.body.url = "ui://Game/player_stay_" + this.weaponType;
            }
            this.bodyLeg.url = "ui://Game/legMove";
            this.sRun = true;
            Laya.timer.clear(this, this.stillRun);
            Laya.timer.frameLoop(1, this, this.stillRun);
        }
        stillRun() {
            var w = this.rigidBody.getWorldCenter();
            if (this.direction == 1) {
                this.rolePlayer.x += this.speed;
                if (this.rolePlayer.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.Browser.clientWidth / 2) {
                    ViewManager.instance.updateViewPort(this.speed);
                }
            }
            else {
                this.rigidBody.setVelocity({ x: -this.speed, y: 0 });
                if (w.x < Math.abs(ViewManager.instance.warView.warView.x))
                    w.x = Math.abs(ViewManager.instance.warView.warView.x);
            }
            console.log("roleplayer--" + this.rolePlayer.x, this.rolePlayer.y);
            console.log("www--", w.x, w.y);
            var b = this.rigidBody.getCenter();
            console.log("bbb--", b.x, b.y);
        }
        setFire() {
            if (this.sFire)
                return;
            this.sFire = true;
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
            this.fireTypeCtl.selectedIndex = this.weaponType - 1;
            this["firePos" + this.weaponType].visible = true;
            Laya.timer.clear(this, this.stillFire);
            Laya.timer.loop(100, this, this.stillFire);
            ViewManager.instance.createBullet();
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        stillFire() {
            this.stillFireNum++;
            if (this.stillFireNum % 2 == 0) {
                this["firePos" + this.weaponType].visible = false;
            }
            else {
                this["firePos" + this.weaponType].visible = true;
                ViewManager.instance.createBullet();
            }
        }
        setFireEnd() {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this["firePos" + this.weaponType].visible = false;
            this.stillFireNum = 1;
            this.body.url = "ui://Game/player_stay_" + this.weaponType;
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        setBoom() {
            this.sBoom = true;
            this.body.url = "ui://Game/player_boom_" + this.weaponType;
            this.bodybody.content.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.setBoomComplete));
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        setBoomComplete() {
            this.sBoom = false;
            if (this.keyJump)
                return;
            this.bodyLeg.content.rewind();
            if (this.sFire)
                this.body.url = "ui://Game/player_fire_" + this.weaponType;
            else
                this.body.url = "ui://Game/player_stay_" + this.weaponType;
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        stopMove() {
            this.keyLeft = false;
            this.keyRight = false;
            this.sRun = false;
            this.keyJump = false;
            this.bodyLeg.url = "ui://Game/legStay";
            this.rigidBody.setVelocity({ x: 0, y: 0 });
            Laya.timer.clear(this, this.stillRun);
        }
        setStay() {
            this.body.url = "ui://Game/player_stay_" + this.weaponType;
            this.stopMove();
            Laya.timer.clear(this, this.stillFire);
        }
        changeWeaponType() {
            if (this.sBoom)
                return;
            this.weaponType++;
            if (this.weaponType > PlayerData.WEAPON_MAX) {
                this.weaponType = PlayerData.WEAPON_PIS;
            }
            this.body.url = "ui://Game/player_stay_" + this.weaponType;
            if (this.sRun)
                this.bodyLeg.url = "ui://Game/legMove";
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        beHit() {
            Laya.timer.clear(this, this.setColor);
            this.body.color = "#ff0000";
            Laya.timer.once(200, this, this.setColor);
            console.log("player--be--hit");
        }
        setColor() {
            this.body.color = "#ffffff";
        }
        get bodyComponent() {
            return this.body.component;
        }
        get bodyLeg() {
            return this.bodyComponent.getChildAt(0).asLoader;
        }
        get bodybody() {
            return this.bodyComponent.getChildAt(1).asLoader;
        }
    }

    class EnemyAni {
        constructor() {
            this.enemyType = 3;
        }
        initView(type) {
            this.enemyType = type;
        }
        get stayAniUrl() {
            return "ui://Game/enemyStay_" + this.enemyType;
        }
        get deathAniUrl() {
            return "ui://Game/death_" + this.enemyType;
        }
        get fireAniUrl() {
            return "ui://Game/enemy_fire_" + this.enemyType;
        }
        get runAniUrl() {
            return "ui://Game/enemy_run_" + this.enemyType;
        }
        get deathAni() {
            return this["death_" + this.enemyType];
        }
        get fireAni() {
            return this["fire_" + this.enemyType];
        }
        get runAni() {
            return this["run_" + this.enemyType];
        }
    }

    class Enemy {
        constructor() {
            this.enemyType = 1;
            this.direction = 0;
            this.sRun = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 10;
            this.jumpHigh = 200;
        }
        initView() {
            this.view = fairygui.UIPackage.createObject("Game", "enemy");
            this.view.setPivot(0.5, 0.5);
            this.enemyCtl = this.view.getController("ctl");
            this.enemy = this.view.getChildAt(0);
            this.enemyAni = new EnemyAni();
            this.enemyAni.initView(this.enemyType);
            this.enemy.url = "ui://Game/enemy" + this.enemyType;
        }
        ;
        beHit() {
            Laya.timer.clear(this, this.setColor);
            this.enemy.color = "#ff0000";
            Laya.timer.once(200, this, this.setColor);
            console.log("enemy--be--hit");
        }
        setColor() {
            this.enemy.color = "#ffffff";
        }
        setLeft() {
            if (this.direction == -1)
                return;
            this.direction = -1;
            this.view.skewY = 0;
        }
        setRight() {
            if (this.direction == 1)
                return;
            this.direction = 1;
            this.view.skewY = 180;
        }
        setIdle() {
            if (this.enemyType < 5) {
            }
        }
        setRun() {
            if (this.sRun)
                return;
            this.enemy.url = this.enemyAni.runAniUrl;
        }
        stillRun() {
            if (this.direction == 1) {
                this.view.x += this.speed;
                if (this.view.x >= Laya.Browser.clientWidth / 2) {
                    this.view.x = Laya.Browser.clientWidth / 2;
                }
            }
            else {
                this.view.x -= this.speed;
                if (this.view.x < 1)
                    this.view.x = 1;
            }
        }
        setFire() {
            Laya.timer.loop(2000, this, this.setFire);
            this.enemy.url = this.enemyAni.fireAniUrl;
        }
        setBoom() {
        }
        setStay() {
            this.enemy.url = this.enemyAni.stayAniUrl;
        }
        setBoomComplete() {
            this.setStay();
            console.log("rengshouliudan");
        }
        setDeath() {
            this.enemy.url = this.enemyAni.deathAniUrl;
        }
        getBody() {
            return this.enemy.component;
        }
        getBodyLoader() {
            return this.enemy.component.getChildAt(0).asLoader;
        }
    }

    class Bullet extends Laya.Script {
        constructor() {
            super();
            this.bulletType = 1;
            this.direction = 1;
            this.theEnd = false;
            this.speed = 35;
            this.isEnd = false;
            this.dis = 0;
        }
        initView() {
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.zidan = this.view.getChildAt(0).asLoader;
        }
        setBulletData(type, dir) {
            this.bulletType = type;
            this.direction = dir;
            this.zidan.url = "ui://Game/zidan" + this.bulletType;
            if (this.direction == 1) {
                this.view.setSkew(0, 0);
            }
            else {
                this.view.setSkew(180, 180);
            }
        }
        updateView() {
            this.dis += this.speed;
            if (this.direction == 1) {
                this.view.x += this.speed;
            }
            else {
                this.view.x -= this.speed;
                if (this.view.x < 0) {
                    this.isEnd = true;
                    this.dis = 0;
                }
            }
            if (this.dis > Laya.Browser.clientWidth) {
                this.dis = 0;
                this.isEnd = true;
            }
        }
        onEnable() {
        }
        onDisable() {
        }
    }

    class ViewManager {
        constructor() {
            this.bulletArr = [];
            this.enemyArr = [];
            this.isChecking = false;
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new ViewManager();
            return this._instance;
        }
        showStartView() {
            this.initView();
            Laya.stage.addChild(this.warView.warView.displayObject);
            this.warView.warView.addChild(this.player.rolePlayer);
            this.player.rolePlayer.x = 200;
            this.player.rolePlayer.y = 400;
            console.log("开始初始化界面");
            this.warView.warView.addChild(this.enemy.enemy);
            this.enemy.enemy.x = 800;
            this.enemy.enemy.y = 400;
            this.enemy.setFire();
            this.enemyArr.push(this.enemy);
        }
        createBullet() {
            var b = new Bullet();
            b.initView();
            b.setBulletData(this.rolePlayer.weaponType, this.rolePlayer.direction);
            var p = this.rolePlayer.rolePlayer.localToGlobal(this.rolePlayer["firePos" + this.rolePlayer.weaponType].x, this.rolePlayer["firePos" + this.rolePlayer.weaponType].y);
            var y = this.bulletRandomY();
            if (this.rolePlayer.direction == 1) {
                b.view.x = Math.abs(this.warView.warView.x) + p.x + b.view.width - 20;
                b.view.y = p.y - this.bulletRandomY();
            }
            else {
                b.view.x = Math.abs(this.warView.warView.x) + p.x - b.view.width * 2 + 20;
                b.view.y = p.y - this.bulletRandomY();
            }
            this.warView.warView.addChild(b.view);
            this.bulletArr.push(b);
            this.addFrameTimer();
            return b;
        }
        addFrameTimer() {
            if (this.isChecking)
                return;
            this.isChecking = true;
            Laya.timer.frameLoop(3, this, this.updateBulletPos);
        }
        checkBulletHit() {
            if (this.isChecking)
                return;
        }
        initView() {
            this.warView = new WarView();
            this.player = new Player();
            this.enemy = new Enemy();
            this.warView.initView();
            this.player.initView();
            this.enemy.initView();
        }
        get rolePlayer() {
            return this.player;
        }
        updateBulletPos() {
            for (let i = this.bulletArr.length - 1; i >= 0; i--) {
                var b = this.bulletArr[i];
                if (b.isEnd) {
                    b.view.dispose();
                    this.bulletArr.splice(i, 1);
                    b = null;
                    continue;
                }
                b.updateView();
                for (let j = 0; j < this.enemyArr.length; j++) {
                    var e = this.enemyArr[j];
                    if (b.view.x >= e.enemy.x && b.view.x < e.enemy.x + e.enemy.width && b.view.y >= e.enemy.y && b.view.y <= e.enemy.y + e.enemy.height) {
                        e.beHit();
                        b.view.dispose();
                        this.bulletArr.splice(i, 1);
                        b = null;
                    }
                }
            }
            if (this.bulletArr.length < 1 || this.enemyArr.length < 1) {
                Laya.timer.clear(this, this.updateBulletPos);
                this.isChecking = false;
                console.log("clearFrameLoop");
            }
        }
        updateViewPort(moveX) {
            this.warView.updateViewPort(moveX);
        }
        bulletRandomY() {
            return Math.floor(Math.random() * 10) + 10;
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
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_8.png", type: Laya.Loader.IMAGE }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
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
