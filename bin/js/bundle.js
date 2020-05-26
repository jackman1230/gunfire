(function () {
    'use strict';

    class GameConfig {
        constructor() { }
        static init() {
            var reg = Laya.ClassUtils.regClass;
        }
    }
    GameConfig.width = 640;
    GameConfig.height = 1136;
    GameConfig.scaleMode = "fixedwidth";
    GameConfig.screenMode = "none";
    GameConfig.alignV = "top";
    GameConfig.alignH = "left";
    GameConfig.startScene = "BombBody.scene";
    GameConfig.sceneRoot = "";
    GameConfig.debug = false;
    GameConfig.stat = false;
    GameConfig.physicsDebug = true;
    GameConfig.exportSceneToJson = true;
    GameConfig.init();

    class WarView {
        constructor() { }
        initView() {
            Laya.Scene.load("map_1.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.scene = s;
            this.warView = fairygui.UIPackage.createObject("Game", "WarView");
            Laya.Physics.I.worldRoot = this.scene;
            this.warView.displayObject.addChild(this.scene);
            this.scene.addChild(ViewManager.instance.rolePlayer.roleBody);
            ViewManager.instance.rolePlayer.roleBody.x = 800;
            ViewManager.instance.rolePlayer.roleBody.y = 400;
            ViewManager.instance.rolePlayer.setStay();
            Laya.stage.addChild(this.warView.displayObject);
            ViewManager.instance.createEnemy();
        }
        updateViewPort(moveX) {
            this.warView.x -= moveX;
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
    PlayerData.WEAPON_RIFLE = 3;
    PlayerData.WEAPON_GRE = 4;
    PlayerData.WEAPON_MAX = 3;
    PlayerData.ENEMY_PIS = 1;
    PlayerData.ENEMY_GRE = 2;
    PlayerData.ENEMY_MAC = 3;
    PlayerData.ENEMY_FIRE = 4;
    PlayerData.ENEMY_MOR = 5;
    class BombData {
    }
    BombData.BOMB_1 = 1;
    BombData.BOMB_2 = 2;
    BombData.BOMB_4 = 4;
    BombData.BOMB_5 = 5;
    class ShotDirectionData {
    }
    ShotDirectionData.LEFT = -1;
    ShotDirectionData.RIGHT = 1;
    ShotDirectionData.RIGHT_UP = 2;
    ShotDirectionData.LEFT_UP = -2;

    class PlayerBody extends Laya.Script {
        constructor() { super(); }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
            this.setSpeedZero();
        }
        onUpdate() {
        }
        setSpeedZero() {
            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
            this.selfBody.linearDamping = 0;
            this.selfBody.angularDamping = 0;
            this.selfBody.setAngle({ x: 0, y: 0 });
            this.selfCollider.refresh();
        }
    }

    class EventManager extends Laya.EventDispatcher {
        constructor() {
            super();
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new EventManager();
            return this._instance;
        }
        dispatcherEvt(InName, agv) {
            EventManager.eventDispatcher.event(InName, agv);
        }
        addNotice(InName, caller, listener, arg) {
            EventManager.eventDispatcher.on(InName, caller, listener, (arg == null) ? null : ([arg]));
        }
        offNotice(InName, caller, listener) {
            EventManager.eventDispatcher.off(InName, caller, listener);
        }
    }
    EventManager.eventDispatcher = new Laya.EventDispatcher();

    class GameEvent {
        constructor() { }
    }
    GameEvent.PLAYER_DEATH = "PLAYER_DEATH";
    GameEvent.BULLET_DISPOSE = "BULLET_DISPOSE";
    GameEvent.BULLET_HIT_ENEMY = "BULLET_HIT_ENEMY";
    GameEvent.BULLET_HIT_ROLE = "BULLET_HIT_ROLE";
    GameEvent.BOMB_DISPOSE = "BOMB_DISPOSE";
    GameEvent.BOMB_HIT_ENEMY = "BOMB_HIT_ENEMY";
    GameEvent.BOMB_HIT_ROLE = "BOMB_HIT_ROLE";

    class Player extends Laya.Script {
        constructor() {
            super();
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
            this._hp = 100;
            this.stillFireNum = 1;
        }
        initView() {
            Laya.Scene.load("PlayerBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.roleBody = s;
            this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player");
            this.rolePlayer.setPivot(0.5, 0.5);
            this.body = this.rolePlayer.getChildAt(0);
            this.firePos1 = this.rolePlayer.getChildAt(1);
            this.firePos2 = this.rolePlayer.getChildAt(2);
            this.firePos3 = this.rolePlayer.getChildAt(3);
            this.fireTypeCtl = this.rolePlayer.getController("fireType");
            this.fireTypeCtl.selectedIndex = 0;
            this.firePos3.visible = this.firePos1.visible = this.firePos2.visible = false;
            this.playerAni = new PlayerAni();
            this.playerAni.initView();
            this.roleBody.addChild(this.rolePlayer.displayObject);
            this.roleBody.addComponent(PlayerBody);
            this.setStay();
            this.setRight();
            Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
            Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
            Laya.stage.on(Laya.Event.MOUSE_DOWN, this, this.setFire);
            Laya.stage.on(Laya.Event.MOUSE_UP, this, this.setFireEnd);
            EventManager.instance.addNotice(GameEvent.BULLET_HIT_ROLE, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.BOMB_HIT_ROLE, this, this.beHit);
        }
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
            Laya.Tween.to(this.roleBody, { y: this.roleBody.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpEnd));
        }
        jumpEnd() {
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
            if (this.direction == 1) {
                this.roleBody.x += this.speed;
                if (this.roleBody.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.Browser.clientWidth / 2) {
                    ViewManager.instance.updateViewPort(this.speed);
                }
            }
            else {
                this.roleBody.x -= this.speed;
                if (this.roleBody.x < Math.abs(ViewManager.instance.warView.warView.x))
                    this.roleBody.x = Math.abs(ViewManager.instance.warView.warView.x);
            }
        }
        setFire() {
            if (this.sFire)
                return;
            this.sFire = true;
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
            this.fireTypeCtl.selectedIndex = this.weaponType - 1;
            Laya.timer.clear(this, this.stillFire);
            this["firePos" + this.weaponType].visible = true;
            if (this.weaponType == PlayerData.WEAPON_RIFLE) {
                var c = this["firePos" + this.weaponType].content;
                c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
            }
            else {
                Laya.timer.loop(100, this, this.stillFire);
                ViewManager.instance.createBullet();
            }
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
        rilfeComplete() {
            if (this.sFire) {
                var c = this["firePos" + this.weaponType].content;
                c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
            }
        }
        setFireEnd() {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this["firePos" + this.weaponType].visible = false;
            this.stillFireNum = 1;
            this.body.url = "ui://Game/player_stay_" + this.weaponType;
            this.body.content.setPlaySettings(0, -1, 0, 0);
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                this.bodyLeg.content.setPlaySettings(0, -1, 0, 0);
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        setBoom() {
            this.sBoom = true;
            this.body.url = "ui://Game/player_boom_" + this.weaponType;
            this.bodybody.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.setBoomComplete));
            ViewManager.instance.createBomb(PlayerData.WEAPON_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleBody), true);
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                this.bodyLeg.content.setPlaySettings(0, -1, 0, 0);
                return;
            }
            if (this.keyJump)
                this.bodyLeg.url = "ui://Game/legJump";
        }
        setBoomComplete() {
            this.sBoom = false;
            if (this.keyJump)
                return;
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
            this.sFire = false;
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
        setDeath() {
            EventManager.instance.offNotice(GameEvent.BULLET_HIT_ROLE, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.BOMB_HIT_ROLE, this, this.beHit);
            this.body.url = "ui://Game/player_death";
            this.body.content.setPlaySettings(0, -1, 1, this.body.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
        }
        deathComplete() {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH);
        }
        beHit() {
            this._hp -= 30;
            Laya.timer.clear(this, this.setColor);
            this.bodyLeg.color = "#ff0000";
            this.bodybody.color = "#ff0000";
            if (this._hp <= 0) {
                this.setDeath();
            }
            else {
                Laya.timer.once(200, this, this.setColor);
            }
            console.log("player--be--hit");
        }
        setColor() {
            this.bodyLeg.color = "#ffffff";
            this.bodybody.color = "#ffffff";
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

    class EnemyBody extends Laya.Script {
        constructor() { super(); }
        onAwake() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.selfCollider.label = "enemy";
            this.selfBody.label = "enemy";
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
        setSpeedZero() {
            this.selfBody.linearVelocity = { x: 0, y: 0 };
            this.selfBody.angularVelocity = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
            this.selfBody.linearDamping = 0;
            this.selfBody.angularDamping = 0;
            this.selfBody.setAngle({ x: 0, y: 0 });
            this.selfCollider.refresh();
        }
    }

    class Enemy {
        constructor() {
            this.enemyType = 5;
            this.direction = -1;
            this.sRun = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 10;
            this.jumpHigh = 200;
            this.hp = 100;
        }
        initView() {
            Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.scene = s;
            this.view = fairygui.UIPackage.createObject("Game", "enemy");
            this.view.setPivot(0.5, 0.5);
            this.enemyCtl = this.view.getController("ctl");
            this.enemy = this.view.getChildAt(0);
            this.enemy.url = "ui://Game/enemy" + this.enemyType;
            this.scene.addChild(this.enemy.displayObject);
            this.scene.addComponent(EnemyBody);
            this.scene.x = 1000;
            this.scene.y = 400;
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.BOMB_HIT_ENEMY, this, this.beHit);
            this.setRight();
            Laya.timer.loop(2000, this, this.setFire);
        }
        ;
        beHit() {
            this.hp -= 30;
            Laya.timer.clear(this, this.setColor);
            this.bodyLoader.color = "#ff0000";
            if (this.hp <= 0) {
                this.setDeath();
            }
            else {
                Laya.timer.once(200, this, this.setColor);
            }
        }
        setColor() {
            this.bodyLoader.color = "#ffffff";
        }
        setLeft() {
            if (this.direction == -1)
                return;
            this.direction = -1;
            this.bodyLoader.skewY = 0;
        }
        setRight() {
            if (this.direction == 1)
                return;
            this.direction = 1;
            this.bodyLoader.skewY = 180;
        }
        setIdle() {
            if (this.enemyType == PlayerData.ENEMY_PIS || this.enemyType == PlayerData.ENEMY_GRE) {
                this.bodyLoader.url = "ui://Game/enemyIdle_1";
            }
            else if (this.enemyType == PlayerData.ENEMY_MAC) {
                this.bodyLoader.url = "ui://Game/enemyIdle_2";
            }
            else if (this.enemyType == PlayerData.ENEMY_FIRE) {
                this.bodyLoader.url = "ui://Game/enemyStay_4";
            }
            else if (this.enemyType == PlayerData.ENEMY_MOR) {
                this.bodyLoader.url = "ui://Game/enemyStay_5";
            }
            else {
                this.bodyLoader.url = "ui://Game/enemyIdle_1";
            }
            this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
        }
        setRun() {
            if (this.sRun)
                return;
            this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
            this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
        }
        stillRun() {
            if (this.direction == 1) {
                this.scene.x += this.speed;
                if (this.scene.x >= Laya.Browser.clientWidth / 2) {
                    this.scene.x = Laya.Browser.clientWidth / 2;
                }
            }
            else {
                this.scene.x -= this.speed;
                if (this.scene.x < 1)
                    this.scene.x = 1;
            }
        }
        setFire() {
            Laya.timer.once(3000, this, this.setFire);
            if (this.enemyType == PlayerData.ENEMY_PIS || this.enemyType == PlayerData.ENEMY_GRE) {
                if (this.getRandomFire() == 1) {
                    this.bodyLoader.url = "ui://Game/enemy_fire_1";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
                }
                else {
                    this.bodyLoader.url = "ui://Game/enemy_fire_2";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
                }
            }
            else if (this.enemyType == PlayerData.ENEMY_MAC) {
                this.bodyLoader.url = "ui://Game/enemy_fire_3";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
            }
            else if (this.enemyType == PlayerData.ENEMY_FIRE) {
                this.bodyLoader.url = "ui://Game/enemy_fire_4";
            }
            else if (this.enemyType == PlayerData.ENEMY_MOR) {
                this.bodyLoader.url = "ui://Game/enemy_fire_5";
                this.bodyLoader.component.getChildAt(0).asMovieClip.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
                this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
            }
            else {
                console.log("没有对应的敌人攻击效果");
            }
        }
        morComplete() {
            ViewManager.instance.createBomb(PlayerData.ENEMY_MOR, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        shotComplete() {
            ViewManager.instance.createEnemyBullet(PlayerData.ENEMY_PIS, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        shot2Complete() {
            ViewManager.instance.createEnemyBullet(PlayerData.ENEMY_MAC, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        bombComplete() {
            ViewManager.instance.createBomb(PlayerData.ENEMY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        setStay() {
            this.setIdle();
        }
        setBoomComplete() {
            this.setStay();
            console.log("rengshouliudan");
        }
        setDeath() {
            this.bodyLoader.url = "ui://Game/death_" + this.enemyType;
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.BOMB_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("enenmy", this);
        }
        get component() {
            return this.enemy.component;
        }
        get bodyLoader() {
            return this.enemy.component.getChildAt(0).asLoader;
        }
        getRandomFire() {
            if (Math.random() > 0.5)
                return 1;
            return 2;
        }
    }

    class BulletBody extends Laya.Script {
        constructor() { super(); }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            console.log("oriPosX--" + this.oriPosX);
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (self.label == "PlayerBullet" && other.label == "enemy") {
                console.log("主角击中敌人-敌人ID=", other.id);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BULLET_HIT_ENEMY, this.owner);
                return;
            }
            if (self.label == "enemyBullet" && other.label == "player") {
                console.log("敌人击中主角-主角ID=", other.id);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BULLET_HIT_ROLE, this.owner);
                return;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class EnemyBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
        }
        initView(type, dir, s) {
            this.bulletType = type;
            this.direction = dir;
            this.parentPos = s;
            Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("enemyBullet.scene--loadComplete");
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.zidan = this.view.getChildAt(0).asLoader;
            this.scene = s;
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "enemyBullet";
            this.zidan.url = "ui://Game/zidan1";
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
        }
        setBulletPos() {
            var p = ViewManager.instance.getEnemyBulletOffSetPos(this.direction, this.bulletType);
            if (this.direction == 1) {
                this.view.setSkew(0, 0);
                this.body.setVelocity({ x: 10, y: 0 });
            }
            else {
                this.view.setSkew(180, 180);
                this.body.setVelocity({ x: -10, y: 0 });
            }
            this.scene.x = this.parentPos.x + p.x;
            this.scene.y = this.parentPos.y + p.y;
        }
        dispose(s) {
            if (s == this.scene) {
                EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
                Laya.Pool.recover("enemyBullet", this);
                this.view.dispose();
                console.log("销毁子弹--enemyBullet");
            }
        }
    }

    class PlayerBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
            this.speed = 35;
        }
        initView(type, dir) {
            this.bulletType = type;
            this.direction = dir;
            Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("PlayerBullet.scene--loadComplete");
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.zidan = this.view.getChildAt(0).asLoader;
            this.scene = s;
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "PlayerBullet";
            this.zidan.url = "ui://Game/zidan" + this.bulletType;
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
        }
        setBulletPos() {
            var p = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
            var y = ViewManager.instance.bulletRandomY();
            var c = ViewManager.instance.rolePlayer.roleBody.getComponent(Laya.RigidBody).getWorldCenter();
            if (this.direction == 1) {
                this.view.setSkew(0, 0);
                this.scene.x = c.x + p.x;
                this.body.setVelocity({ x: 10, y: 0 });
            }
            else {
                this.view.setSkew(180, 180);
                this.scene.x = c.x + p.x;
                this.body.setVelocity({ x: -10, y: 0 });
            }
            this.scene.y = c.y - y + p.y;
        }
        dispose(s) {
            if (s == this.scene) {
                EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
                Laya.Pool.recover("PlayerBullet", this);
                this.view.dispose();
                console.log("销毁子弹--PlayerBullet");
            }
        }
    }

    class BombBody extends Laya.Script {
        constructor() { super(); }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            console.log("oriPosX--" + this.oriPosX);
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (self.label == "PlayerBomb" && other.label == "enemy") {
                console.log("主角扔雷击中敌人-敌人ID=", other.id);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_HIT_ENEMY, this.owner);
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
                return;
            }
            if (self.label == "enemyBomb" && other.label == "player") {
                console.log("敌人扔雷击中主角-主角ID=", other.id);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_HIT_ROLE, this.owner);
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
                return;
            }
            if (other.label == "ground") {
                console.log("雷撞墙了=", this.self.x, this.self.y);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, this.owner);
                return;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class BoomBody extends Laya.Script {
        constructor() { super(); }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.CircleCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            console.log("oriPosX--" + this.oriPosX);
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class BoomView {
        constructor() {
            this.boomType = 1;
            this.direction = 1;
            this.speed = 35;
        }
        initView(type, s, b) {
            this.boomType = type;
            this.isPlayer = b;
            this.pos = s;
            Laya.Scene.load("BoomBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("boomBody.scene--loadComplete");
            this.view = fairygui.UIPackage.createObject("Game", "BoomView");
            this.boom = this.view.getChildAt(0).asLoader;
            this.scene = s;
            this.scene.addComponent(BoomBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.CircleCollider);
            if (this.isPlayer) {
                this.box.label = this.body.label = "PlayerBoom";
            }
            else {
                this.box.label = this.body.label = "enemyBoom";
            }
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.boom.url = "ui://Game/boom_" + this.boomType;
            this.boom.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.showComplete));
            this.setBoomViewPos();
        }
        setBoomViewPos() {
            this.scene.x = this.pos.x - this.scene.width / 2;
            this.scene.y = this.pos.y - this.scene.height / 2;
        }
        showComplete() {
            this.calDamage();
            this.dispose();
        }
        calDamage() {
        }
        dispose() {
            Laya.Pool.recover("boomView", this);
            this.view.dispose();
            console.log("销毁子弹--enemyBullet");
        }
    }

    class BombView {
        constructor() {
            this.bombType = 1;
            this.direction = 1;
            this.isPlayer = false;
        }
        initView(type, dir, s, p, offPos) {
            this.bombType = type;
            this.direction = dir;
            this.parentPos = s;
            this.isPlayer = p;
            this.offPos = offPos;
            Laya.Scene.load("BombBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("bomb.scene--loadComplete", this.bombType);
            this.view = fairygui.UIPackage.createObject("Game", "Bomb");
            this.bomb = this.view.getChildAt(0).asLoader;
            this.bomb2 = this.view.getChildAt(1).asLoader;
            this.bomb.visible = this.bomb2.visible = false;
            if (this.bombType == BombData.BOMB_5) {
                this.bomb.visible = true;
                this.trans = this.view.getTransitionAt(0);
            }
            else if (this.bombType == BombData.BOMB_2 || this.bombType == BombData.BOMB_1) {
                this.bomb2.visible = true;
                this.trans = this.view.getTransitionAt(1);
            }
            this.scene = s;
            this.scene.addComponent(BombBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            if (this.isPlayer) {
                this.box.label = this.body.label = "PlayerBomb";
            }
            else {
                this.box.label = this.body.label = "enemyBomb";
            }
            this.bomb2.url = this.bomb.url = "ui://Game/zhadan_" + this.bombType;
            if (this.bombType == BombData.BOMB_2)
                this.bomb2.content.setPlaySettings(0, -1, 0, 0);
            if (this.bombType != BombData.BOMB_4 && this.bombType != BombData.BOMB_5)
                this.trans.play(null, 1);
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
        }
        setBombPos() {
            if (this.direction == 1) {
                this.body.setVelocity({ x: 7, y: -6 });
                if (this.bombType == BombData.BOMB_5)
                    this.trans.play(null, 1, 0, 0, 1.25);
            }
            else {
                this.body.setVelocity({ x: -7, y: -6 });
                if (this.bombType == BombData.BOMB_5)
                    this.trans.play(null, 1, 0, 1.5, 2.75);
            }
            this.scene.x = this.parentPos.x + this.offPos.x;
            this.scene.y = this.parentPos.y + this.offPos.y;
        }
        showBoomView() {
            var bomb = Laya.Pool.getItemByClass("boomView", BoomView);
            var p = ViewManager.instance.getBodyCenterPos(this.scene);
            bomb.initView(this.getBoomType(), p, this.isPlayer);
        }
        getBoomType() {
            if (this.bombType == BombData.BOMB_1 || this.bombType == BombData.BOMB_2) {
                return 1;
            }
            else if (this.bombType == BombData.BOMB_5) {
                return 2;
            }
            else if (this.bombType == BombData.BOMB_4) {
                return 3;
            }
            return 1;
        }
        dispose(s) {
            if (s == this.scene) {
                this.showBoomView();
                EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
                Laya.Pool.recover("bombView", this);
                this.view.dispose();
                console.log("销毁炸弹--", this.bombType);
            }
        }
    }

    class ViewManager {
        constructor() {
            this.bulletArr = [];
            this.enemyArr = [];
            this.isChecking = false;
            this.playerBulletPos = {
                "11": [135, -22],
                "12": [167, 0],
                "13": [],
                "14": [20, -60],
                "-11": [-200, -22],
                "-12": [-220, 0],
                "-13": [],
                "-14": [-20, -60],
                "21": [-150, -30],
                "22": [],
                "23": [],
                "-21": [],
                "-22": [],
                "-23": [],
            };
            this.enemyBulletPos = {
                "11": [105, 10],
                "12": [10, -40],
                "13": [125, 15],
                "14": [],
                "15": [70, -20],
                "-11": [-100, 10],
                "-12": [0, -50],
                "-13": [-75, 15],
                "-14": [],
                "-15": [0, -20],
            };
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new ViewManager();
            return this._instance;
        }
        showStartView() {
            this.initView();
            console.log("开始初始化界面");
        }
        createBomb(type, dir, parentPos, b) {
            var bomb = Laya.Pool.getItemByClass("bombView", BombView);
            if (b)
                bomb.initView(BombData.BOMB_1, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, type));
            else
                bomb.initView(type, dir, parentPos, b, this.getEnemyBulletOffSetPos(dir, type));
        }
        createBullet() {
            var b = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
            b.initView(this.rolePlayer.weaponType, this.rolePlayer.direction);
        }
        createEnemyBullet(type, dir, s) {
            var b = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
            b.initView(type, dir, s);
        }
        createEnemy() {
            var b = Laya.Pool.getItemByClass("enemy", Enemy);
            b.initView();
        }
        initView() {
            this.warView = new WarView();
            this.player = new Player();
            this.warView.initView();
            this.player.initView();
        }
        get rolePlayer() {
            return this.player;
        }
        showEnemyDeathAfter() {
        }
        getBodyCenterPos(s) {
            return s.getComponent(Laya.RigidBody).getWorldCenter();
        }
        updateViewPort(moveX) {
            this.warView.updateViewPort(moveX);
        }
        bulletRandomY() {
            return Math.floor(Math.random() * 10) + 10;
        }
        getPlayerBulletOffSetPos(dir, weaponType) {
            var s = dir + "" + weaponType;
            if (this.playerBulletPos[s])
                return new Laya.Point(this.playerBulletPos[s][0], this.playerBulletPos[s][1]);
            else
                return new Laya.Point(0, 0);
        }
        getEnemyBulletOffSetPos(dir, weaponType) {
            var s = dir + "" + weaponType;
            console.log("getEnemyBulletOffSetPos--", s);
            if (this.enemyBulletPos[s])
                return new Laya.Point(this.enemyBulletPos[s][0], this.enemyBulletPos[s][1]);
            else
                return new Laya.Point(0, 0);
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
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_8.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_9.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_10.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_11.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_12.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_13.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_14.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_15.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_16.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_17.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_18.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_19.png", type: Laya.Loader.IMAGE }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
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
            Laya.init(1334, 750, Laya["WebGL"]);
            Laya["Physics"] && Laya["Physics"].enable();
            Laya["DebugPanel"] && Laya["DebugPanel"].enable();
            Laya.stage.scaleMode = Laya.Stage.SCALE_EXACTFIT;
            Laya.stage.screenMode = Laya.Stage.SCREEN_HORIZONTAL;
            Laya.stage.alignV = Laya.Stage.ALIGN_CENTER;
            Laya.stage.alignH = Laya.Stage.ALIGN_MIDDLE;
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
        }
    }
    new Main();

}());
