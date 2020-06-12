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
    GameConfig.startScene = "Obstacle3.scene";
    GameConfig.sceneRoot = "";
    GameConfig.debug = false;
    GameConfig.stat = false;
    GameConfig.physicsDebug = false;
    GameConfig.exportSceneToJson = true;
    GameConfig.init();

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
    PlayerData.ENEMY_CHOPPER = 10;
    PlayerData.ENEMY_TANKE = 11;
    PlayerData.ADD_MAC_BULLET = 200;
    PlayerData.ADD_RIFLE_BULLET = 50;
    PlayerData.ADD_BOMB_NUM = 10;
    class BombData {
    }
    BombData.BOMB_1 = 1;
    BombData.BOMB_2 = 2;
    BombData.BOMB_3 = 3;
    BombData.BOMB_4 = 4;
    BombData.BOMB_5 = 5;
    class BoomAniType {
    }
    BoomAniType.BOOM_1 = 1;
    BoomAniType.BOOM_2 = 2;
    BoomAniType.BOOM_3 = 3;
    BoomAniType.BOOM_4 = 4;
    BoomAniType.BOOM_5 = 5;
    class ObstacleType {
    }
    ObstacleType.ObstacleType_1 = 1;
    ObstacleType.ObstacleType_2 = 2;
    ObstacleType.ObstacleType_3 = 3;
    ObstacleType.ObstacleType_4 = 4;
    ObstacleType.ObstacleType_5 = 5;
    ObstacleType.ObstacleType_6 = 6;
    class ShotDirectionData {
    }
    ShotDirectionData.LEFT = -1;
    ShotDirectionData.RIGHT = 1;
    ShotDirectionData.RIGHT_UP = 2;
    ShotDirectionData.LEFT_UP = -2;
    class GoodsType {
    }
    GoodsType.GoodsType_MAC = 1;
    GoodsType.GoodsType_MED = 2;
    GoodsType.GoodsType_RIF = 3;
    GoodsType.GoodsType_GRE = 4;

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
    GameEvent.PLAYER_JUMP = "PLAYER_JUMP";
    GameEvent.PLAYER_COLLISION_GROUND = "PLAYER_COLLISION_GROUND";
    GameEvent.PLAYER_BULLET_HIT_ENEMY = "PLAYER_BULLET_HIT_ENEMY";
    GameEvent.PLAYER_BULLET_HIT_OBSTACLE = "PLAYER_BULLET_HIT_OBSTACLE";
    GameEvent.ENEMY_BULLET_HIT_PLAYER = "ENEMY_BULLET_HIT_PLAYER";
    GameEvent.BOMB_DISPOSE = "BOMB_DISPOSE";
    GameEvent.PLAYER_BOMB_HIT_ENEMY = "PLAYER_BOMB_HIT_ENEMY";
    GameEvent.PLAYER_BOMB_HIT_OBSTACLE = "PLAYER_BOMB_HIT_OBSTACLE";
    GameEvent.ENEMY_BOMB_HIT_PLAYER = "ENEMY_BOMB_HIT_PLAYER";
    GameEvent.PLAYER_GET_GOODS = "PLAYER_GET_GOODS";
    GameEvent.CHANGE_PLAYER_GOODS = "CHANGE_PLAYER_GOODS";
    GameEvent.CHANGE_PLAYER_WEAPON = "CHANGE_PLAYER_WEAPON";
    GameEvent.ADD_PLAYER_BOMB = "ADD_PLAYER_BOMB";
    GameEvent.ADD_PLAYER_BLOOD = "ADD_PLAYER_BLOOD";
    GameEvent.DEC_PLAYER_BLOOD = "DEC_PLAYER_BLOOD";
    GameEvent.USE_PLAYER_BOMB = "USE_PLAYER_BOMB";
    GameEvent.USE_PLAYER_BULLET = "USE_PLAYER_BULLET";

    class PlayerBody extends Laya.Script {
        constructor() {
            super();
            this.isJump = false;
            this.jumpEnd = false;
        }
        onEnable() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            EventManager.instance.addNotice(GameEvent.PLAYER_JUMP, this, this.jump);
        }
        jump() {
            this.isJump = true;
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            this.lastBox = other;
            if (other.label == "ground" && this.jumpEnd) {
                console.log("jumpend");
                this.isJump = false;
                this.jumpEnd = false;
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
                this.setSpeedZero();
            }
        }
        onTriggerExit() {
            console.log("onTriggerExit--");
            if (this.lastBox.label == "ground" && this.isJump) {
                console.log("jumpstart");
                this.jumpEnd = true;
            }
        }
        onTriggerStay(other, self, contact) {
            if (this.isJump == false) {
                this.setSpeedZero();
            }
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
            this.stillFireNum = 1;
        }
        createView() {
            Laya.Scene.load("PlayerBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.roleSprite = s;
            this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player");
            this.rolePlayer.setPivot(0.5, 0.5);
            ViewManager.instance.warView.scene.addChild(this.roleSprite);
            var d = GameManager.instance.curLvData;
            this.roleSprite.x = d.rolePos[0];
            this.roleSprite.y = d.rolePos[1];
            this.body = this.rolePlayer.getChildAt(0);
            this.rolePlayer.m_fireType.selectedIndex = 0;
            this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = this.rolePlayer.m_firePos3.visible = false;
            this.roleBody = this.roleSprite.getComponent(Laya.RigidBody);
            this.roleSprite.addChild(this.rolePlayer.displayObject);
            this.roleSprite.addComponent(PlayerBody);
            this.setStay();
            this.setRight();
            Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
            Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
            Laya.stage.on(Laya.Event.MOUSE_DOWN, this, this.setFire);
            Laya.stage.on(Laya.Event.MOUSE_UP, this, this.setFireEnd);
            EventManager.instance.addNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);
            EventManager.instance.addNotice(GameEvent.PLAYER_DEATH, this, this.setDeath);
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
                    this.setJump();
                    break;
                case 81:
                    console.log("扔雷");
                    if (this.sBoom)
                        return;
                    if (GameManager.instance.roleInfo.bombNum <= 0)
                        return;
                    this.setBoom();
                    break;
                case 69:
                    console.log("切枪");
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
        colliGround() {
            if (this.keyJump)
                this.jumpEnd();
        }
        setJump() {
            this.setBoomComplete();
            this.keyJump = true;
            this.bodyLeg.url = "ui://Game/legJump";
            this.roleBody.setVelocity({ x: 0, y: -10 });
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_JUMP);
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
                this.roleSprite.x += this.speed;
                if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.Browser.clientWidth / 2) {
                    ViewManager.instance.updateViewPort(this.speed);
                }
            }
            else {
                this.roleSprite.x -= this.speed;
                if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                    this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
            }
        }
        setFire() {
            if (this.sFire)
                return;
            if (this.sBoom)
                return;
            this.sFire = true;
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
            this.rolePlayer.m_fireType.selectedIndex = this.weaponType - 1;
            Laya.timer.clear(this, this.stillFire);
            this.rolePlayer["m_firePos" + this.weaponType].visible = true;
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
            if (this.weaponType == PlayerData.WEAPON_RIFLE) {
                var c = this.rolePlayer["m_firePos" + this.weaponType].content;
                c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
            }
            else {
                Laya.timer.loop(120, this, this.stillFire);
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
            if (this.sBoom)
                return;
            this.stillFireNum++;
            if (this.stillFireNum % 2 == 0) {
                this.rolePlayer["m_firePos" + this.weaponType].visible = false;
            }
            else {
                this.rolePlayer["m_firePos" + this.weaponType].visible = true;
                ViewManager.instance.createBullet();
            }
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
        }
        rilfeComplete() {
            if (this.sFire) {
                var c = this.rolePlayer["m_firePos" + this.weaponType].content;
                c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
            }
        }
        setFireEnd() {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.rolePlayer["m_firePos" + this.weaponType].visible = false;
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
            this.rolePlayer["m_firePos" + this.weaponType].visible = false;
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);
            this.body.url = "ui://Game/player_boom_" + this.weaponType;
            this.bodybody.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.setBoomComplete));
            ViewManager.instance.createBomb(PlayerData.WEAPON_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
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
        changeWeaponType(type) {
            this.weaponType = GameManager.instance.roleInfo.weaponType = type;
            if (this.sFire) {
                this.body.url = "ui://Game/player_fire_" + this.weaponType;
            }
            else
                this.body.url = "ui://Game/player_stay_" + this.weaponType;
        }
        setDeath() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
            GameManager.instance.roleInfo.isDeath = true;
            Laya.timer.clearAll(this);
            EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
            this.body.url = "ui://Game/player_death";
            this.body.content.setPlaySettings(0, -1, 1, this.body.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
        }
        deathComplete() {
        }
        beHit() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
            Laya.timer.clear(this, this.setColor);
            this.bodyLeg.color = "#ff0000";
            this.bodybody.color = "#ff0000";
            Laya.timer.once(200, this, this.setColor);
            console.log("player--be--hit");
        }
        setColor() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
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

    class WarView {
        constructor() { }
        createView() {
            Laya.Scene.load("map_1.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.scene = s;
            this.warView = fairygui.UIPackage.createObject("Game", "WarView");
            Laya.Physics.I.worldRoot = this.scene;
            this.warView.displayObject.addChild(this.scene);
            Laya.stage.addChildAt(this.warView.displayObject, 0);
            this.initRole();
            this.initEnemy();
            ViewManager.instance.createPlayerInfoView();
        }
        initRole() {
            if (!ViewManager.instance.rolePlayer) {
                ViewManager.instance.player = new Player();
                ViewManager.instance.player.createView();
            }
        }
        initEnemy() {
            var enemyArr = GameManager.instance.curLvData.enemy.concat();
            console.log("enemyArr--", enemyArr);
            for (let i = 0; i < enemyArr.length; i++) {
                var t = enemyArr[i];
                var d = new EnemyInfo();
                d.expRate = t.expRate.concat();
                d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                d.activeDis = t.activeDis;
                d.damage = t.damage;
                d.blood = t.blood;
                d.dir = t.dir;
                d.isBoss = t.isBoss;
                d.type = t.type;
                if (d) {
                    ViewManager.instance.createEnemy(d);
                }
            }
        }
        updateViewPort(moveX) {
            this.warView.x -= moveX;
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
            this.direction = 0;
            this.sRun = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.speed = 10;
            this.jumpHigh = 200;
            this.isDeath = false;
            this.hp = 1;
            this.expRate = [];
            this.isBoss = false;
        }
        createView(d) {
            this.enemyData = d;
            this.direction = d.dir;
            this.enemyType = d.type;
            this.hp = d.blood;
            this.damage = d.damage;
            this.activeDis = d.activeDis;
            this.pos = d.pos;
            this.expRate = d.expRate.concat();
            this.isBoss = d.isBoss;
            Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.view = fairygui.UIPackage.createObject("Game", "enemy");
            this.view.setPivot(0.5, 0.5);
            this.enemy = this.view.getChildAt(0);
            this.scene = s;
            this.initView();
        }
        ;
        initView() {
            this.enemy.url = "ui://Game/enemy" + this.enemyType;
            this.scene.addChild(this.enemy.displayObject);
            this.scene.addComponent(EnemyBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.isDeath = false;
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            this.setDirection();
            Laya.timer.loop(2000, this, this.setFire);
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.hp--;
                Laya.timer.clear(this, this.setColor);
                if (this.hp <= 0) {
                    this.setDeath();
                }
                else {
                    if (this.enemyType == PlayerData.ENEMY_MOR) {
                        this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                        this.bodyLoader.component.getChildAt(1).asMovieClip.color = "#ff0000";
                    }
                    else
                        this.bodyLoader.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                }
            }
        }
        setColor() {
            this.bodyLoader.color = "#ffffff";
        }
        setDirection() {
            if (this.direction == -1) {
                this.bodyLoader.skewY = 0;
            }
            else {
                this.bodyLoader.skewY = 180;
            }
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
            else if (this.enemyType == PlayerData.ENEMY_TANKE) {
                this.bodyLoader.url = "ui://Game/enemy11";
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
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
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
        tankeComplete() {
        }
        setStay() {
            this.setIdle();
        }
        setBoomComplete() {
            this.setStay();
            console.log("rengshouliudan");
        }
        setDeath() {
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.bodyLoader.url = "ui://Game/death_" + this.enemyType;
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            var p = new Laya.Point();
            p.x = this.scene.x + this.scene.width / 2;
            p.y = this.scene.y + this.scene.height / 2;
            ViewManager.instance.createGoods(1, p);
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
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
        getRandomDeath() {
            var r = Math.random();
            if (r > 0.75)
                return 4;
            if (r > 0.5)
                return 3;
            if (r > 0.25)
                return 2;
            return 1;
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
            if (self.label == "PlayerBullet") {
                if (other.label == "enemy") {
                    console.log("主角子弹击中敌人-敌人ID=", other.id);
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_ENEMY, { o: other.owner, s: self.owner });
                }
                else if (other.label == "obstacle") {
                    console.log("主角子弹击中障碍物", other.id);
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, { o: other.owner, s: self.owner });
                }
                return;
            }
            else if (self.label == "enemyBullet") {
                if (other.label == "player") {
                    console.log("敌人子弹击中主角--ID=", other.id, self.id);
                    this.selfCollider.destroy();
                    EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BULLET_HIT_PLAYER, { o: other.owner, s: self.owner });
                }
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
        createView(type, dir, s) {
            this.bulletType = type;
            this.direction = dir;
            this.parentPos = s;
            Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.scene = s;
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "enemyBullet";
            console.log("enemyBullet.scene--loadComplete", this.box.id);
            if (this.bulletType == PlayerData.ENEMY_TANKE) {
                this.view.m_zidan.url = "ui://Game/zhadan_4";
            }
            else
                this.view.m_zidan.url = "ui://Game/zidan3";
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
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
        bulletHitPlayer(s) {
            if (s.s == this.box.owner) {
                EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
                EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            console.log("enemyBullet--disposeAll");
            Laya.Pool.recover("enemyBullet", this);
            this.view.displayObject.destroy();
            this.scene.removeSelf();
            console.log("销毁子弹--enemyBullet");
        }
        dispose(s) {
            if (s == this.box.owner) {
                EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
                EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
                this.disposeAll();
            }
        }
    }

    class PlayerBullet {
        constructor() {
            this.bulletType = 1;
            this.direction = 1;
            this.speed = 35;
        }
        createView(type, dir) {
            this.bulletType = type;
            this.direction = dir;
            Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("PlayerBullet.scene--loadComplete");
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.scene = s;
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "PlayerBullet";
            this.view.m_zidan.url = "ui://Game/zidan" + this.bulletType;
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        }
        hitEnemy(s) {
            if (s.s == this.box.owner) {
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
            Laya.Pool.recover("PlayerBullet", this);
            this.view.dispose();
            this.scene.removeSelf();
            console.log("销毁子弹--PlayerBullet");
        }
        setBulletPos() {
            var p = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
            var y = ViewManager.instance.bulletRandomY();
            var c = ViewManager.instance.rolePlayer.roleSprite.getComponent(Laya.RigidBody).getWorldCenter();
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
            if (self.label == "PlayerBomb") {
                if (other.label == "enemy") {
                    console.log("主角扔雷击中敌人-敌人ID=", other.id);
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner });
                    this.owner.removeSelf();
                }
                else if (other.label == "obstacle") {
                    console.log("主角扔雷击中障碍物", other.id);
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, { o: other.owner, s: self.owner });
                }
            }
            else if (self.label == "enemyBomb" && other.label == "player") {
                console.log("敌人扔雷击中主角-主角ID=", other.id);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BOMB_HIT_PLAYER, { o: other.owner, s: self.owner });
                return;
            }
            if (other.label == "ground") {
                console.log("雷撞墙了=", this.self.x, this.self.y);
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.BOMB_DISPOSE, { o: other.owner, s: self.owner });
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
        createView(type, s, b) {
            this.boomType = type;
            this.isPlayer = b;
            this.pos = s;
            Laya.Scene.load("BoomBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("boomBody.scene--loadComplete");
            this.view = fairygui.UIPackage.createObject("Game", "BoomView");
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
            this.view.m_boom.url = "ui://Game/boom_" + this.boomType;
            this.view.m_boom.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.showComplete));
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
            this.scene.removeSelf();
            console.log("销毁子弹--enemyBullet");
        }
    }

    class BombView {
        constructor() {
            this.bombType = 1;
            this.direction = 1;
            this.isPlayer = false;
        }
        createView(type, dir, s, p, offPos) {
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
            this.view.m_boom.visible = this.view.m_boom2.visible = false;
            if (this.bombType == BombData.BOMB_5) {
                this.view.m_boom.visible = true;
                this.trans = this.view.getTransitionAt(0);
            }
            else if (this.bombType == BombData.BOMB_2 || this.bombType == BombData.BOMB_1) {
                this.view.m_boom2.visible = true;
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
            this.view.m_boom.url = this.view.m_boom2.url = "ui://Game/zhadan_" + this.bombType;
            if (this.bombType == BombData.BOMB_2)
                this.view.m_boom2.content.setPlaySettings(0, -1, 0, 0);
            if (this.bombType != BombData.BOMB_4 && this.bombType != BombData.BOMB_5)
                this.trans.play(null, 1);
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
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
            bomb.createView(ViewManager.instance.getBoomAniTypeByBomb(this.bombType), p, this.isPlayer);
        }
        dispose(s) {
            if (s.s == this.box.owner) {
                this.showBoomView();
                EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
                EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
                EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
                Laya.Pool.recover("bombView", this);
                this.view.dispose();
                this.scene.removeSelf();
                console.log("销毁炸弹--", this.bombType);
            }
        }
    }

    class ChopperView extends Enemy {
        constructor() { super(); }
        createView() {
            this.enemyType = PlayerData.ENEMY_CHOPPER;
            Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        initView() {
            super.initView();
            this.bodyLoader.x = this.bodyLoader.y = 0;
            this.bodyLoader.url = "ui://Game/chopperAni";
        }
        setFire() {
            Laya.timer.once(3000, this, this.setFire);
            var p = new Laya.Point();
            p.x = this.scene.width / 2;
            p.y = this.scene.height;
            ViewManager.instance.createChopperBomb(BombData.BOMB_3, ViewManager.instance.getBodyCenterPos(this.scene), p);
        }
        setStay() {
            this.setIdle();
        }
        setDeath() {
            this.bodyLoader.url = "ui://Game/boom_5";
            this.bodyLoader.x = (this.scene.width - this.bodyLoader.width) / 2;
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("Chopper", this);
        }
    }

    class TankeView extends Enemy {
        constructor() { super(); }
        createView() {
            Laya.Scene.load("TankeBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        initView() {
            super.initView();
            this.bodyLoader.x = this.bodyLoader.y = 0;
            this.bodyLoader.url = "ui://Game/enemy" + this.enemyType;
            this.setRight();
        }
        setFire() {
            Laya.timer.once(3000, this, this.setFire);
            this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
            this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankeComplete));
            ViewManager.instance.createEnemyBullet(PlayerData.ENEMY_TANKE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        }
        tankeComplete() {
            this.setIdle();
        }
        setDeath() {
            this.bodyLoader.url = "ui://Game/boom_3";
            this.bodyLoader.x = 68;
            this.bodyLoader.y = -218;
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("Tanke", this);
        }
    }

    class ChopperBomb {
        constructor() {
            this.bombType = 1;
        }
        createView(type, s, offPos) {
            this.bombType = type;
            this.parentPos = s;
            this.offPos = offPos;
            Laya.Scene.load("BombBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("chopperbomb.scene--loadComplete", this.bombType);
            this.scene = s;
            this.view = fairygui.UIPackage.createObject("Game", "Bomb");
            this.view.m_boom.visible = true;
            this.view.m_boom2.visible = false;
            this.scene.addComponent(BombBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "enemyBomb";
            this.view.m_boom2.url = this.view.m_boom.url = "ui://Game/zhadan_" + this.bombType;
            this.view.x = -18;
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
        }
        setBombPos() {
            this.body.setVelocity({ x: 0, y: 1 });
            this.scene.x = this.parentPos.x + this.offPos.x;
            this.scene.y = this.parentPos.y + this.offPos.y;
        }
        showBoomView() {
            var bomb = Laya.Pool.getItemByClass("boomView", BoomView);
            var p = ViewManager.instance.getBodyCenterPos(this.scene);
            bomb.createView(ViewManager.instance.getBoomAniTypeByBomb(this.bombType), p, false);
        }
        dispose(s) {
            if (s == this.scene) {
                this.showBoomView();
                EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
                Laya.Pool.recover("bombView", this);
                this.view.dispose();
                this.scene.removeSelf();
                console.log("销毁炸弹--", this.bombType);
            }
        }
    }

    class GoodsBody extends Laya.Script {
        constructor() { super(); }
        onEnable() {
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (other.label == "player") {
                console.log("主角子获得物品-物品ID=", other.id);
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, self.owner);
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
    }

    class GoodsView {
        constructor() {
            this.goodsType = 1;
        }
        createView(type, s) {
            this.goodsType = type;
            this.parentPos = s;
            Laya.Scene.load("GoodsBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("GoodsBody.scene--loadComplete");
            this.scene = s;
            this.scene.addComponent(GoodsBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.view = fairygui.UIPackage.createObject("Game", "goodsView");
            this.createAni = fairygui.UIPackage.createObject("Game", "createGoodsAni");
            this.createAni.x = -this.createAni.width / 2 + 25;
            this.createAni.y = -this.createAni.height / 2;
            this.scene.addChild(this.view.displayObject);
            this.scene.addChild(this.createAni.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setGoodsPos();
            this.view.m_load.url = "ui://Game/goods_" + this.goodsType;
            this.view.m_load.visible = false;
            this.createAni.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniCom));
            EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.getGoodsHandle);
        }
        createAniCom() {
            this.scene.removeChild(this.createAni.displayObject);
            this.view.m_load.visible = true;
        }
        setGoodsPos() {
            this.scene.x = this.parentPos.x;
            this.scene.y = this.parentPos.y;
        }
        getGoodsHandle(s) {
            if (s == this.box.owner) {
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.goodsType);
                EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.getGoodsHandle);
                Laya.Pool.recover("goods", this);
                this.view.dispose();
                this.scene.removeSelf();
                console.log("销毁获得的物品--goods");
            }
        }
    }

    class PlayerInfoView {
        constructor() { }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerInfoView");
            Laya.stage.addChildAt(this.view.displayObject, 1);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.decRoleBlood);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BOMB, this, this.decRoleBombNum);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BULLET, this, this.usePlayerBullet);
            EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_GOODS, this, this.changePlayerGoods);
            this.resetData();
        }
        resetData() {
            this.updateBombNum();
            this.updateBulletNum();
            this.updateRoleBoold();
        }
        changePlayerGoods(type) {
            if (type == GoodsType.GoodsType_MAC) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                    GameManager.instance.roleInfo.bulletNum = this.bulletNum = GameManager.instance.roleInfo.bulletNum + PlayerData.ADD_MAC_BULLET;
                }
                else {
                    GameManager.instance.roleInfo.bulletNum = this.bulletNum = PlayerData.ADD_MAC_BULLET;
                    EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_MAC);
                }
                this.updateBulletNum();
            }
            else if (type == GoodsType.GoodsType_MED) {
                this.addRoleBlood();
            }
            else if (type == GoodsType.GoodsType_RIF) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                    GameManager.instance.roleInfo.bulletNum = this.bulletNum = GameManager.instance.roleInfo.bulletNum + PlayerData.ADD_RIFLE_BULLET;
                }
                else {
                    GameManager.instance.roleInfo.bulletNum = this.bulletNum = PlayerData.ADD_RIFLE_BULLET;
                    EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_RIFLE);
                }
                this.updateBulletNum();
            }
            else if (type == GoodsType.GoodsType_GRE) {
                GameManager.instance.roleInfo.bombNum = this.bombNum += PlayerData.ADD_BOMB_NUM;
                this.updateBombNum();
            }
        }
        usePlayerBullet() {
            this.bulletNum = GameManager.instance.roleInfo.bulletNum--;
            if (GameManager.instance.roleInfo.bulletNum <= 0) {
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_PIS;
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_PIS);
            }
            this.updateBulletNum();
        }
        updateBulletNum() {
            this.view.m_info.m_bulletNum.text = this.bulletNum + "";
        }
        updateBombNum() {
            this.view.m_info.m_bombNum.text = GameManager.instance.roleInfo.bombNum + "";
        }
        addRoleBlood() {
            GameManager.instance.roleInfo.blood++;
            this.updateRoleBoold();
        }
        decRoleBlood() {
            GameManager.instance.roleInfo.blood--;
            this.updateRoleBoold();
        }
        updateRoleBoold() {
            if (GameManager.instance.roleInfo.isDeath)
                return;
            if (GameManager.instance.roleInfo.blood <= 0) {
                GameManager.instance.roleInfo.isDeath = true;
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH);
            }
            for (let i = 3; i > 0; i--) {
                if (i <= GameManager.instance.roleInfo.blood) {
                    this.view.m_info["m_blood_" + i].visible = true;
                }
                else {
                    this.view.m_info["m_blood_" + i].visible = false;
                }
            }
        }
        decRoleBombNum() {
            GameManager.instance.roleInfo.bombNum--;
            if (GameManager.instance.roleInfo.bombNum <= 0)
                GameManager.instance.roleInfo.bombNum = 0;
            this.updateBombNum();
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
                "111": [165, 15],
                "-11": [-100, 10],
                "-12": [0, -50],
                "-13": [-75, 15],
                "-14": [],
                "-15": [0, -20],
                "-111": [0, 15],
            };
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new ViewManager();
            return this._instance;
        }
        createWarView() {
            this.warView.createView();
        }
        createBomb(type, dir, parentPos, b) {
            var bomb = Laya.Pool.getItemByClass("bombView", BombView);
            if (b)
                bomb.createView(BombData.BOMB_1, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, type));
            else
                bomb.createView(type, dir, parentPos, b, this.getEnemyBulletOffSetPos(dir, type));
        }
        createChopperBomb(type, parentPos, s) {
            var bomb = Laya.Pool.getItemByClass("ChopperBomb", ChopperBomb);
            bomb.createView(type, parentPos, s);
        }
        createBullet() {
            var b = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
            b.createView(this.rolePlayer.weaponType, this.rolePlayer.direction);
        }
        createEnemyBullet(type, dir, s) {
            var b = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
            b.createView(type, dir, s);
        }
        createEnemy(d) {
            var b = Laya.Pool.getItemByClass("enemy", Enemy);
            b.createView(d);
        }
        createChopper() {
            var b = Laya.Pool.getItemByClass("Chopper", ChopperView);
            b.createView();
        }
        createTanke(type) {
            var b = Laya.Pool.getItemByClass("Tanke", TankeView);
            b.enemyType = type;
            b.createView();
        }
        createGoods(type, s) {
            var b = Laya.Pool.getItemByClass("goods", GoodsView);
            b.createView(type, s);
        }
        createPlayerInfoView() {
            var b = new PlayerInfoView();
            b.createView();
        }
        initView() {
            this.warView = new WarView();
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
        getBoomAniTypeByBomb(type) {
            if (type == BombData.BOMB_1 || type == BombData.BOMB_2) {
                return BoomAniType.BOOM_1;
            }
            else if (type == BombData.BOMB_5) {
                return BoomAniType.BOOM_2;
            }
            else if (type == BombData.BOMB_4) {
                return BoomAniType.BOOM_3;
            }
            return 1;
        }
        getBoomAniTypeByObsType(type) {
            if (type == ObstacleType.ObstacleType_1) {
                return BoomAniType.BOOM_2;
            }
            else if (type == ObstacleType.ObstacleType_6) {
                return BoomAniType.BOOM_5;
            }
            else {
                return BoomAniType.BOOM_3;
            }
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
            this.curLevel = 0;
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new GameManager();
            return this._instance;
        }
        startGame() {
            this.playerInfo = new PlayerInfo();
            this.initConfig();
            ViewManager.instance.initView();
            this.gotoNextLevel();
        }
        gotoNextLevel() {
            this.curLevel++;
            this.curLvData = this.levelData["level_" + this.curLevel];
            ViewManager.instance.createWarView();
        }
        initConfig() {
            this.levelData = Laya.loader.getRes("res/LevelData.json");
            this.playerInfo.bombNum = this.levelData.role.bombNum;
            this.playerInfo.weaponType = this.levelData.role.weaponType;
            this.playerInfo.blood = this.levelData.role.blood;
            this.playerInfo.bulletNum = this.levelData.role.bulletNum;
        }
        get roleInfo() {
            return this.playerInfo;
        }
        getLevelData(l) {
        }
    }
    class PlayerInfo {
        constructor() {
        }
    }
    class EnemyInfo {
        constructor() {
            this.expRate = [];
            this.isBoss = false;
        }
    }

    class AssetsManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new AssetsManager();
            return this._instance;
        }
        loadAssetsData() {
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/LevelData.json", type: Laya.Loader.JSON }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
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

    class WXFUI_PlayerInfoView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerInfoView"));
        }
        onConstruct() {
            this.m_dirCtl = (this.getChild("dirCtl"));
            this.m_fireBtn = (this.getChild("fireBtn"));
            this.m_jump = (this.getChild("jump"));
            this.m_throw = (this.getChild("throw"));
            this.m_info = (this.getChild("info"));
            this.m_susBtn = (this.getChild("susBtn"));
        }
    }
    WXFUI_PlayerInfoView.URL = "ui://bq3h5inscqp93g";

    class WXFUI_dirCtl extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "dirCtl"));
        }
        onConstruct() {
            this.m_n7 = (this.getChild("n7"));
            this.m_funBtn = (this.getChild("funBtn"));
        }
    }
    WXFUI_dirCtl.URL = "ui://bq3h5inscqp93k";

    class WXFUI_jumpBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "jumpBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
        }
    }
    WXFUI_jumpBtn.URL = "ui://bq3h5inscqp93n";

    class WXFUI_fireBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "fireBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_fireBtn.URL = "ui://bq3h5inscqp93o";

    class WXFUI_throwBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "throwBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_throwBtn.URL = "ui://bq3h5inscqp93p";

    class WXFUI_player_stay_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_1.URL = "ui://bq3h5inscqp93w";

    class WXFUI_player_stay_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_2.URL = "ui://bq3h5inscqp940";

    class WXFUI_enemyStay_5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemyStay_5"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
            this.m_people = (this.getChild("people"));
        }
    }
    WXFUI_enemyStay_5.URL = "ui://bq3h5insdhktei";

    class WXFUI_enemy_fire_5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_5"));
        }
        onConstruct() {
            this.m_mor = (this.getChild("mor"));
            this.m_people = (this.getChild("people"));
        }
    }
    WXFUI_enemy_fire_5.URL = "ui://bq3h5insdhktej";

    class WXFUI_enemy5 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy5"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy5.URL = "ui://bq3h5insdhktem";

    class WXFUI_player_stay_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_3.URL = "ui://bq3h5insdhkten";

    class WXFUI_obstacle extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "obstacle"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_obstacle.URL = "ui://bq3h5insdhktfx";

    class WXFUI_enemy10 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy10"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy10.URL = "ui://bq3h5insdnw6gf";

    class WXFUI_enemy11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy11"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy11.URL = "ui://bq3h5insdnw6gi";

    class WXFUI_enemy_fire_11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_11"));
        }
        onConstruct() {
            this.m_fire = (this.getChild("fire"));
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy_fire_11.URL = "ui://bq3h5insdnw6h3";

    class WXFUI_enemy12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy12"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy12.URL = "ui://bq3h5inset35h4";

    class WXFUI_enemy_fire_12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_12"));
        }
        onConstruct() {
            this.m_fire = (this.getChild("fire"));
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy_fire_12.URL = "ui://bq3h5inset35h5";

    class WXFUI_dirBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "dirBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_dirBtn.URL = "ui://bq3h5insfmzphk";

    class WXFUI_infoView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "infoView"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_blood1 = (this.getChild("blood1"));
            this.m_blood_1 = (this.getChild("blood_1"));
            this.m_blood2 = (this.getChild("blood2"));
            this.m_blood_2 = (this.getChild("blood_2"));
            this.m_blood3 = (this.getChild("blood3"));
            this.m_blood_3 = (this.getChild("blood_3"));
            this.m_bulletNum = (this.getChild("bulletNum"));
            this.m_bombNum = (this.getChild("bombNum"));
            this.m_goldNum = (this.getChild("goldNum"));
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_infoView.URL = "ui://bq3h5insfmzphx";

    class WXFUI_suspendBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "suspendBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n0 = (this.getChild("n0"));
        }
    }
    WXFUI_suspendBtn.URL = "ui://bq3h5insfmzphz";

    class WXFUI_goodsView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "goodsView"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_goodsView.URL = "ui://bq3h5insfmzpik";

    class WXFUI_Bomb extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "Bomb"));
        }
        onConstruct() {
            this.m_boom = (this.getChild("boom"));
            this.m_boom2 = (this.getChild("boom2"));
            this.m_z2 = this.getTransition("z2");
            this.m_t3 = this.getTransition("t3");
        }
    }
    WXFUI_Bomb.URL = "ui://bq3h5insgww20";

    class WXFUI_BoomView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "BoomView"));
        }
        onConstruct() {
            this.m_boom = (this.getChild("boom"));
        }
    }
    WXFUI_BoomView.URL = "ui://bq3h5inske5wdt";

    class WXFUI_player_fire_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_3.URL = "ui://bq3h5inske5wdy";

    class WXFUI_player_fire_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_1.URL = "ui://bq3h5insmsdc5j";

    class WXFUI_player_fire_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_2.URL = "ui://bq3h5insmsdc5k";

    class WXFUI_Player extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "Player"));
        }
        onConstruct() {
            this.m_firePos = this.getController("firePos");
            this.m_fireType = this.getController("fireType");
            this.m_body = (this.getChild("body"));
            this.m_firePos1 = (this.getChild("firePos1"));
            this.m_firePos2 = (this.getChild("firePos2"));
            this.m_firePos3 = (this.getChild("firePos3"));
        }
    }
    WXFUI_Player.URL = "ui://bq3h5insmsdc6j";

    class WXFUI_player_boom_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_boom_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_boom_1.URL = "ui://bq3h5insmsdc6k";

    class WXFUI_player_boom_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_boom_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_boom_2.URL = "ui://bq3h5insmsdc6l";

    class WXFUI_enemy1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy1"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy1.URL = "ui://bq3h5insoqgw9y";

    class WXFUI_enemy2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy2"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy2.URL = "ui://bq3h5insoqgwa0";

    class WXFUI_enemy3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy3"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy3.URL = "ui://bq3h5insoqgwa1";

    class WXFUI_enemy4 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy4"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy4.URL = "ui://bq3h5insoqgwa2";

    class WXFUI_enemy extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy"));
        }
        onConstruct() {
            this.m_enemy = (this.getChild("enemy"));
        }
    }
    WXFUI_enemy.URL = "ui://bq3h5insoqgwa5";

    class WXFUI_WarView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "WarView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_box2 = (this.getChild("box2"));
        }
    }
    WXFUI_WarView.URL = "ui://bq3h5insoqgwam";

    class WXFUI_bullet1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "bullet1"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_bullet1.URL = "ui://bq3h5insyqv7at";

    class WXFUI_bullet2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "bullet2"));
        }
        onConstruct() {
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_bullet2.URL = "ui://bq3h5insyqv7au";

    class WXFUI_zidan extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "zidan"));
        }
        onConstruct() {
            this.m_zidan = (this.getChild("zidan"));
        }
    }
    WXFUI_zidan.URL = "ui://bq3h5insyqv7ax";

    class GameBinder {
        static bindAll() {
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerInfoView.URL, WXFUI_PlayerInfoView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirCtl.URL, WXFUI_dirCtl);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_jumpBtn.URL, WXFUI_jumpBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fireBtn.URL, WXFUI_fireBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_throwBtn.URL, WXFUI_throwBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_1.URL, WXFUI_player_stay_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_2.URL, WXFUI_player_stay_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemyStay_5.URL, WXFUI_enemyStay_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_5.URL, WXFUI_enemy_fire_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy5.URL, WXFUI_enemy5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_3.URL, WXFUI_player_stay_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_obstacle.URL, WXFUI_obstacle);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy10.URL, WXFUI_enemy10);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy11.URL, WXFUI_enemy11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_11.URL, WXFUI_enemy_fire_11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy12.URL, WXFUI_enemy12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_12.URL, WXFUI_enemy_fire_12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirBtn.URL, WXFUI_dirBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_infoView.URL, WXFUI_infoView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_suspendBtn.URL, WXFUI_suspendBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_goodsView.URL, WXFUI_goodsView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Bomb.URL, WXFUI_Bomb);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BoomView.URL, WXFUI_BoomView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_3.URL, WXFUI_player_fire_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_1.URL, WXFUI_player_fire_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_2.URL, WXFUI_player_fire_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Player.URL, WXFUI_Player);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_boom_1.URL, WXFUI_player_boom_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_boom_2.URL, WXFUI_player_boom_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy1.URL, WXFUI_enemy1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy2.URL, WXFUI_enemy2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy3.URL, WXFUI_enemy3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy4.URL, WXFUI_enemy4);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy.URL, WXFUI_enemy);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_WarView.URL, WXFUI_WarView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet1.URL, WXFUI_bullet1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet2.URL, WXFUI_bullet2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_zidan.URL, WXFUI_zidan);
        }
    }

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
            GameBinder.bindAll();
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
