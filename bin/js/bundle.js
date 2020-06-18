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
    GameConfig.startScene = "map_1.scene";
    GameConfig.sceneRoot = "";
    GameConfig.debug = false;
    GameConfig.stat = false;
    GameConfig.physicsDebug = false;
    GameConfig.exportSceneToJson = true;
    GameConfig.init();

    class WarView {
        constructor() { }
        createView() {
            Laya.Scene.load("map_" + GameManager.instance.curLevelData.mapIndex + ".scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.scene = s;
            this.warView = fairygui.UIPackage.createObject("Game", "WarView");
            this.warView.m_bg.url = "res/map_" + GameManager.instance.curLevelData.mapIndex + ".jpg";
            Laya.Physics.I.worldRoot = this.scene;
            this.warView.x = GameManager.instance.curLvData.warViewPos[0];
            this.warView.y = GameManager.instance.curLvData.warViewPos[1];
            this.warView.displayObject.addChild(this.scene);
            Laya.stage.addChildAt(this.warView.displayObject, 0);
            GameManager.instance.createPlayer();
            GameManager.instance.createEnemyData();
            GameManager.instance.createObstacleData();
        }
        updateViewPort(moveX) {
            this.warView.x -= moveX;
        }
    }

    class EnemyBody extends Laya.Script {
        constructor() { super(); }
        onAwake() {
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
    GameEvent.PAUSE_GAME = "PAUSE_GAME";

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

    class GameData {
    }
    GameData.WEAPON_TYPE = 1;
    GameData.WEAPON_PIS = 1;
    GameData.WEAPON_MAC = 2;
    GameData.WEAPON_RIFLE = 3;
    GameData.WEAPON_GRE = 4;
    GameData.WEAPON_MAX = 3;
    GameData.ENEMY_PIS = 1;
    GameData.ENEMY_GRE = 2;
    GameData.ENEMY_MAC = 3;
    GameData.ENEMY_FIRE = 4;
    GameData.ENEMY_MOR = 5;
    GameData.ENEMY_CHOPPER = 10;
    GameData.ENEMY_TANK_1 = 11;
    GameData.ENEMY_TANK_2 = 12;
    class BombData {
    }
    BombData.BOMB_MY_GRE = 1;
    BombData.BOMB_ENEMY_GRE = 2;
    BombData.BOMB_CHOPPER = 3;
    BombData.BOMB_TANK = 4;
    BombData.BOMB_MOR = 5;
    class ShotDirectionData {
    }
    ShotDirectionData.LEFT = -1;
    ShotDirectionData.RIGHT = 1;
    ShotDirectionData.RIGHT_UP = 2;
    ShotDirectionData.LEFT_UP = -2;
    class ObstacleType {
    }
    ObstacleType.ObstacleType_SHABAO = 1;
    ObstacleType.ObstacleType_YOUGUAN = 2;
    ObstacleType.ObstacleType_XIAOCHE = 4;
    ObstacleType.ObstacleType_CHE = 5;
    ObstacleType.ObstacleType_DACHE = 6;
    class GoodsType {
    }
    GoodsType.GoodsType_MED = 1;
    GoodsType.GoodsType_MAC = 2;
    GoodsType.GoodsType_RIF = 3;
    GoodsType.GoodsType_GRE = 4;

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
            this.blood = 1;
            this.expRate = [];
            this.isBoss = false;
        }
        createView(d) {
            this.initData(d);
            Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        initData(d) {
            this.enemyData = d;
            this.direction = d.direction;
            this.enemyType = d.type;
            this.blood = d.blood;
            this.damage = d.damage;
            this.activeDis = d.activeDis;
            this.pos = d.pos;
            this.expRate = d.expRate.concat();
            this.isBoss = d.isBoss;
        }
        loadComplete(s) {
            this.scene = s;
            this.view = fairygui.UIPackage.createObject("Game", "enemy");
            this.view.setPivot(0.5, 0.5);
            this.enemy = this.view.getChildAt(0);
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
            EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            this.setDirection();
            Laya.timer.loop(2000, this, this.setFire);
        }
        pauseGame() {
            this.bodyLoader.playing = !GameManager.instance.isPauseGame;
            if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.component.getChildAt(0).asLoader.playing = !GameManager.instance.isPauseGame;
                this.bodyLoader.component.getChildAt(1).asMovieClip.playing = !GameManager.instance.isPauseGame;
            }
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood--;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    if (this.enemyType == GameData.ENEMY_MOR) {
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
            if (this.direction == ShotDirectionData.LEFT) {
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
            if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
                this.bodyLoader.url = "ui://Game/enemyIdle_1";
            }
            else if (this.enemyType == GameData.ENEMY_MAC) {
                this.bodyLoader.url = "ui://Game/enemyIdle_2";
            }
            else if (this.enemyType == GameData.ENEMY_FIRE) {
                this.bodyLoader.url = "ui://Game/enemyStay_4";
            }
            else if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.url = "ui://Game/enemyStay_5";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_1) {
                this.bodyLoader.url = "ui://Game/enemy11";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_2) {
                this.bodyLoader.url = "ui://Game/enemy12";
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
            if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
                if (this.getRandomFire() == 1) {
                    this.bodyLoader.url = "ui://Game/enemy_fire_1";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
                }
                else {
                    this.bodyLoader.url = "ui://Game/enemy_fire_2";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
                }
            }
            else if (this.enemyType == GameData.ENEMY_MAC) {
                this.bodyLoader.url = "ui://Game/enemy_fire_3";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
            }
            else if (this.enemyType == GameData.ENEMY_FIRE) {
                this.bodyLoader.url = "ui://Game/enemy_fire_4";
            }
            else if (this.enemyType == GameData.ENEMY_MOR) {
                this.bodyLoader.url = "ui://Game/enemy_fire_5";
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
                this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
            }
            else {
                console.log("没有对应的敌人攻击效果");
            }
        }
        morComplete() {
            ViewManager.instance.createBomb(GameData.ENEMY_MOR, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
            this.setIdle();
        }
        shotComplete() {
            ViewManager.instance.createEnemyBullet(GameData.ENEMY_PIS, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        shot2Complete() {
            ViewManager.instance.createEnemyBullet(GameData.ENEMY_MAC, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
            this.setIdle();
        }
        bombComplete() {
            ViewManager.instance.createBomb(GameData.ENEMY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
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
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.enemy.url = "ui://Game/death_" + this.getRandomDeath();
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            this.createGoods();
        }
        createGoods() {
            if (this.expRate.length > 0) {
                var p = new Laya.Point();
                p.x = this.scene.x + this.scene.width / 2;
                p.y = this.scene.y + this.scene.height / 2;
                ViewManager.instance.createGoods(1, p);
            }
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            this.scene.removeSelf();
            this.view.dispose();
            this.recover();
        }
        recover() {
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
            if (this.bulletType == GameData.ENEMY_TANK_1 || this.bulletType == GameData.ENEMY_TANK_2) {
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
            if (this.bombType == BombData.BOMB_MOR) {
                this.view.m_boom.visible = true;
                this.trans = this.view.getTransitionAt(0);
            }
            else if (this.bombType == BombData.BOMB_ENEMY_GRE || this.bombType == BombData.BOMB_MY_GRE) {
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
            if (this.bombType == BombData.BOMB_ENEMY_GRE)
                this.view.m_boom2.content.setPlaySettings(0, -1, 0, 0);
            if (this.bombType == BombData.BOMB_MY_GRE || this.bombType == BombData.BOMB_ENEMY_GRE)
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
                if (this.bombType == BombData.BOMB_MOR)
                    this.trans.play(null, 1, 0, 0, 1.25);
            }
            else {
                this.body.setVelocity({ x: -7, y: -6 });
                if (this.bombType == BombData.BOMB_MOR)
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

    class ObstacleView {
        constructor() {
            this.type = 1;
            this.direction = 0;
            this.isDeath = false;
            this.blood = 1;
        }
        createView(d) {
            this.type = d.type;
            this.blood = d.blood;
            this.pos = d.pos;
            Laya.Scene.load("ObstacleView_" + this.type + ".scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        loadComplete(s) {
            this.view = fairygui.UIPackage.createObject("Game", "obstacleView");
            this.view.setPivot(0.5, 0.5);
            this.load = this.view.getChildAt(0);
            this.scene = s;
            this.initView();
        }
        ;
        initView() {
            this.load.url = "ui://Game/obstacle_" + this.type;
            this.scene.addChild(this.view.displayObject);
            this.scene.addComponent(EnemyBody);
            this.box = this.scene.getComponent(Laya.PolygonCollider);
            this.isDeath = false;
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood--;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    this.load.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                }
            }
        }
        setColor() {
            this.load.color = "#ffffff";
        }
        setDeath() {
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.load.url = "ui://Game/boom_" + ViewManager.instance.getBoomAniTypeByObsType(this.type);
            ;
            this.load.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("obstacle", this);
        }
    }

    class Chopper extends Enemy {
        constructor() { super(); }
        createView(d) {
            super.initData(d);
            Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        setFire() {
            var p = new Laya.Point(this.view.width / 2, this.view.height);
            ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.enemy.url = "ui://Game/boom_4";
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        recover() {
            Laya.Pool.recover("chopper", this);
        }
        get component() {
            return this.enemy.component;
        }
        get bodyLoader() {
            return this.enemy.component.getChildAt(0).asLoader;
        }
    }

    class Tank extends Enemy {
        constructor() { super(); }
        createView(d) {
            super.initData(d);
            Laya.Scene.load("TankBody" + this.enemyType + ".scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        setFire() {
            this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
            this.bodyLoader.component.getChildAt(0).asMovieClip.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankShotComplete));
            ViewManager.instance.createEnemyBullet(this.enemyType, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        }
        tankShotComplete() {
            this.setIdle();
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            this.enemy.url = "ui://Game/boom_5";
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
        recover() {
            Laya.Pool.recover("tank", this);
        }
    }

    class ChopperBomb extends BombView {
        constructor() { super(); }
        createView(type, dir, s, p, offPos) {
            this.bombType = type;
            this.parentPos = s;
            this.offPos = offPos;
            Laya.Scene.load("ChopperBomb.scene", Laya.Handler.create(this, this.loadComplete));
        }
        setBombPos() {
            this.body.setVelocity({ x: 0, y: 5 });
            this.scene.x = this.parentPos.x + 165;
            this.scene.y = this.parentPos.y + 85;
        }
    }

    class GoodsView {
        constructor() {
            this.type = 1;
        }
        createView(type, s) {
            this.type = type;
            this.pos = s;
            Laya.Scene.load("GoodsBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        loadComplete(s) {
            console.log("GoodsBody.scene--loadComplete", s);
            this.scene = s;
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.view = fairygui.UIPackage.createObject("Game", "goodsView");
            this.view.m_load.url = "ui://Game/createGoodsAni";
            this.view.m_load.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniComplete));
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
        }
        createAniComplete() {
            this.view.m_load.url = "ui://Game/goods_" + this.type;
        }
        dispose(s) {
            if (s == this.box.owner) {
                EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.type);
                this.scene.removeSelf();
                this.view.dispose();
                Laya.Pool.recover("goods", this);
            }
        }
        setBombPos() {
            this.scene.x = this.pos.x + 20;
            this.scene.y = this.pos.y;
        }
    }

    class PlayerData {
    }
    PlayerData.WEAPON_TYPE = 1;
    PlayerData.WEAPON_PIS = 1;
    PlayerData.WEAPON_MAC = 2;
    PlayerData.WEAPON_RIFLE = 3;
    PlayerData.WEAPON_GRE = 4;
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
    class ObstacleInfo {
        constructor() {
        }
    }

    class PlayerInfoView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerInfoView");
            EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_GOODS, this, this.changePlayerGoods);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BULLET, this, this.usePlyerBullet);
            EventManager.instance.addNotice(GameEvent.USE_PLAYER_BOMB, this, this.decBombNum);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.decPlayerBlood);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.decPlayerBlood);
            this.updateBulletNum();
            this.updatePlayerBlood();
            this.updateGreNum();
            this.view.m_pause.onClick(this, this.pauseGame);
        }
        pauseGame() {
            GameManager.instance.suspendGame();
        }
        changePlayerGoods(t) {
            if (t == GoodsType.GoodsType_MED) {
                GameManager.instance.roleInfo.blood++;
                this.updatePlayerBlood();
            }
            else if (t == GoodsType.GoodsType_MAC) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_MAC) {
                    GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addMacNum;
                }
                else
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
                this.updateBulletNum();
            }
            else if (t == GoodsType.GoodsType_RIF) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                    GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
                }
                else
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
                this.updateBulletNum();
            }
            else if (t == GoodsType.GoodsType_GRE) {
                GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
                this.updateGreNum();
            }
        }
        decPlayerBlood() {
            GameManager.instance.roleInfo.blood--;
            this.updatePlayerBlood();
        }
        usePlyerBullet() {
            if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_PIS)
                return;
            GameManager.instance.roleInfo.bulletNum--;
            if (GameManager.instance.roleInfo.bulletNum <= 0) {
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_PIS;
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, PlayerData.WEAPON_PIS);
            }
            this.updateBulletNum();
        }
        decBombNum() {
            GameManager.instance.roleInfo.bombNum--;
            this.updateGreNum();
        }
        updateBulletNum() {
            this.view.m_bullet.text = GameManager.instance.roleInfo.bulletNum + "";
        }
        updateGreNum() {
            this.view.m_gre.text = GameManager.instance.roleInfo.bombNum + "";
        }
        updatePlayerBlood() {
            if (GameManager.instance.roleInfo.blood <= 0) {
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH);
            }
            for (let i = 3; i > 0; i--) {
                if (i <= GameManager.instance.roleInfo.blood) {
                    this.view["m_blood_" + i].visible = true;
                }
                else {
                    this.view["m_blood_" + i].visible = false;
                }
            }
        }
    }

    class PlayerCtlView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerCtlView");
        }
    }

    class WXFUI_loadingView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("loading", "loadingView"));
        }
        onConstruct() {
            this.m_n7 = (this.getChild("n7"));
            this.m_n6 = (this.getChild("n6"));
            this.m_bar = (this.getChild("bar"));
            this.m_txt = (this.getChild("txt"));
        }
    }
    WXFUI_loadingView.URL = "ui://nr80du74n8quil";

    class WXFUI_SuspendView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "SuspendView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_back = (this.getChild("back"));
            this.m_continue = (this.getChild("continue"));
            this.m_restart = (this.getChild("restart"));
        }
    }
    WXFUI_SuspendView.URL = "ui://bq3h5insn8qul6";

    class WXFUI_PopUpView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PopUpView"));
        }
        onConstruct() {
            this.m_mask = (this.getChild("mask"));
            this.m_load = (this.getChild("load"));
            this.m_t0 = this.getTransition("t0");
        }
    }
    WXFUI_PopUpView.URL = "ui://bq3h5insmtpio6";

    class PopUpView {
        constructor() {
            this.v = WXFUI_PopUpView.createInstance();
        }
        showView(showMask = true) {
            Laya.Tween.clearAll(this);
            this.v.addChild(this.view);
            fairygui.GRoot.inst.addChild(this.v);
            this.view.setPivot(0.5, 0.5);
            this.view.setScale(0.4, 0.4);
            this.tween = Laya.Tween.to(this.view, { scaleX: 1, scaleY: 1 }, 250, null, Laya.Handler.create(this, this.showComplete, [showMask]));
        }
        showComplete(s) {
            if (s) {
                console.log("showComplete---");
                this.v.m_mask.visible = true;
                this.v.m_mask.on(Laya.Event.CLICK, this, this.hideAllView);
            }
            this.view.setScale(1, 1);
        }
        hideAllView() {
            console.log("hideAllView--");
            this.v.m_mask.displayObject.off(Laya.Event.CLICK, this, this.hideAllView);
            fairygui.GRoot.inst.removeChild(this.v);
        }
    }

    class SuspendView extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_SuspendView.createInstance();
            this.view.m_back.onClick(this, this.goFirstPage);
        }
        goFirstPage() {
            GameManager.instance.goBack();
        }
    }

    class WXFUI_ChapterView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "ChapterView"));
        }
        onConstruct() {
            this.m_chapter = this.getController("chapter");
            this.m_n12 = (this.getChild("n12"));
            this.m_n14 = (this.getChild("n14"));
            this.m_map = (this.getChild("map"));
            this.m_last = (this.getChild("last"));
            this.m_next = (this.getChild("next"));
            this.m_level_1 = (this.getChild("level_1"));
            this.m_level_2 = (this.getChild("level_2"));
            this.m_level_3 = (this.getChild("level_3"));
            this.m_level_4 = (this.getChild("level_4"));
            this.m_level_5 = (this.getChild("level_5"));
            this.m_level_6 = (this.getChild("level_6"));
            this.m_level_7 = (this.getChild("level_7"));
            this.m_level_8 = (this.getChild("level_8"));
            this.m_level_9 = (this.getChild("level_9"));
            this.m_level_10 = (this.getChild("level_10"));
            this.m_title = (this.getChild("title"));
            this.m_share = (this.getChild("share"));
        }
    }
    WXFUI_ChapterView.URL = "ui://bq3h5insdr1tnw";

    class ChapterView extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_ChapterView.createInstance();
            this.view.m_title.url = "ui://Game/chapter_1";
            for (let t = 1; t <= GameManager.instance.maxLevel; t++) {
                this.view["m_level_" + t].on(Laya.Event.CLICK, this, this.chooseLevel, [t]);
            }
            this.updateView();
        }
        updateView() {
            this.view.m_last.visible = GameManager.instance.curChapter <= 1 ? false : true;
            this.view.m_next.visible = GameManager.instance.curChapter >= GameManager.instance.maxChapter ? false : true;
            for (let i = 1; i <= GameManager.instance.maxLevel; i++) {
                if (i < GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 1;
                }
                else if (i == GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 2;
                }
                else
                    this.view["m_level_" + i].m_ctl.selectedIndex = 0;
            }
        }
        chooseLevel(l) {
            console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
            if (l > GameManager.instance.gotoMaxLevel)
                return;
            GameManager.instance.choiseLevel = l;
            ViewManager.instance.showBeforeWarView();
        }
    }

    class WXFUI_AfterWar extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "AfterWar"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n20 = (this.getChild("n20"));
            this.m_coin = (this.getChild("coin"));
            this.m_n24 = (this.getChild("n24"));
            this.m_n26 = (this.getChild("n26"));
            this.m_n29 = (this.getChild("n29"));
            this.m_continue_1 = (this.getChild("continue_1"));
            this.m_continue_2 = (this.getChild("continue_2"));
            this.m_continue_3 = (this.getChild("continue_3"));
            this.m_return = (this.getChild("return"));
        }
    }
    WXFUI_AfterWar.URL = "ui://bq3h5insdr1tnq";

    class AfterWar extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_AfterWar.createInstance();
            this.view.m_continue_1.onClick(this, this.continueGame);
            this.view.m_continue_2.onClick(this, this.restartGame);
            this.view.m_continue_3.onClick(this, this.continueGameByVideo);
        }
        continueGame() {
        }
        restartGame() {
        }
        continueGameByVideo() {
        }
    }

    class WXFUI_BeforeWar extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "BeforeWar"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_item_1 = (this.getChild("item_1"));
            this.m_item_2 = (this.getChild("item_2"));
            this.m_item_3 = (this.getChild("item_3"));
            this.m_item_4 = (this.getChild("item_4"));
            this.m_enter = (this.getChild("enter"));
            this.m_n17 = (this.getChild("n17"));
        }
    }
    WXFUI_BeforeWar.URL = "ui://bq3h5insdr1tnl";

    class BeforeWar extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_BeforeWar.createInstance();
            this.view.m_enter.onClick(this, this.enterGame);
        }
        enterGame() {
            GameManager.instance.enterGame();
        }
    }

    class ViewManager {
        constructor() {
            this.bulletArr = [];
            this.enemyArr = [];
            this.isChecking = false;
            this.curPopView = [];
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
        createLoaningView() {
            this.loadingView = WXFUI_loadingView.createInstance();
            this.loadingView.m_bar.text = "0%";
            this.loadingView.m_bar.value = 0;
            Laya.stage.addChild(this.loadingView.displayObject);
        }
        setLoadongProgress(p) {
            console.log("progress--", p);
            this.loadingView.m_bar.m_title.text = Math.ceil(p * 100) + "%";
            this.loadingView.m_bar.value = p * 100;
        }
        hideLoadingView() {
            Laya.stage.removeChild(this.loadingView.displayObject);
        }
        createWarView() {
            this.warView.createView();
            this.showPlayerCtlView();
            this.showPlayerInfoView();
            this.hidePopUpView(this.beforeWar, true);
        }
        createBomb(type, dir, parentPos, b) {
            var bomb = Laya.Pool.getItemByClass("bombView", BombView);
            if (b)
                bomb.createView(BombData.BOMB_MY_GRE, dir, parentPos, b, this.getPlayerBulletOffSetPos(dir, type));
            else
                bomb.createView(type, dir, parentPos, b, this.getEnemyBulletOffSetPos(dir, type));
        }
        createChopperBomb(type, parentPos, s) {
            var bomb = Laya.Pool.getItemByClass("ChopperBomb", ChopperBomb);
            bomb.createView(type, null, parentPos, null, s);
        }
        createBullet() {
            var b = Laya.Pool.getItemByClass("PlayerBullet", PlayerBullet);
            b.createView(this.rolePlayer.weaponType, this.rolePlayer.direction);
        }
        createEnemyBullet(type, dir, s) {
            var b = Laya.Pool.getItemByClass("enemyBullet", EnemyBullet);
            b.createView(type, dir, s);
        }
        createObstacle(d) {
            var b = Laya.Pool.getItemByClass("obstacle", ObstacleView);
            b.createView(d);
        }
        createEnemy(d) {
            var b = Laya.Pool.getItemByClass("enemy", Enemy);
            b.createView(d);
        }
        createChopper(d) {
            var b = Laya.Pool.getItemByClass("chopper", Chopper);
            b.createView(d);
        }
        createTank(d) {
            var b = Laya.Pool.getItemByClass("tank", Tank);
            b.createView(d);
        }
        createGoods(type, s) {
            var b = Laya.Pool.getItemByClass("goods", GoodsView);
            b.createView(type, s);
        }
        showPlayerInfoView() {
            if (!this.playerInfoView)
                this.playerInfoView = new PlayerInfoView();
            fairygui.GRoot.inst.addChild(this.playerInfoView.view);
        }
        showPlayerCtlView() {
            if (!this.playerCtlView)
                this.playerCtlView = new PlayerCtlView();
            fairygui.GRoot.inst.addChild(this.playerCtlView.view);
        }
        showAfterWarView() {
            this.showPopUpView(this.afterWar);
        }
        showBeforeWarView() {
            this.showPopUpView(this.beforeWar);
        }
        showSuspendView() {
            this.showPopUpView(this.suspendView);
        }
        showChapterView() {
            this.chapterView.view.m_chapter.selectedIndex = GameManager.instance.curChapter - 1;
            this.showPopUpView(this.chapterView, false, true);
        }
        initView() {
            this.warView = new WarView();
            this.afterWar = new AfterWar();
            this.beforeWar = new BeforeWar();
            this.suspendView = new SuspendView();
            this.chapterView = new ChapterView();
            this.popUpView = new PopUpView();
            this.afterWar.createView();
            this.beforeWar.createView();
            this.suspendView.createView();
            this.chapterView.createView();
            Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
        }
        showPopUpView(p, showMask = true, hideOther = false) {
            if (hideOther) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var p = this.curPopView[i];
                    p.hideAllView();
                }
            }
            p.showView(showMask);
            this.curPopView.push(p);
        }
        hidePopUpView(p, all = false) {
            if (all) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var p = this.curPopView[i];
                    p.hideAllView();
                }
                this.curPopView.length = 0;
            }
            else {
                p.hideAllView();
            }
        }
        get rolePlayer() {
            return this.player;
        }
        getBodyCenterPos(s) {
            return s.getComponent(Laya.RigidBody).getWorldCenter();
        }
        updateViewPort(moveX) {
            this.warView.updateViewPort(moveX);
        }
        getBoomAniTypeByBomb(type) {
            if (type == BombData.BOMB_MY_GRE || type == BombData.BOMB_MY_GRE || type == BombData.BOMB_CHOPPER) {
                return 1;
            }
            else if (type == BombData.BOMB_MOR) {
                return 2;
            }
            else if (type == BombData.BOMB_TANK) {
                return 3;
            }
            return 1;
        }
        getBoomAniTypeByObsType(type) {
            if (type == ObstacleType.ObstacleType_SHABAO) {
                return 2;
            }
            else if (type == ObstacleType.ObstacleType_DACHE) {
                return 5;
            }
            else {
                return 3;
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
            if (other.label == "goods") {
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, other.owner);
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
            switch (keyCode) {
                case 87:
                    console.log("上");
                    break;
                case 83:
                    console.log("下");
                    break;
                case 65:
                    this.keyLeft = true;
                    this.setLeft();
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 68:
                    this.keyRight = true;
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
                if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 20)
                    return;
                if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.stage.width / 2) {
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

    class GameManager {
        constructor() {
            this.curLevel = 0;
            this.curChapter = 1;
            this.maxLevel = 10;
            this.maxChapter = 1;
            this.gotoMaxLevel = 1;
            this.choiseLevel = 1;
            this.isPauseGame = false;
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new GameManager();
            return this._instance;
        }
        startGame() {
            this.initChapterConfig();
            this.initRoleData();
            ViewManager.instance.initView();
            ViewManager.instance.showChapterView();
        }
        initChapterConfig() {
            this.curChapter = 1;
            this.levelData = Laya.loader.getRes("res/LevelData.json");
            this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
            this.maxChapter = this.levelData.maxChapter;
        }
        goPointToLevel(l) {
            this.curLevel = --l;
            this.gotoNextLevel();
        }
        enterGame() {
            this.curLevel = --this.choiseLevel;
            this.gotoNextLevel();
        }
        goBack() {
        }
        goFirstPage() {
        }
        goContinueGame() {
        }
        suspendGame() {
            this.isPauseGame = this.isPauseGame == false ? true : false;
            if (GameManager.instance.isPauseGame) {
                Laya.updateTimer.pause();
                Laya.physicsTimer.pause();
                Laya.timer.pause();
            }
            else {
                Laya.updateTimer.resume();
                Laya.physicsTimer.resume();
                Laya.timer.resume();
            }
            EventManager.instance.dispatcherEvt(GameEvent.PAUSE_GAME);
        }
        victoryGame() {
            if (this.gotoMaxLevel < this.curLevel)
                this.gotoMaxLevel = this.curLevel;
        }
        restartGame() {
            this.curLevel--;
            if (this.curLevel < 0)
                this.curLevel = 0;
            this.gotoNextLevel();
        }
        gotoNextLevel() {
            this.curLevel++;
            if (this.curLevel > this.maxLevel) {
                this.curChapter++;
            }
            if (this.levelData["chapter_" + this.curChapter]) {
                this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
                this.curLevelData = this.levelData["chapter_" + this.curChapter]["level_" + this.curLevel];
                ViewManager.instance.createWarView();
            }
        }
        initRoleData() {
            if (!this.playerInfo)
                this.playerInfo = new PlayerInfo();
            this.playerInfo.bombNum = this.levelData.role.bombNum;
            this.playerInfo.weaponType = this.levelData.role.weaponType;
            this.playerInfo.blood = this.levelData.role.blood;
            this.playerInfo.bulletNum = this.levelData.role.bulletNum;
            this.playerInfo.addBombNum = this.levelData.role.addBombNum;
            this.playerInfo.addMacNum = this.levelData.role.addMacNum;
            this.playerInfo.addRifNum = this.levelData.role.addRifNum;
            this.playerInfo.curLevel = this.playerInfo.curChapter = 1;
            this.maxChapter = this.levelData.role.maxChapter;
        }
        createPlayer() {
            if (!ViewManager.instance.rolePlayer) {
                ViewManager.instance.player = new Player();
                ViewManager.instance.player.createView();
            }
        }
        createEnemyData() {
            var enemyArr = this.curLevelData.enemyArr;
            console.log("enemyArr--", enemyArr);
            for (const key in enemyArr) {
                if (enemyArr.hasOwnProperty(key)) {
                    var t = enemyArr[key];
                    var d = new EnemyInfo();
                    d.expRate = t.expRate.concat();
                    d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                    d.activeDis = t.activeDis;
                    d.damage = t.damage;
                    d.blood = t.blood;
                    d.direction = t.direction;
                    d.isBoss = t.isBoss;
                    d.type = t.type;
                    if (d.type == GameData.ENEMY_TANK_1 || d.type == GameData.ENEMY_TANK_2) {
                        ViewManager.instance.createTank(d);
                    }
                    else if (d.type == GameData.ENEMY_CHOPPER) {
                        ViewManager.instance.createChopper(d);
                    }
                    else {
                        ViewManager.instance.createEnemy(d);
                    }
                }
            }
        }
        createObstacleData() {
            var obstacle = GameManager.instance.curLevelData.obstacle;
            console.log("obstacle--", obstacle);
            for (const key in obstacle) {
                if (obstacle.hasOwnProperty(key)) {
                    var t = obstacle[key];
                    var d = new ObstacleInfo();
                    d.pos = new Laya.Point(t.pos[0], t.pos[1]);
                    d.blood = t.blood;
                    d.type = t.type;
                    ViewManager.instance.createObstacle(d);
                }
            }
        }
        get roleInfo() {
            return this.playerInfo;
        }
        set curLevelData(l) {
            this.curLvData = l;
        }
        get curLevelData() {
            return this.curLvData;
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
        loadLoadingAssetsData() {
            AssetsManager.loadingAssetsData.push({ url: "res/loading_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/loading_atlas_n8quey.jpg", type: Laya.Loader.IMAGE }, { url: "res/loading.wxfui", type: Laya.Loader.BUFFER });
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
        }
        loadingAssetsComplete() {
            fairygui.UIPackage.addPackage("res/loading");
            console.log("loading界面资源加载完成--显示loading界面，并开始加载游戏资源");
            ViewManager.instance.createLoaningView();
            this.loadAssetsData();
        }
        loadAssetsData() {
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun7.png", type: Laya.Loader.IMAGE }, { url: "res/LevelData.json", type: Laya.Loader.JSON }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
            console.log(AssetsManager.assetsData);
            Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete), Laya.Handler.create(this, this.onloadingProgress));
        }
        onloadingProgress(progress) {
            ViewManager.instance.setLoadongProgress(progress);
        }
        loadComplete() {
            fairygui.UIPackage.addPackage("res/Game");
            console.log("资源加载完成");
            ViewManager.instance.hideLoadingView();
            GameManager.instance.startGame();
        }
    }
    AssetsManager.assetsData = [];
    AssetsManager.loadingAssetsData = [];

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
            this.m_n4 = (this.getChild("n4"));
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

    class WXFUI_backHomeBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "backHomeBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_backHomeBtn.URL = "ui://bq3h5insdr1tni";

    class WXFUI_restartBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "restartBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
            this.m_n4 = (this.getChild("n4"));
        }
    }
    WXFUI_restartBtn.URL = "ui://bq3h5insdr1tnj";

    class WXFUI_buyItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "buyItem"));
        }
        onConstruct() {
            this.m_n2 = (this.getChild("n2"));
            this.m_n4 = (this.getChild("n4"));
            this.m_n5 = (this.getChild("n5"));
            this.m_buy = (this.getChild("buy"));
            this.m_coin = (this.getChild("coin"));
            this.m_free = (this.getChild("free"));
            this.m_n9 = (this.getChild("n9"));
            this.m_info = (this.getChild("info"));
        }
    }
    WXFUI_buyItem.URL = "ui://bq3h5insdr1tnm";

    class WXFUI_enterBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enterBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_enterBtn.URL = "ui://bq3h5insdr1tnn";

    class WXFUI_buyBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "buyBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_buyBtn.URL = "ui://bq3h5insdr1tno";

    class WXFUI_freeBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "freeBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_freeBtn.URL = "ui://bq3h5insdr1tnp";

    class WXFUI_backBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "backBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_backBtn.URL = "ui://bq3h5insdr1tnr";

    class WXFUI_continueBtn2 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn2"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n5 = (this.getChild("n5"));
        }
    }
    WXFUI_continueBtn2.URL = "ui://bq3h5insdr1tns";

    class WXFUI_continueBtn3 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn3"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_continueBtn3.URL = "ui://bq3h5insdr1tnt";

    class WXFUI_continueBtn4 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "continueBtn4"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_continueBtn4.URL = "ui://bq3h5insdr1tnu";

    class WXFUI_LevelItem extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "LevelItem"));
        }
        onConstruct() {
            this.m_ctl = this.getController("ctl");
            this.m_n12 = (this.getChild("n12"));
            this.m_n13 = (this.getChild("n13"));
            this.m_n14 = (this.getChild("n14"));
            this.m_n15 = (this.getChild("n15"));
        }
    }
    WXFUI_LevelItem.URL = "ui://bq3h5insdr1tnx";

    class WXFUI_lastChapter extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "lastChapter"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_lastChapter.URL = "ui://bq3h5insdr1tnz";

    class WXFUI_nextChapter extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "nextChapter"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_nextChapter.URL = "ui://bq3h5insdr1to0";

    class WXFUI_share extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "share"));
        }
        onConstruct() {
            this.m_n2 = (this.getChild("n2"));
            this.m_share1 = (this.getChild("share1"));
            this.m_share2 = (this.getChild("share2"));
        }
    }
    WXFUI_share.URL = "ui://bq3h5insdr1to2";

    class WXFUI_shareBtn1 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "shareBtn1"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_shareBtn1.URL = "ui://bq3h5insdr1to3";

    class WXFUI_shareBtn2 extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "shareBtn2"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n6 = (this.getChild("n6"));
        }
    }
    WXFUI_shareBtn2.URL = "ui://bq3h5insdr1to4";

    class WXFUI_enemy11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy11"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy11.URL = "ui://bq3h5insdx35l4";

    class WXFUI_enemy12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy12"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy12.URL = "ui://bq3h5insdx35l5";

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

    class WXFUI_PlayerInfoView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerInfoView"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_n2 = (this.getChild("n2"));
            this.m_n3 = (this.getChild("n3"));
            this.m_n4 = (this.getChild("n4"));
            this.m_blood_1 = (this.getChild("blood_1"));
            this.m_blood_2 = (this.getChild("blood_2"));
            this.m_blood_3 = (this.getChild("blood_3"));
            this.m_n7 = (this.getChild("n7"));
            this.m_pause = (this.getChild("pause"));
            this.m_coin = (this.getChild("coin"));
            this.m_bullet = (this.getChild("bullet"));
            this.m_gre = (this.getChild("gre"));
        }
    }
    WXFUI_PlayerInfoView.URL = "ui://bq3h5insiasdkz";

    class WXFUI_PlayerCtlView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "PlayerCtlView"));
        }
        onConstruct() {
            this.m_ctl = (this.getChild("ctl"));
            this.m_fire = (this.getChild("fire"));
            this.m_jump = (this.getChild("jump"));
            this.m_bomb = (this.getChild("bomb"));
        }
    }
    WXFUI_PlayerCtlView.URL = "ui://bq3h5insiasdl0";

    class WXFUI_dirCtlView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "dirCtlView"));
        }
        onConstruct() {
            this.m_bg = (this.getChild("bg"));
            this.m_dirBtn = (this.getChild("dirBtn"));
        }
    }
    WXFUI_dirCtlView.URL = "ui://bq3h5insiasdl1";

    class WXFUI_dirBtn extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "dirBtn"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_dirBtn.URL = "ui://bq3h5insiasdl2";

    class WXFUI_susBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "susBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n3 = (this.getChild("n3"));
        }
    }
    WXFUI_susBtn.URL = "ui://bq3h5insiasdl3";

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
        }
    }
    WXFUI_WarView.URL = "ui://bq3h5insoqgwam";

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
    WXFUI_goodsView.URL = "ui://bq3h5insqz5ukq";

    class WXFUI_enemy10 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy10"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy10.URL = "ui://bq3h5insqz5ukr";

    class WXFUI_enemy_fire_11 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_11"));
        }
        onConstruct() {
            this.m_tank = (this.getChild("tank"));
            this.m_fire = (this.getChild("fire"));
        }
    }
    WXFUI_enemy_fire_11.URL = "ui://bq3h5insqz5uks";

    class WXFUI_enemy_fire_12 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_12"));
        }
        onConstruct() {
            this.m_tank = (this.getChild("tank"));
            this.m_fire = (this.getChild("fire"));
        }
    }
    WXFUI_enemy_fire_12.URL = "ui://bq3h5insqz5ukt";

    class WXFUI_obstacleView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "obstacleView"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_obstacleView.URL = "ui://bq3h5insqz5uku";

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
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_jumpBtn.URL, WXFUI_jumpBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fireBtn.URL, WXFUI_fireBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_throwBtn.URL, WXFUI_throwBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_1.URL, WXFUI_player_stay_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_2.URL, WXFUI_player_stay_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemyStay_5.URL, WXFUI_enemyStay_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_5.URL, WXFUI_enemy_fire_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy5.URL, WXFUI_enemy5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_3.URL, WXFUI_player_stay_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_backHomeBtn.URL, WXFUI_backHomeBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_restartBtn.URL, WXFUI_restartBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BeforeWar.URL, WXFUI_BeforeWar);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_buyItem.URL, WXFUI_buyItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enterBtn.URL, WXFUI_enterBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_buyBtn.URL, WXFUI_buyBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_freeBtn.URL, WXFUI_freeBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_AfterWar.URL, WXFUI_AfterWar);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_backBtn.URL, WXFUI_backBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn2.URL, WXFUI_continueBtn2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn3.URL, WXFUI_continueBtn3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_continueBtn4.URL, WXFUI_continueBtn4);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_ChapterView.URL, WXFUI_ChapterView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_LevelItem.URL, WXFUI_LevelItem);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_lastChapter.URL, WXFUI_lastChapter);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_nextChapter.URL, WXFUI_nextChapter);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_share.URL, WXFUI_share);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_shareBtn1.URL, WXFUI_shareBtn1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_shareBtn2.URL, WXFUI_shareBtn2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy11.URL, WXFUI_enemy11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy12.URL, WXFUI_enemy12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Bomb.URL, WXFUI_Bomb);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerInfoView.URL, WXFUI_PlayerInfoView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerCtlView.URL, WXFUI_PlayerCtlView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirCtlView.URL, WXFUI_dirCtlView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirBtn.URL, WXFUI_dirBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_susBtn.URL, WXFUI_susBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BoomView.URL, WXFUI_BoomView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_3.URL, WXFUI_player_fire_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_1.URL, WXFUI_player_fire_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_2.URL, WXFUI_player_fire_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Player.URL, WXFUI_Player);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_boom_1.URL, WXFUI_player_boom_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_boom_2.URL, WXFUI_player_boom_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PopUpView.URL, WXFUI_PopUpView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_SuspendView.URL, WXFUI_SuspendView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy1.URL, WXFUI_enemy1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy2.URL, WXFUI_enemy2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy3.URL, WXFUI_enemy3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy4.URL, WXFUI_enemy4);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy.URL, WXFUI_enemy);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_WarView.URL, WXFUI_WarView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_goodsView.URL, WXFUI_goodsView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy10.URL, WXFUI_enemy10);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_11.URL, WXFUI_enemy_fire_11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_12.URL, WXFUI_enemy_fire_12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_obstacleView.URL, WXFUI_obstacleView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet1.URL, WXFUI_bullet1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet2.URL, WXFUI_bullet2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_zidan.URL, WXFUI_zidan);
        }
    }

    class WXFUI_loadingBar extends fairygui.GProgressBar {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("loading", "loadingBar"));
        }
        onConstruct() {
            this.m_n0 = (this.getChild("n0"));
            this.m_bar = (this.getChild("bar"));
            this.m_title = (this.getChild("title"));
        }
    }
    WXFUI_loadingBar.URL = "ui://nr80du74n8quim";

    class loadingBinder {
        static bindAll() {
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingView.URL, WXFUI_loadingView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingBar.URL, WXFUI_loadingBar);
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
            loadingBinder.bindAll();
            AssetsManager.instance.loadLoadingAssetsData();
        }
        onVersionLoaded() {
            Laya.AtlasInfoManager.enable("fileconfig.json", Laya.Handler.create(this, this.onConfigLoaded));
        }
        onConfigLoaded() {
        }
    }
    new Main();

}());
