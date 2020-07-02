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
    GameConfig.startScene = "ObstacleView_5.scene";
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
            ViewManager.instance.createPlayer();
            GameManager.instance.createEnemyData();
            GameManager.instance.createObstacleData();
            this.warView.x = GameManager.instance.curLvData.warViewPos[0];
            this.warView.y = GameManager.instance.curLvData.warViewPos[1];
            this.warView.displayObject.addChild(this.scene);
            Laya.stage.addChildAt(this.warView.displayObject, 0);
        }
        updateViewPort(moveX) {
            this.warView.x -= moveX;
        }
        dispose() {
            if (this.scene) {
                this.scene.removeChildren();
                this.scene.removeSelf();
            }
            if (this.warView) {
                this.warView.displayObject.removeChildren();
                this.warView.dispose();
            }
            this.recover();
        }
        recover() {
            Laya.Pool.recover("warView", this);
        }
        removeView() {
            this.warView.displayObject.removeChild(this.scene);
            Laya.stage.removeChild(this.warView.displayObject);
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
    GameEvent.PLAYER_JUMP = "PLAYER_JUMP";
    GameEvent.PLAYER_RUN = "PLAYER_RUN";
    GameEvent.PLAYER_STAY = "PLAYER_STAY";
    GameEvent.PLAYER_COLLISION_GROUND = "PLAYER_COLLISION_GROUND";
    GameEvent.BULLET_DISPOSE = "BULLET_DISPOSE";
    GameEvent.PLAYER_BULLET_HIT_ENEMY = "PLAYER_BULLET_HIT_ENEMY";
    GameEvent.PLAYER_BULLET_HIT_OBSTACLE = "PLAYER_BULLET_HIT_OBSTACLE";
    GameEvent.ENEMY_BULLET_HIT_PLAYER = "ENEMY_BULLET_HIT_PLAYER";
    GameEvent.ACTIVE_ENEMY = "ACTIVE_ENEMY";
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
    GameEvent.VICITORY_LEVEL = "VICITORY_LEVEL";
    GameEvent.BUY_SHOP_ITEM = "BUY_SHOP_ITEM";
    GameEvent.BUY_SHOP_ITEM_FREE = "BUY_SHOP_ITEM_FREE";
    GameEvent.CLEAR_WAR_VIEW = "CLEAR_WAR_VIEW";

    class PlayerBody extends Laya.Script {
        constructor() {
            super();
            this.playerState = 0;
            this.startJump = false;
            this.keyJump = false;
        }
        onEnable() {
            console.log("onEnableonEnableonEnableonEnableonEnable");
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
        }
        jump() {
            this.keyJump = true;
            this.playerState = 2;
            this.setSpeedZero();
        }
        run() {
            this.playerState = 1;
            this.setSpeedZero();
        }
        death() {
        }
        stay() {
            this.playerState = 0;
            this.setSpeedZero();
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            this.setSpeedZero();
            if ((other.label == "ground" || other.label == "obstacle" || other.label == "board") && this.keyJump) {
                this.keyJump = false;
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_COLLISION_GROUND);
            }
            if (other.label == "goods") {
                EventManager.instance.dispatcherEvt(GameEvent.PLAYER_GET_GOODS, other.owner);
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
        }
        setSpeedZero() {
            if (Laya.Physics.I.world == null)
                return;
            if (this.keyJump) {
                this.selfBody.linearVelocity = { x: 0, y: 0 };
                this.selfBody.angularVelocity = 0;
                this.selfBody.angularDamping = 0;
                this.selfBody.linearDamping = 0;
                this.selfBody.setVelocity({ x: 0, y: 6 });
            }
            else {
                this.selfBody.linearVelocity = { x: 0, y: 0 };
                this.selfBody.angularVelocity = 0;
                this.selfBody.angularDamping = 0;
                this.selfBody.linearDamping = 0;
                this.selfBody.setVelocity({ x: 0, y: 0 });
            }
            this.selfCollider.refresh();
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
            this.blood = 0;
            this.bulletNum = 0;
            this.bombNum = 0;
            this.weaponType = 0;
            this.isDeath = false;
            this.addMacNum = 0;
            this.addBombNum = 0;
            this.addRifNum = 0;
            this.curChapter = 0;
            this.curLevel = 0;
            this.totalCoin = 0;
            this.curlvCoin = 0;
            this.direction = 0;
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

    class GameData {
    }
    GameData.WEAPON_PIS = 1;
    GameData.WEAPON_MAC = 2;
    GameData.WEAPON_RIFLE = 3;
    GameData.WEAPON_GRE = 4;
    GameData.ENEMY_PIS = 1;
    GameData.ENEMY_GRE = 2;
    GameData.ENEMY_MAC = 3;
    GameData.ENEMY_FIRE = 4;
    GameData.ENEMY_MOR = 5;
    GameData.ENEMY_JUNGUAN = 6;
    GameData.ENEMY_CHOPPER = 10;
    GameData.ENEMY_TANK_1 = 11;
    GameData.ENEMY_TANK_2 = 12;
    GameData.ENEMY_TANK_3 = 13;
    GameData.ENEMY_TANK_4 = 14;
    GameData.RANDOM_COIN = 200;
    GameData.BOMB_DAMAGE = 5;
    GameData.SOUND_FONT = "res/sound/";
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
    ObstacleType.ObstacleType_MICHE = 3;
    ObstacleType.ObstacleType_DACHE = 4;
    ObstacleType.ObstacleType_CHE = 5;
    ObstacleType.ObstacleType_6 = 6;
    ObstacleType.ObstacleType_7 = 7;
    ObstacleType.ObstacleType_8 = 8;
    ObstacleType.ObstacleType_9 = 9;
    ObstacleType.ObstacleType_10 = 10;
    ObstacleType.ObstacleType_11 = 11;
    class GoodsType {
    }
    GoodsType.GoodsType_MED = 1;
    GoodsType.GoodsType_MAC = 2;
    GoodsType.GoodsType_RIF = 3;
    GoodsType.GoodsType_GRE = 4;
    GoodsType.GoodsType_COIN = 5;

    class SoundManager {
        constructor() {
            this.isOpenSound = true;
        }
        static get instance() {
            if (this._instance == null) {
                this._instance = new SoundManager();
                Laya.SoundManager.useAudioMusic = false;
            }
            return this._instance;
        }
        playSound(n) {
            var s = GameData.SOUND_FONT + n + ".mp3";
            Laya.SoundManager.playSound(s);
        }
        playBGM() {
            Laya.SoundManager.playMusic("res/sound/bgm.mp3");
        }
        stopBGM() {
            Laya.SoundManager.stopMusic();
        }
        offSound() {
            this.isOpenSound = !this.isOpenSound;
            if (this.isOpenSound) {
                Laya.SoundManager.setMusicVolume(1);
                Laya.SoundManager.setSoundVolume(1);
            }
            else {
                Laya.SoundManager.setMusicVolume(0);
                Laya.SoundManager.setSoundVolume(0);
            }
        }
    }

    class PlayerCtlView {
        constructor() { this.createView(); }
        createView() {
            this.view = fairygui.UIPackage.createObject("Game", "PlayerCtlView");
        }
    }

    class Player extends Laya.Script {
        constructor() {
            super();
            this.direction = 1;
            this.sRun = false;
            this.sFire = false;
            this.sBoom = false;
            this.keyRight = false;
            this.keyLeft = false;
            this.keyJump = false;
            this.stillRifle = false;
            this.speed = 5;
            this.jumpHigh = 200;
            this.weaponType = 1;
            this.faceType = 1;
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
            this.body = this.rolePlayer.getChildAt(0);
            this.rolePlayer.m_fireType.selectedIndex = 0;
            this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = this.rolePlayer.m_firePos3.visible = false;
            this.roleBody = this.roleSprite.getComponent(Laya.RigidBody);
            this.roleCol = this.roleSprite.getComponent(Laya.BoxCollider);
            this.roleSprite.addChild(this.rolePlayer.displayObject);
            this.roleSprite.addComponent(PlayerBody);
            this.bodyScript = this.roleSprite.getComponent(PlayerBody);
            if (!this.playerCtlView)
                this.playerCtlView = new PlayerCtlView();
            fairygui.GRoot.inst.addChild(this.playerCtlView.view);
            EventManager.instance.addNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);
            EventManager.instance.addNotice(GameEvent.PLAYER_DEATH, this, this.setDeath);
            Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
            Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
            this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_DOWN, this, this.setFire);
            this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_UP, this, this.setFireEnd);
            this.playerCtlView.view.m_bomb.on(Laya.Event.CLICK, this, this.onClickBomb);
            this.playerCtlView.view.m_jump.on(Laya.Event.CLICK, this, this.onClickJump);
            this.playerCtlView.view.m_ctl.m_mask.on(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
            this.playerCtlView.view.m_ctl.m_mask.on(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
            Laya.stage.on(Laya.Event.MOUSE_UP, this, this.addStageMouseUp);
            this.addCtlViewMouseUp();
            this.resetPos();
        }
        resetPos() {
            var d = GameManager.instance.curLvData;
            this.roleSprite.x = d.rolePos[0];
            this.roleSprite.y = d.rolePos[1];
            this.weaponType = GameManager.instance.roleInfo.weaponType;
            ViewManager.instance.warView.scene.addChild(this.roleSprite);
        }
        addCtlViewMouseUp() {
            this.playerCtlView.view.m_ctl.m_dirBtn.y = this.playerCtlView.view.m_ctl.m_dirBtn.x = 0;
            this.setStay();
        }
        addMouseDown(e) {
            this.setDirection();
            this.playerCtlView.view.m_ctl.m_mask.on(Laya.Event.MOUSE_MOVE, this, this.setDirection);
        }
        setDirection() {
            var pos = this.playerCtlView.view.m_ctl.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY);
            pos.x += 131;
            pos.y += 131;
            this.playerCtlView.view.m_ctl.m_dirBtn.x = pos.x;
            this.playerCtlView.view.m_ctl.m_dirBtn.y = pos.y;
            if (pos.x > 130)
                this.playerCtlView.view.m_ctl.m_dirBtn.x = 130;
            if (pos.x < -130)
                this.playerCtlView.view.m_ctl.m_dirBtn.x = -130;
            if (pos.y > 130)
                this.playerCtlView.view.m_ctl.m_dirBtn.y = 130;
            if (pos.y < -130)
                this.playerCtlView.view.m_ctl.m_dirBtn.y = -130;
            this.faceType = GameManager.instance.roleInfo.direction = ViewManager.instance.getPlayerDirection(pos);
            if (this.faceType > 0) {
                this.rolePlayer.skewY = 180;
                this.keyRight = true;
                this.keyLeft = false;
                if (this.faceType == 1) {
                    this.direction = 1;
                    this.setRightRun();
                }
                else {
                    this.sRun = false;
                    Laya.timer.clear(this, this.stillRun);
                }
            }
            else {
                this.keyLeft = true;
                this.keyRight = false;
                this.rolePlayer.skewY = 0;
                if (this.faceType == -1) {
                    this.direction = -1;
                    this.setLeftRun();
                }
                else {
                    this.sRun = false;
                    Laya.timer.clear(this, this.stillRun);
                }
            }
            this.setPlayerDir();
        }
        addStageMouseUp() {
            this.playerCtlView.view.m_ctl.m_mask.off(Laya.Event.MOUSE_MOVE, this, this.setDirection);
        }
        keyUpEvent(e) {
            var keyCode = e["keyCode"];
            switch (keyCode) {
                case 87:
                    this.setFireEnd();
                    break;
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
                    this.setFire();
                    console.log("上");
                    break;
                case 83:
                    console.log("下");
                    break;
                case 65:
                    this.keyLeft = true;
                    this.rolePlayer.skewY = 0;
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 68:
                    this.keyRight = true;
                    this.rolePlayer.skewY = 180;
                    if (this.sRun)
                        return;
                    this.setRun();
                    this.stillRun();
                    break;
                case 32:
                    break;
                case 81:
                    break;
                case 69:
                    console.log("切枪");
                    break;
            }
        }
        onClickBomb() {
            console.log("扔雷");
            if (this.sBoom)
                return;
            if (GameManager.instance.roleInfo.bombNum <= 0)
                return;
            this.setBoom();
        }
        onClickJump() {
            console.log("跳");
            if (this.keyJump)
                return;
            this.setJump();
        }
        setLeftRun() {
            if (this.sRun)
                return;
            this.setRun();
            this.stillRun();
        }
        setRightRun() {
            if (this.sRun)
                return;
            this.setRun();
            this.stillRun();
        }
        setPlayerDir() {
            if (!this.sFire) {
                this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
            }
            else {
                this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
            }
        }
        colliGround() {
            if (this.keyJump)
                this.jumpEnd();
        }
        setJump() {
            this.keyJump = true;
            this.setBoomComplete();
            this.bodyLeg.url = "ui://Game/legJump";
            this.jummpTween = Laya.Tween.to(this.roleSprite, { y: this.roleSprite.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpHighHandle));
        }
        jumpHighHandle() {
            this.bodyScript.keyJump = true;
        }
        jumpEnd() {
            console.log("PLAYER_COLLISION_GROUND---");
            this.keyJump = false;
            if (this.sBoom) {
                this.setBoomComplete();
            }
            else if (this.sFire) {
                this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + this.direction;
            }
            if (this.sRun) {
                this.bodyLeg.url = "ui://Game/legMove";
                this.bodyLeg.content.rewind();
                return;
            }
            this.stopMove();
        }
        setRun() {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_RUN);
            if (this.sFire) {
                this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
            }
            else {
                this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
            }
            this.bodyLeg.url = "ui://Game/legMove";
            this.sRun = true;
            Laya.timer.clear(this, this.stillRun);
            Laya.timer.frameLoop(1, this, this.stillRun);
        }
        stillRun() {
            if (this.direction == 1) {
                this.roleSprite.x += this.speed;
                if (this.roleSprite.x > ViewManager.instance.warView.warView.width - this.roleSprite.width - 20)
                    this.roleSprite.x = ViewManager.instance.warView.warView.width - this.roleSprite.width - 20;
                if (GameManager.instance.bossDeath) {
                    if (this.roleSprite.x > ViewManager.instance.warView.warView.width - 450) {
                        GameManager.instance.victoryGame();
                    }
                }
                if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 20)
                    return;
                if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.stage.width / 2) {
                    ViewManager.instance.updateViewPort(this.speed);
                }
            }
            else if (this.direction == -1) {
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
            if (this.stillRifle)
                return;
            this.playWeaponSound();
            this.sFire = true;
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
            this.rolePlayer.m_fireType.selectedIndex = this.weaponType - 1;
            this.setFireAniSkew();
            Laya.timer.clear(this, this.stillFire);
            this.rolePlayer["m_firePos" + this.weaponType].visible = true;
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
            var b = ViewManager.instance.createBullet();
            if (this.weaponType == PlayerData.WEAPON_RIFLE) {
                this.stillRifle = true;
                Laya.timer.once(700, this, this.rilfeComplete);
                Laya.timer.loop(800, this, this.stillFire);
            }
            else {
                this.stillRifle = false;
                Laya.timer.loop(150, this, this.stillFire);
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
            this.setFireAniSkew();
            this.stillFireNum++;
            if (this.stillFireNum % 2 == 0) {
                this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
            }
            else {
                this.rolePlayer["m_firePos" + this.weaponType].visible = true;
            }
            ViewManager.instance.createBullet();
            if (this.weaponType != PlayerData.WEAPON_PIS) {
                EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
            }
            this.playWeaponSound();
        }
        setFireAniSkew() {
            this.rolePlayer.m_firePos.selectedIndex = Math.abs(this.faceType) - 1;
            if (Math.abs(this.faceType) == 1) {
                this.rolePlayer.m_firePos1.setSkew(180, 180);
                this.rolePlayer.m_firePos2.setSkew(180, 180);
            }
            else if (Math.abs(this.faceType) == 2) {
                this.rolePlayer.m_firePos1.setSkew(160, 160);
                this.rolePlayer.m_firePos2.setSkew(160, 160);
            }
            else if (Math.abs(this.faceType) == 3) {
                this.rolePlayer.m_firePos1.setSkew(200, 200);
                this.rolePlayer.m_firePos2.setSkew(200, 200);
            }
        }
        rilfeComplete() {
            this.stillRifle = false;
        }
        setFireEnd() {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.stillFireNum = 1;
            this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
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
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);
            this.body.url = "ui://Game/player_boom_" + this.weaponType;
            this.bodybody.content.setPlaySettings(0, -1, 1, -1);
            Laya.timer.once(700, this, this.setBoomComplete);
            ViewManager.instance.createBomb(PlayerData.WEAPON_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
        }
        setBoomComplete() {
            this.sBoom = false;
            if (this.sFire)
                this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
            else
                this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        }
        stopMove() {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_STAY);
            this.keyLeft = false;
            this.keyRight = false;
            this.sRun = false;
            this.bodyLeg.url = "ui://Game/legStay";
            Laya.timer.clear(this, this.stillRun);
        }
        setStay() {
            if (this.faceType > 0) {
                this.direction = 1;
                this.rolePlayer.skewY = 180;
            }
            else {
                this.direction = -1;
                this.rolePlayer.skewY = 0;
            }
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
            Laya.timer.clear(this, this.stillFire);
            this.stopMove();
        }
        changeWeaponType(type) {
            this.weaponType = GameManager.instance.roleInfo.weaponType = type;
            if (this.sFire) {
                Laya.timer.clear(this, this.stillFire);
                this.sFire = false;
                this.setFire();
            }
            else
                this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
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
            this.playDeathSound();
        }
        playDeathSound() {
            var s = 1;
            var r = Math.random();
            if (r > 0.75)
                s = 4;
            if (r > 0.5)
                s = 3;
            if (r > 0.25)
                s = 2;
            s = 1;
            SoundManager.instance.playSound("die_" + s);
        }
        playWeaponSound() {
            SoundManager.instance.playSound("weapon_" + this.weaponType);
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
        dispose() {
            this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_DOWN, this, this.setFire);
            this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_UP, this, this.setFireEnd);
            this.playerCtlView.view.m_bomb.off(Laya.Event.CLICK, this, this.onClickBomb);
            this.playerCtlView.view.m_jump.off(Laya.Event.CLICK, this, this.onClickJump);
            this.playerCtlView.view.m_ctl.m_mask.off(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
            this.playerCtlView.view.m_ctl.m_mask.off(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
            Laya.stage.off(Laya.Event.MOUSE_UP, this, this.addStageMouseUp);
            EventManager.instance.offNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
            EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);
            EventManager.instance.offNotice(GameEvent.PLAYER_DEATH, this, this.setDeath);
            Laya.timer.clearAll(this);
            this.roleSprite.removeChildren();
            this.roleSprite.removeSelf();
            this.rolePlayer.dispose();
            this.roleSprite.destroy();
            this.roleSprite = null;
            this.recover();
        }
        recover() {
            Laya.Pool.recover("player", this);
        }
    }

    class EnemyBody extends Laya.Script {
        constructor() {
            super();
            this.activeDis = 600;
        }
        onAwake() {
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
        }
        onUpdate() {
            var p = this.selfBody.getWorldCenter();
            if (Math.abs(ViewManager.instance.rolePlayer.roleSprite.x - p.x) < this.activeDis) {
                EventManager.instance.dispatcherEvt(GameEvent.ACTIVE_ENEMY, this.owner);
            }
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
            this.blood = 1;
            this.expRate = [];
            this.isBoss = false;
            this.isActive = false;
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
            this.isActive = false;
            this.isDeath = false;
            Laya.timer.clear(this, this.setFire);
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
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                var t = this.scene.getComponent(EnemyBody);
                t.activeDis = 900;
            }
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            EventManager.instance.addNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
            this.setDirection();
            this.setStay();
        }
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.setFire();
                Laya.timer.loop(2000, this, this.setFire);
            }
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
                this.blood -= s.d;
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
        setIdle() {
            if (this.isDeath)
                return;
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
            else if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                this.bodyLoader.url = "ui://Game/enemyStay_6";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_1) {
                this.bodyLoader.url = "ui://Game/enemy11";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_2) {
                this.bodyLoader.url = "ui://Game/enemy12";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_3) {
                this.bodyLoader.url = "ui://Game/enemy13";
            }
            else if (this.enemyType == GameData.ENEMY_TANK_4) {
                this.bodyLoader.url = "ui://Game/enemy14";
            }
            this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
        }
        setRun() {
            if (this.isDeath)
                return;
            if (this.sRun)
                return;
            this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
            this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
        }
        stillRun() {
            if (this.isDeath)
                return;
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
            if (this.isDeath)
                return;
            if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
                if (this.getRandomFire() == 1) {
                    SoundManager.instance.playSound("enemy_fire");
                    this.bodyLoader.url = "ui://Game/enemy_fire_1";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
                }
                else {
                    this.bodyLoader.url = "ui://Game/enemy_fire_2";
                    this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
                }
            }
            else if (this.enemyType == GameData.ENEMY_MAC) {
                SoundManager.instance.playSound("enemy_fire");
                this.bodyLoader.url = "ui://Game/enemy_fire_3";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
            }
            else if (this.enemyType == GameData.ENEMY_FIRE) {
                SoundManager.instance.playSound("BombDrop");
                this.bodyLoader.url = "ui://Game/enemy_fire_4";
            }
            else if (this.enemyType == GameData.ENEMY_MOR) {
                SoundManager.instance.playSound("BombDrop");
                this.bodyLoader.url = "ui://Game/enemy_fire_5";
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
                this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
            }
            else if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                SoundManager.instance.playSound("enemy_fire");
                this.bodyLoader.url = "ui://Game/enemy_fire_6";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
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
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clear(this, this.setFire);
            var s = this.getRandomDeath();
            SoundManager.instance.playSound("die_" + s);
            if (this.enemyType == GameData.ENEMY_JUNGUAN) {
                this.enemy.url = "ui://Game/death_" + this.enemyType;
            }
            else
                this.enemy.url = "ui://Game/death_" + s;
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            Laya.timer.once(500, this, this.dispose);
            this.createGoods();
            if (this.isBoss) {
                GameManager.instance.bossDeath = true;
            }
        }
        createGoods() {
            if (this.expRate.length > 0) {
                var r = Math.random();
                var rate = 0;
                var type = 0;
                for (let i = 0; i < this.expRate.length; i += 2) {
                    rate += this.expRate[i + 1];
                    if (rate >= r) {
                        type = this.expRate[i];
                        if (type > 0) {
                            var p = new Laya.Point();
                            p.x = this.scene.x + this.scene.width / 2;
                            p.y = this.scene.y + this.scene.height / 2;
                            ViewManager.instance.createGoods(type, p);
                        }
                        break;
                    }
                }
            }
        }
        clearWarView() {
            this.dispose();
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
            EventManager.instance.offNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
            EventManager.instance.offNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clear(this, this.setFire);
            if (this.scene)
                this.scene.removeSelf();
            if (this.view)
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
        constructor() {
            super();
            this.bulletType = 0;
        }
        onAwake() {
            this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
            this.selfBody = this.selfCollider.rigidBody;
            this.self = this.owner;
            this.oriPosX = this.self.x;
            if (this.selfCollider.label.indexOf("PlayerBullet") > -1) {
                this.bulletType = Number(this.selfCollider.label.substr(("PlayerBullet").length, 1));
                this.damage = GameManager.instance.getPlayerBulletDamage(this.bulletType);
            }
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (self.label.indexOf("PlayerBullet") > -1) {
                if (other.label == "enemy") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_ENEMY, { o: other.owner, s: self.owner, d: this.damage });
                }
                else if (other.label == "obstacle") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: this.damage });
                }
                return;
            }
            else if (self.label == "enemyBullet") {
                if (other.label == "player") {
                    this.selfCollider.destroy();
                    EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BULLET_HIT_PLAYER, { o: other.owner, s: self.owner });
                }
                return;
            }
        }
        onTriggerExit() {
        }
        onTriggerStay(other, self, contact) {
        }
        onUpdate() {
            if (this.bulletType == GameData.WEAPON_RIFLE)
                return;
            if (this.selfBody.label.indexOf("PlayerBullet") > -1 || this.selfBody.label.indexOf("enemyBullet") > -1) {
                if (this.oriPosX < this.self.x) {
                    if (Math.abs(this.self.x - this.oriPosX) > Laya.stage.width * 0.7) {
                        this.owner.removeSelf();
                        EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
                    }
                }
                else {
                    if (Math.abs(this.oriPosX - this.self.x) > Laya.stage.width * 0.7) {
                        this.owner.removeSelf();
                        EventManager.instance.dispatcherEvt(GameEvent.BULLET_DISPOSE, this.owner);
                    }
                }
            }
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
            if (this.bulletType == GameData.ENEMY_TANK_1 || this.bulletType == GameData.ENEMY_TANK_2 || this.bulletType == GameData.ENEMY_TANK_3 || this.bulletType == GameData.ENEMY_TANK_4) {
                this.view.m_zidan.url = "ui://Game/zhadan_4";
            }
            else
                this.view.m_zidan.url = "ui://Game/zidan3";
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
        }
        setBulletPos() {
            var p = ViewManager.instance.getEnemyBulletOffSetPos(this.direction, this.bulletType);
            this.scene.x = this.parentPos.x + p.x;
            this.scene.y = this.parentPos.y + p.y;
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "enemyBullet";
            if (this.direction == 1) {
                this.view.setSkew(0, 0);
                this.body.setVelocity({ x: 10, y: 0 });
            }
            else {
                this.view.setSkew(180, 180);
                this.body.setVelocity({ x: -10, y: 0 });
            }
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
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("enemyBullet", this);
        }
        dispose(s) {
            if (s == this.box.owner) {
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
            this.view = fairygui.UIPackage.createObject("Game", "zidan");
            this.view.m_zidan.url = "ui://Game/playerzidan" + this.bulletType;
            if (this.bulletType == GameData.WEAPON_RIFLE) {
                Laya.Scene.load("BulletRifle.scene", Laya.Handler.create(this, this.loadComplete));
            }
            else {
                Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
            }
        }
        loadComplete(s) {
            this.scene = s;
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.scene.addComponent(BulletBody);
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.box.label = this.body.label = "PlayerBullet" + this.bulletType;
            this.setBulletPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        }
        hitEnemy(s) {
            if (this.bulletType == GameData.WEAPON_RIFLE)
                return;
            if (s.s == this.box.owner) {
                this.body.setVelocity({ x: 0, y: 0 });
                this.view.m_zidan.url = "ui://Game/bulletDisAni";
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("PlayerBullet", this);
        }
        disposeBullet(s) {
            if (s == this.body.owner) {
                this.disposeAll();
            }
        }
        setBulletPos() {
            var p = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
            var c = ViewManager.instance.rolePlayer.roleSprite.getComponent(Laya.RigidBody).getWorldCenter();
            if (this.bulletType == GameData.WEAPON_RIFLE) {
                this.view.x = p.x;
                this.view.y = p.y;
                this.scene.addChild(this.view.displayObject);
                var b = this.scene.getComponent(BulletBody);
                b.onAwake();
                if (this.direction > 0) {
                    this.scene.x = c.x + 45;
                    if (this.direction == 2) {
                        this.scene.y = c.y;
                        this.view.setSkew(15, 15);
                    }
                    else if (this.direction == 3) {
                        this.scene.y = c.y - this.scene.height;
                        this.view.setSkew(-15, -15);
                    }
                    else {
                        this.scene.y = c.y - this.scene.height / 2;
                        this.view.setSkew(0, 0);
                    }
                }
                else {
                    this.scene.x = c.x - this.scene.width - 45;
                    if (this.direction == -2) {
                        this.scene.y = c.y;
                        this.view.setSkew(165, 165);
                    }
                    else if (this.direction == -3) {
                        this.scene.y = c.y - this.scene.height;
                        this.view.setSkew(195, 195);
                    }
                    else {
                        this.scene.y = c.y - this.scene.height / 2;
                        this.view.setSkew(180, 180);
                    }
                }
                this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
            }
            else {
                var y = ViewManager.instance.bulletRandomY();
                this.scene.x = c.x + p.x;
                this.scene.y = c.y - y + p.y;
                this.scene.addChild(this.view.displayObject);
                var b = this.scene.getComponent(BulletBody);
                b.onAwake();
                if (this.direction > 0) {
                    if (this.direction == 2) {
                        this.view.setSkew(25, 25);
                        this.body.setVelocity({ x: 11, y: 7 });
                    }
                    else if (this.direction == 3) {
                        this.view.setSkew(-25, -25);
                        this.body.setVelocity({ x: 11, y: -7 });
                    }
                    else {
                        this.view.setSkew(0, 0);
                        this.body.setVelocity({ x: 11, y: 0 });
                    }
                }
                else {
                    if (this.direction == -2) {
                        this.view.setSkew(155, 155);
                        this.body.setVelocity({ x: -11, y: 7 });
                    }
                    else if (this.direction == -3) {
                        this.view.setSkew(205, 205);
                        this.body.setVelocity({ x: -11, y: -7 });
                    }
                    else {
                        this.view.setSkew(180, 180);
                        this.body.setVelocity({ x: -11, y: 0 });
                    }
                }
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
        }
        onDisable() {
        }
        onTriggerEnter(other, self, contact) {
            if (self.label == "PlayerBomb") {
                if (other.label == "enemy") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                    this.owner.removeSelf();
                }
                else if (other.label == "obstacle") {
                    EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, { o: other.owner, s: self.owner, d: GameData.BOMB_DAMAGE });
                }
            }
            else if (self.label == "enemyBomb" && other.label == "player") {
                this.owner.removeSelf();
                EventManager.instance.dispatcherEvt(GameEvent.ENEMY_BOMB_HIT_PLAYER, { o: other.owner, s: self.owner });
                return;
            }
            if (other.label == "ground") {
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
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
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
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            Laya.Pool.recover("boomView", this);
            if (this.view)
                this.view.dispose();
            this.scene.removeSelf();
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
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
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
            SoundManager.instance.playSound("boom");
            var bomb = Laya.Pool.getItemByClass("boomView", BoomView);
            var p = ViewManager.instance.getBodyCenterPos(this.scene);
            bomb.createView(ViewManager.instance.getBoomAniTypeByBomb(this.bombType), p, this.isPlayer);
        }
        dispose(s) {
            if (s.s == this.box.owner) {
                this.showBoomView();
                this.disposeAll();
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
            Laya.Pool.recover("bombView", this);
            if (this.view)
                this.view.dispose();
            this.scene.removeSelf();
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
            this.box = this.scene.getComponent(Laya.PolygonCollider);
            this.isDeath = false;
            this.scene.x = this.pos.x;
            this.scene.y = this.pos.y;
            ViewManager.instance.warView.scene.addChild(this.scene);
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
            EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood -= s.d;
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
            this.load.url = "";
            var boomAniType = ViewManager.instance.getBoomAniTypeByObsType(this.type);
            var boomAni = fairygui.UIPackage.createObject("Game", "boom_" + boomAniType).asMovieClip;
            var p = this.getBoomAniPos(this.type);
            boomAni.x = p.x;
            boomAni.y = p.y;
            this.load.displayObject.addChild(boomAni.displayObject);
            boomAni.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            SoundManager.instance.playSound("obstacleBoom");
        }
        dispose() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
            EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
            Laya.timer.clearAll(this);
            if (this.scene)
                this.scene.removeSelf();
            if (this.view)
                this.view.dispose();
            Laya.Pool.recover("obstacle", this);
        }
        getBoomAniPos(type) {
            var p = new Laya.Point();
            if (type == ObstacleType.ObstacleType_SHABAO) {
                p.x = 10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_YOUGUAN) {
                p.x = -10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_MICHE) {
                p.x = -20;
                p.y = -180;
            }
            else if (type == ObstacleType.ObstacleType_DACHE) {
                p.x = 250;
                p.y = -40;
            }
            else if (type == ObstacleType.ObstacleType_CHE) {
                p.x = 50;
                p.y = -100;
            }
            else if (type == ObstacleType.ObstacleType_6) {
                p.x = -50;
                p.y = -100;
            }
            else if (type == ObstacleType.ObstacleType_7) {
                p.x = -40;
                p.y = -200;
            }
            else if (type == ObstacleType.ObstacleType_8) {
                p.x = -60;
                p.y = -220;
            }
            else if (type == ObstacleType.ObstacleType_9) {
                p.x = -10;
                p.y = -10;
            }
            else if (type == ObstacleType.ObstacleType_10) {
                p.x = 20;
                p.y = -120;
            }
            else if (type == ObstacleType.ObstacleType_11) {
                p.x = -30;
                p.y = -150;
            }
            return p;
        }
    }

    class Chopper extends Enemy {
        constructor() {
            super();
            this.stillFire = 0;
            this.randomY = false;
        }
        createView(d) {
            super.initData(d);
            Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        initView() {
            super.initView();
            var b = this.scene.getComponent(EnemyBody);
            b.activeDis = 800;
        }
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.setRun();
                this.setStillFire();
                Laya.timer.loop(4000, this, this.setStillFire);
                Laya.timer.loop(4000, this, this.setRun);
            }
        }
        setRun() {
            var roleX = ViewManager.instance.rolePlayer.roleSprite.x;
            if (this.scene.x > roleX) {
                Laya.Tween.to(this.scene, { x: roleX - this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
            }
            else {
                Laya.Tween.to(this.scene, { x: roleX + this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
            }
        }
        setStillFire() {
            this.setFire();
            Laya.timer.loop(300, this, this.setFire);
        }
        setFire() {
            this.stillFire++;
            var p = new Laya.Point(this.view.width / 2, this.view.height);
            ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);
            SoundManager.instance.playSound("bombDrop");
            if (this.stillFire >= 5) {
                this.stillFire = 0;
                Laya.timer.clear(this, this.setFire);
            }
        }
        setDeath() {
            if (this.isDeath)
                return;
            this.isDeath = true;
            Laya.timer.clearAll(this);
            Laya.Tween.clearAll(this.scene);
            this.enemy.url = "ui://Game/boom_5";
            this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            if (this.isBoss) {
                GameManager.instance.bossDeath = true;
            }
            SoundManager.instance.playSound("boom");
        }
        clearWarView() {
            this.dispose();
        }
        dispose() {
            super.dispose();
            Laya.timer.clearAll(this);
        }
        recover() {
            Laya.Pool.recover("chopper", this);
        }
        getDis() {
            return (Math.random() * 200 + 100);
        }
        getRandomY() {
            this.randomY = !this.randomY;
            var r = Math.random();
            if (this.randomY) {
                return (r * 20 + 30);
            }
            else {
                return (r * -20 - 30);
            }
        }
    }

    class Tank extends Enemy {
        constructor() {
            super();
            this.randomX = false;
        }
        createView(d) {
            super.initData(d);
            Laya.Scene.load("TankBody" + this.enemyType + ".scene", Laya.Handler.create(this, this.loadComplete));
        }
        ;
        activeEnemy(s) {
            if (this.isActive)
                return;
            if (this.isDeath)
                return;
            if (this.box.owner == s) {
                this.isActive = true;
                this.doActive();
                Laya.timer.loop(2000, this, this.doActive);
            }
        }
        doActive() {
            this.setFire();
            this.setRun();
        }
        initView() {
            super.initView();
            var b = this.scene.getComponent(EnemyBody);
            b.activeDis = 800;
        }
        setRun() {
            var roleDir = ViewManager.instance.rolePlayer.direction;
            var roleX = ViewManager.instance.rolePlayer.roleSprite.x;
            if (roleX > this.scene.x) {
                this.direction = 1;
                this.setDirection();
            }
            else {
                this.direction = -1;
                this.setDirection();
            }
            Laya.Tween.to(this.scene, { x: this.scene.x + this.getRandomX() }, 2000);
        }
        beHit(s) {
            if (this.isDeath)
                return;
            if (s.o == this.box.owner) {
                this.blood -= s.d;
                Laya.timer.clear(this, this.setColor);
                if (this.blood <= 0) {
                    this.setDeath();
                }
                else {
                    this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                    Laya.timer.once(200, this, this.setColor);
                }
            }
        }
        setColor() {
            this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ffffff";
        }
        setFire() {
            this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
            if (this.enemyType == GameData.ENEMY_TANK_1 || this.enemyType == GameData.ENEMY_TANK_2) {
                this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankShotComplete));
            }
            SoundManager.instance.playSound("tank_fire");
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
            Laya.Tween.clearAll(this.scene);
            this.bodyLoader.url = "";
            var ani = fairygui.UIPackage.createObject("Game", "boom_5").asMovieClip;
            ani.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
            ani.x = 20;
            ani.y = -100;
            this.bodyLoader.displayObject.addChild(ani.displayObject);
            if (this.isBoss) {
                GameManager.instance.bossDeath = true;
            }
            SoundManager.instance.playSound("boom");
        }
        getDeathBoomPos() {
        }
        recover() {
            Laya.Pool.recover("tank", this);
        }
        getRandomX() {
            this.randomX = !this.randomX;
            var r = Math.random();
            if (this.randomX) {
                return (r * 20 + 50);
            }
            else {
                return (r * -20 - 50);
            }
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
        dispose(s) {
            if (s.s == this.box.owner) {
                this.showBoomView();
                this.disposeAll();
            }
        }
        disposeAll() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
            EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
            EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
            this.scene.removeSelf();
            if (this.view)
                this.view.dispose();
            Laya.Pool.recover("ChopperBomb", this);
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
            this.scene = s;
            this.body = this.scene.getComponent(Laya.RigidBody);
            this.box = this.scene.getComponent(Laya.BoxCollider);
            this.view = fairygui.UIPackage.createObject("Game", "goodsView");
            this.mc = fairygui.UIPackage.createObject("Game", "createGoodsAni").asMovieClip;
            this.mc.x = -this.mc.width / 2 + 20;
            this.mc.y = -this.mc.height / 2;
            this.mc.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniComplete));
            this.view.addChild(this.mc);
            this.scene.addChild(this.view.displayObject);
            ViewManager.instance.warView.scene.addChild(this.scene);
            this.setBombPos();
            EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
            EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
        }
        createAniComplete() {
            this.view.removeChild(this.mc);
            this.view.m_load.url = "ui://Game/goods_" + this.type;
            if (this.type != GoodsType.GoodsType_COIN && this.type != GoodsType.GoodsType_GRE) {
                this.view.m_load.content.setPlaySettings(0, -1, 0, 0);
            }
        }
        dispose(s) {
            if (s == this.box.owner) {
                SoundManager.instance.playSound("get_goods");
                this.clearView();
            }
        }
        clearView() {
            EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
            EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.type);
            this.view.removeChildren();
            if (this.view)
                this.view.dispose();
            this.scene.removeSelf();
            Laya.Pool.recover("goods", this);
        }
        setBombPos() {
            this.scene.x = this.pos.x + 20;
            this.scene.y = this.pos.y;
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
            this.updateAllView();
            this.view.m_pause.onClick(this, this.pauseGame);
        }
        updateAllView() {
            this.updateBulletNum();
            this.updatePlayerBlood();
            this.updateGreNum();
            this.updateCoin();
        }
        pauseGame() {
            SoundManager.instance.playSound("btn_press");
            ViewManager.instance.showSuspendView();
            Laya.timer.once(300, this, () => {
                GameManager.instance.suspendGame();
            });
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
                else {
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addMacNum;
                    GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
                }
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
                this.updateBulletNum();
            }
            else if (t == GoodsType.GoodsType_RIF) {
                if (GameManager.instance.roleInfo.weaponType == PlayerData.WEAPON_RIFLE) {
                    GameManager.instance.roleInfo.bulletNum += GameManager.instance.roleInfo.addRifNum;
                }
                else {
                    GameManager.instance.roleInfo.bulletNum = GameManager.instance.roleInfo.addRifNum;
                    GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_RIFLE;
                }
                this.updateBulletNum();
                EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_WEAPON, GameManager.instance.roleInfo.weaponType);
            }
            else if (t == GoodsType.GoodsType_GRE) {
                GameManager.instance.roleInfo.bombNum += GameManager.instance.roleInfo.addBombNum;
                this.updateGreNum();
            }
            else if (t == GoodsType.GoodsType_COIN) {
                var coin = this.getRandomCoin();
                GameManager.instance.roleInfo.curlvCoin += coin;
                GameManager.instance.roleInfo.totalCoin += coin;
                this.updateCoin();
            }
        }
        decPlayerBlood() {
            GameManager.instance.roleInfo.blood--;
            if (GameManager.instance.roleInfo.blood < 0)
                GameManager.instance.roleInfo.blood = 0;
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
        updateCoin() {
            this.view.m_coin.text = GameManager.instance.roleInfo.totalCoin + "";
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
        getRandomCoin() {
            return Math.floor((Math.random() * 100) * GameData.RANDOM_COIN / 100);
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
        showView(showMask = true, clickMaskHide = true) {
            Laya.Tween.clearTween(this.tween);
            this.v.addChild(this.view);
            fairygui.GRoot.inst.addChild(this.v);
            this.view.setPivot(0.5, 0.5);
            this.view.setScale(0.4, 0.4);
            this.tween = Laya.Tween.to(this.view, { scaleX: 1, scaleY: 1 }, 250, null, Laya.Handler.create(this, this.showComplete, [showMask, clickMaskHide]));
        }
        showComplete(s, c) {
            if (s) {
                this.v.m_mask.visible = true;
                if (c)
                    this.v.m_mask.on(Laya.Event.CLICK, this, this.hideAllView);
            }
            this.view.setScale(1, 1);
        }
        hideAllView() {
            this.v.m_mask.off(Laya.Event.CLICK, this, this.hideAllView);
            fairygui.GRoot.inst.removeChild(this.v);
        }
    }

    class SuspendView extends PopUpView {
        constructor() { super(); }
        createView() {
            this.view = WXFUI_SuspendView.createInstance();
            this.view.m_back.onClick(this, this.goFirstPage);
            this.view.m_continue.onClick(this, this.continueGame);
            this.view.m_restart.onClick(this, this.restartGame);
        }
        goFirstPage() {
            GameManager.instance.suspendGame();
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.goFirstPage();
        }
        continueGame() {
            GameManager.instance.suspendGame();
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.hidePopUpView(null, true);
        }
        restartGame() {
            GameManager.instance.suspendGame();
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.restartGame();
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
            this.m_title = (this.getChild("title"));
            this.m_share = (this.getChild("share"));
            this.m_set = (this.getChild("set"));
            this.m_setView = (this.getChild("setView"));
        }
    }
    WXFUI_ChapterView.URL = "ui://bq3h5insdr1tnw";

    class ChapterView extends PopUpView {
        constructor() {
            super();
            this.showSet = true;
            this.showVolume = true;
        }
        createView() {
            this.view = WXFUI_ChapterView.createInstance();
            this.view.m_title.url = "ui://Game/chapter_1";
            for (let t = 1; t <= GameManager.instance.maxLevel; t++) {
                this.view["m_level_" + t].on(Laya.Event.CLICK, this, this.chooseLevel, [t]);
            }
            this.view.m_share.m_share1.onClick(this, this.shareHandle1);
            this.view.m_share.m_share2.onClick(this, this.shareHandle2);
            this.view.m_set.onClick(this, this.showSetView);
            this.view.m_setView.m_vol.onClick(this, this.setVolume);
            this.view.m_last.onClick(this, this.lastHandle);
            this.view.m_next.onClick(this, this.nextHandle);
            this.updateView();
        }
        updateView() {
            this.view.m_title.url = "ui://Game/chapter_" + GameManager.instance.curChapter;
            if (GameManager.instance.curChapter < GameManager.instance.gotoMaxChapter) {
                this.view.m_next.visible = true;
            }
            else {
                this.view.m_next.visible = false;
            }
            if (GameManager.instance.curChapter > 1) {
                this.view.m_last.visible = true;
            }
            else {
                this.view.m_last.visible = false;
            }
            var c = GameManager.instance.curChapter;
            for (let i = 1; i <= GameManager.instance.maxLevel; i++) {
                var index = i + (c - 1) * GameManager.instance.maxLevel;
                if (index < GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 1;
                }
                else if (index == GameManager.instance.gotoMaxLevel) {
                    this.view["m_level_" + i].m_ctl.selectedIndex = 2;
                }
                else
                    this.view["m_level_" + i].m_ctl.selectedIndex = 0;
            }
        }
        chooseLevel(l) {
            SoundManager.instance.playSound("btn_click");
            console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
            if (l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel > GameManager.instance.gotoMaxLevel)
                return;
            GameManager.instance.choiseLevel = l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel;
            ViewManager.instance.showBeforeWarView();
        }
        setVolume() {
            SoundManager.instance.playSound("btn_click");
            this.showVolume = !this.showVolume;
            SoundManager.instance.offSound();
        }
        showSetView() {
            SoundManager.instance.playSound("btn_click");
            this.showSet = !this.showSet;
            this.view.m_setView.visible = this.showSet;
        }
        shareHandle1() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.showTipsView("敬请期待！");
        }
        shareHandle2() {
            SoundManager.instance.playSound("btn_click");
            ViewManager.instance.showTipsView("敬请期待！");
        }
        lastHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.curChapter--;
            this.updateView();
        }
        nextHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.curChapter++;
            this.updateView();
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
            this.view.m_return.onClick(this, this.returnHandle);
            this.view.m_coin.text = " 0";
        }
        updateCoin() {
            this.view.m_coin.text = " " + GameManager.instance.roleInfo.curlvCoin + " ";
        }
        continueGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.gotoNextLevel();
        }
        restartGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.restartGame();
        }
        continueGameByVideo() {
            SoundManager.instance.playSound("btn_click");
        }
        returnHandle() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.goFirstPage();
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
            this.shopData = GameManager.instance.levelData.shop;
            this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = this.view.m_item_4.visible = false;
            var index = 0;
            for (const key in this.shopData) {
                if (this.shopData.hasOwnProperty(key)) {
                    index++;
                    var d = this.shopData[key];
                    this.view["m_item_" + index].visible = true;
                    this.view["m_item_" + index].m_coin.text = d.coin + "";
                    this.view["m_item_" + index].m_info.text = d.name;
                    this.view["m_item_" + index].m_icon.url = "ui://Game/goods_" + d.type;
                    this.view["m_item_" + index].m_buy.onClick(this, this.buyItem, [d]);
                    this.view["m_item_" + index].m_free.onClick(this, this.buyItemByFree, [d]);
                }
            }
        }
        buyItem(d) {
            SoundManager.instance.playSound("btn_press");
            if (GameManager.instance.roleInfo.totalCoin < d.coin) {
                ViewManager.instance.showTipsView("金币不足！");
                return;
            }
            else {
                ViewManager.instance.showTipsView("金币-" + d.coin);
                GameManager.instance.roleInfo.totalCoin -= d.coin;
                GameManager.instance.buyShopItem(d);
            }
        }
        buyItemByFree(d) {
            SoundManager.instance.playSound("btn_press");
            ViewManager.instance.showTipsView("敬请期待！@_@");
            EventManager.instance.dispatcherEvt(GameEvent.BUY_SHOP_ITEM_FREE, d);
        }
        enterGame() {
            SoundManager.instance.playSound("btn_click");
            GameManager.instance.enterGame();
            ViewManager.instance.hidePopUpView(this, true);
        }
    }

    class WXFUI_TipsPopView extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "TipsPopView"));
        }
        onConstruct() {
            this.m_tips = (this.getChild("tips"));
            this.m_play = this.getTransition("play");
        }
    }
    WXFUI_TipsPopView.URL = "ui://bq3h5insugvixpf";

    class TipsPopView {
        constructor() {
            this.isShow = false;
            this.v = WXFUI_TipsPopView.createInstance();
        }
        showView(str) {
            if (this.isShow)
                return;
            this.isShow = true;
            this.v.x = (Laya.stage.width - this.v.width) / 2;
            this.v.y = (Laya.stage.height - this.v.height) / 2;
            this.v.m_tips.text = str;
            Laya.stage.addChildAt(this.v.displayObject, 1);
            this.v.m_play.play(Laya.Handler.create(this, this.hideView), 1, 0, 0);
        }
        hideView() {
            Laya.stage.removeChild(this.v.displayObject);
            this.isShow = false;
        }
    }

    class ViewManager {
        constructor() {
            this.bulletArr = [];
            this.enemyArr = [];
            this.isChecking = false;
            this.warAllView = [];
            this.curPopView = [];
            this.playerBulletPos = {
                "11": [135, -22],
                "12": [150, 0],
                "13": [50, 70],
                "21": [125, 25],
                "22": [115, 70],
                "23": [50, 5],
                "31": [115, -95],
                "32": [120, -50],
                "33": [25, 130],
                "14": [20, -60],
                "-11": [-200, -22],
                "-12": [-210, 0],
                "-13": [240, 80],
                "-14": [-20, -60],
                "-21": [-190, 20],
                "-22": [-180, 15],
                "-23": [250, 20],
                "-31": [-190, -90],
                "-32": [-180, -50],
                "-33": [255, 130],
            };
            this.enemyBulletPos = {
                "11": [105, 10],
                "12": [10, -40],
                "13": [125, 15],
                "14": [],
                "15": [70, -20],
                "111": [-25, 15],
                "112": [-5, 25],
                "113": [-75, 15],
                "114": [-35, 15],
                "-11": [-100, 10],
                "-12": [0, -50],
                "-13": [-75, 15],
                "-14": [],
                "-15": [0, -20],
                "-111": [0, 15],
                "-112": [-50, 30],
                "-113": [20, 20],
                "-114": [-20, 10],
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
            this.loadingView.m_bar.m_title.text = Math.ceil(p * 100) + "%";
            this.loadingView.m_bar.value = p * 100;
        }
        hideLoadingView() {
            Laya.stage.removeChild(this.loadingView.displayObject);
        }
        createPlayer() {
            if (!this.player) {
                this.player = new Player();
                this.player.createView();
            }
            else {
                this.player.resetPos();
            }
        }
        createWarView() {
            if (this.warView)
                this.warView.dispose();
            this.warView = Laya.Pool.getItemByClass("warView", WarView);
            this.warView.createView();
            this.showPlayerInfoView();
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
            b.createView(this.rolePlayer.weaponType, this.rolePlayer.faceType);
            return b;
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
            this.playerInfoView.updateAllView();
            fairygui.GRoot.inst.addChild(this.playerInfoView.view);
        }
        showPlayerCtlView() {
            if (!this.playerCtlView)
                this.playerCtlView = new PlayerCtlView();
            fairygui.GRoot.inst.addChild(this.playerCtlView.view);
        }
        showAfterWarView(type) {
            this.afterWar.view.m_ctl.selectedIndex = type - 1;
            this.afterWar.updateCoin();
            this.showPopUpView(this.afterWar, true, true, false);
        }
        showBeforeWarView() {
            this.showPopUpView(this.beforeWar);
        }
        showSuspendView() {
            this.showPopUpView(this.suspendView);
        }
        showChapterView() {
            SoundManager.instance.stopBGM();
            this.chapterView.view.m_chapter.selectedIndex = 0;
            this.chapterView.updateView();
            this.showPopUpView(this.chapterView, false, true);
        }
        initPopUpView() {
            this.afterWar = new AfterWar();
            this.beforeWar = new BeforeWar();
            this.suspendView = new SuspendView();
            this.chapterView = new ChapterView();
            this.popUpView = new PopUpView();
            this.tipsView = new TipsPopView();
            this.afterWar.createView();
            this.beforeWar.createView();
            this.suspendView.createView();
            this.chapterView.createView();
            Laya.stage.addChild(fairygui.GRoot.inst.displayObject);
        }
        showTipsView(str) {
            this.tipsView.showView(str);
        }
        showPopUpView(p, showMask = true, hideOther = false, clickMaskHide = true) {
            if (hideOther) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var t = this.curPopView[i];
                    t.hideAllView();
                }
                this.curPopView.length = 0;
            }
            p.showView(showMask, clickMaskHide);
            this.curPopView.push(p);
        }
        hidePopUpView(p, all = false) {
            if (all) {
                for (let i = 0; i < this.curPopView.length; i++) {
                    var t = this.curPopView[i];
                    t.hideAllView();
                }
                this.curPopView.length = 0;
            }
            else {
                if (p)
                    p.hideAllView();
            }
        }
        removeWarView() {
            if (this.warView) {
                this.warView.removeView();
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
            if (type == ObstacleType.ObstacleType_SHABAO || type == ObstacleType.ObstacleType_YOUGUAN || type == ObstacleType.ObstacleType_9) {
                return 2;
            }
            else if (type == ObstacleType.ObstacleType_DACHE || type == ObstacleType.ObstacleType_11) {
                return 5;
            }
            else {
                return 3;
            }
        }
        bulletRandomY() {
            return Math.floor(Math.random() * 10) + 10;
        }
        getPlayerDirection(pos) {
            var rad = Math.atan2(pos.y, pos.x);
            if ((rad >= -2 * Math.PI / 8 && rad < 0) || (rad >= 0 && rad < 2 * Math.PI / 8)) {
                return 1;
            }
            else if (rad >= 2 * Math.PI / 8 && rad < 4 * Math.PI / 8) {
                return 2;
            }
            else if (rad >= 4 * Math.PI / 8 && rad < 6 * Math.PI / 8) {
                return -2;
            }
            else if ((rad >= 6 * Math.PI / 8 && rad < Math.PI) || (rad >= -Math.PI && rad < -6 * Math.PI / 8)) {
                return -1;
            }
            else if (rad >= -6 * Math.PI / 8 && rad < -4 * Math.PI / 8) {
                return -3;
            }
            else {
                return 3;
            }
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
            if (this.enemyBulletPos[s])
                return new Laya.Point(this.enemyBulletPos[s][0], this.enemyBulletPos[s][1]);
            else
                return new Laya.Point(0, 0);
        }
    }

    class SaveManager {
        constructor() {
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new SaveManager();
            return this._instance;
        }
        saveGameData(key, value) {
            localStorage.setItem(key, value);
        }
        getGameData(key) {
            return localStorage.getItem(key);
        }
    }

    class GameManager {
        constructor() {
            this.curLevel = 1;
            this.curChapter = 1;
            this.maxLevel = 8;
            this.maxChapter = 1;
            this.gotoMaxLevel = 1;
            this.gotoMaxChapter = 1;
            this.choiseLevel = 1;
            this.bossDeath = false;
            this.isPauseGame = false;
        }
        static get instance() {
            if (this._instance == null)
                this._instance = new GameManager();
            return this._instance;
        }
        startGame() {
            this.levelData = Laya.loader.getRes("res/LevelData.json");
            this.initRoleData();
            this.initChapterConfig();
            ViewManager.instance.initPopUpView();
            ViewManager.instance.showChapterView();
        }
        initChapterConfig() {
            this.maxChapter = this.levelData["maxChapter"];
            var l = SaveManager.instance.getGameData("level");
            var c = SaveManager.instance.getGameData("chapter");
            var coin = SaveManager.instance.getGameData("coin");
            if (coin && coin.length > 0)
                this.roleInfo.totalCoin = Number(coin);
            if (l && l.length > 0) {
                this.curLevel = this.gotoMaxLevel = Number(l);
                this.curChapter = this.gotoMaxChapter = Math.ceil(this.curLevel / this.maxLevel);
                if (this.curChapter > this.maxChapter)
                    this.curChapter = this.gotoMaxChapter = this.maxChapter;
            }
            else {
                this.gotoMaxChapter = this.curChapter = 1;
                this.gotoMaxLevel = this.curLevel = 1;
            }
            this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
        }
        enterGame() {
            this.curLevel = this.choiseLevel;
            this.goLevelGame();
        }
        goBack() {
            this.goFirstPage();
        }
        goFirstPage() {
            EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
            ViewManager.instance.hidePopUpView(null, true);
            ViewManager.instance.removeWarView();
            ViewManager.instance.showChapterView();
            Laya.SoundManager.stopMusic();
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
            this.bossDeath = false;
            this.curLevel++;
            if (this.gotoMaxLevel < this.curLevel) {
                this.gotoMaxLevel = this.curLevel;
                if (this.gotoMaxLevel % this.maxLevel == 1) {
                    this.gotoMaxChapter++;
                    if (this.gotoMaxChapter > this.maxChapter)
                        this.gotoMaxChapter = this.maxChapter;
                    this.curChapter = this.gotoMaxChapter;
                }
            }
            else {
                this.curChapter = Math.ceil(this.curLevel / this.maxLevel);
            }
            ViewManager.instance.showAfterWarView(1);
            SaveManager.instance.saveGameData("level", this.gotoMaxLevel + "");
            SaveManager.instance.saveGameData("chapter", this.gotoMaxChapter + "");
            SaveManager.instance.saveGameData("coin", this.roleInfo.totalCoin + "");
            SoundManager.instance.playSound("gameOver");
        }
        restartGame() {
            ViewManager.instance.hidePopUpView(null, true);
            if (this.curLevel < 1)
                this.curLevel = 1;
            this.goLevelGame();
        }
        gotoNextLevel() {
            ViewManager.instance.hidePopUpView(ViewManager.instance.afterWar);
            if (this.gotoMaxLevel > this.maxLevel * this.maxChapter) {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
                return;
            }
            this.goLevelGame();
        }
        goLevelGame() {
            ViewManager.instance.hidePopUpView(null, true);
            if (this.curLevel > this.maxLevel * this.maxChapter) {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
                return;
            }
            EventManager.instance.dispatcherEvt(GameEvent.CLEAR_WAR_VIEW);
            if (this.levelData["chapter_" + this.curChapter]) {
                var l = (this.curLevel % this.maxLevel);
                if (l == 0)
                    l = 8;
                this.maxLevel = this.levelData["chapter_" + this.curChapter].maxLevelNum;
                this.curLevelData = this.levelData["chapter_" + this.curChapter]["level_" + l];
                this.playerInfo.curlvCoin = 0;
                this.roleInfo.blood = 3;
                ViewManager.instance.createWarView();
                SoundManager.instance.playBGM();
            }
            else {
                ViewManager.instance.showTipsView("您已通关！敬请期待后续章节");
            }
        }
        initRoleData() {
            if (!this.playerInfo)
                this.playerInfo = new PlayerInfo();
            this.playerInfo.bombNum = this.levelData.role.bombNum;
            this.playerInfo.weaponType = this.levelData.role.weaponType;
            this.playerInfo.blood = this.levelData.role.blood;
            this.playerInfo.addBombNum = this.levelData.role.addBombNum;
            this.playerInfo.addMacNum = this.levelData.role.addMacNum;
            this.playerInfo.addRifNum = this.levelData.role.addRifNum;
            this.playerInfo.curLevel = this.playerInfo.curChapter = 1;
            this.playerInfo.curlvCoin = this.playerInfo.totalCoin = 0;
        }
        createEnemyData() {
            var enemyArr = this.curLevelData.enemyArr;
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
                    if (d.type == GameData.ENEMY_TANK_1 || d.type == GameData.ENEMY_TANK_2 || d.type == GameData.ENEMY_TANK_3 || d.type == GameData.ENEMY_TANK_4) {
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
        buyShopItem(d) {
            if (d.type == GoodsType.GoodsType_MED) {
                GameManager.instance.roleInfo.blood++;
            }
            else if (d.type == GoodsType.GoodsType_MAC) {
                GameManager.instance.roleInfo.weaponType = PlayerData.WEAPON_MAC;
                GameManager.instance.roleInfo.bulletNum += d.num;
            }
            else if (d.type == GoodsType.GoodsType_GRE) {
                GameManager.instance.roleInfo.bombNum += d.num;
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
        getPlayerBulletDamage(type) {
            if (type == GameData.WEAPON_PIS) {
                return 1;
            }
            else if (type == GameData.WEAPON_RIFLE) {
                return 5;
            }
            else if (type == GameData.WEAPON_MAC) {
                return 2;
            }
            else {
                return 1;
            }
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
            AssetsManager.assetsData.push({ url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun1.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game_atlas_n8qun7.png", type: Laya.Loader.IMAGE }, { url: "res/LevelData.json", type: Laya.Loader.JSON }, { url: "res/map_1.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_2.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_3.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_4.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_5.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_6.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_7.jpg", type: Laya.Loader.IMAGE }, { url: "res/map_8.jpg", type: Laya.Loader.IMAGE }, { url: "res/Game.wxfui", type: Laya.Loader.BUFFER });
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

    class WXFUI_enemy_fire_14 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_14"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_enemy_fire_14.URL = "ui://bq3h5inscdcoxpj";

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

    class WXFUI_player_stay_1_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_1_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_1_1.URL = "ui://bq3h5inscqp93w";

    class WXFUI_player_stay_2_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_2_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_2_1.URL = "ui://bq3h5inscqp940";

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

    class WXFUI_player_stay_3_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_3_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_3_1.URL = "ui://bq3h5insdhkten";

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
            this.m_icon = (this.getChild("icon"));
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

    class WXFUI_setBtn extends fairygui.GButton {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "setBtn"));
        }
        onConstruct() {
            this.m_button = this.getController("button");
            this.m_n7 = (this.getChild("n7"));
        }
    }
    WXFUI_setBtn.URL = "ui://bq3h5insdr1to5";

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
            this.m_mask = (this.getChild("mask"));
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

    class WXFUI_player_fire_3_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_3_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_3_1.URL = "ui://bq3h5inske5wdy";

    class WXFUI_player_fire_1_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_1_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_1_1.URL = "ui://bq3h5insmsdc5j";

    class WXFUI_player_fire_2_1 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_2_1"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_2_1.URL = "ui://bq3h5insmsdc5k";

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

    class WXFUI_enemy6 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy6"));
        }
        onConstruct() {
            this.m_en = (this.getChild("en"));
        }
    }
    WXFUI_enemy6.URL = "ui://bq3h5instvmxxoo";

    class WXFUI_enemy13 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy13"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy13.URL = "ui://bq3h5instvmxxot";

    class WXFUI_enemy14 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy14"));
        }
        onConstruct() {
            this.m_load = (this.getChild("load"));
        }
    }
    WXFUI_enemy14.URL = "ui://bq3h5instvmxxou";

    class WXFUI_enemy_fire_13 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "enemy_fire_13"));
        }
        onConstruct() {
            this.m_n1 = (this.getChild("n1"));
        }
    }
    WXFUI_enemy_fire_13.URL = "ui://bq3h5instvmxxov";

    class WXFUI_player_fire_2_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_2_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_2_2.URL = "ui://bq3h5instvmxxp1";

    class WXFUI_player_fire_2_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_2_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_2_3.URL = "ui://bq3h5instvmxxp2";

    class WXFUI_player_fire_1_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_1_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_1_2.URL = "ui://bq3h5instvmxxp3";

    class WXFUI_player_fire_1_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_1_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_1_3.URL = "ui://bq3h5instvmxxp4";

    class WXFUI_player_fire_3_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_3_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_3_2.URL = "ui://bq3h5instvmxxp5";

    class WXFUI_player_fire_3_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_fire_3_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_fire_3_3.URL = "ui://bq3h5instvmxxp6";

    class WXFUI_player_stay_1_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_1_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_1_2.URL = "ui://bq3h5instvmxxp7";

    class WXFUI_player_stay_1_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_1_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_1_3.URL = "ui://bq3h5instvmxxp8";

    class WXFUI_player_stay_2_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_2_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_2_3.URL = "ui://bq3h5instvmxxp9";

    class WXFUI_player_stay_2_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_2_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_2_2.URL = "ui://bq3h5instvmxxpa";

    class WXFUI_player_stay_3_2 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_3_2"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_3_2.URL = "ui://bq3h5instvmxxpb";

    class WXFUI_player_stay_3_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_stay_3_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_stay_3_3.URL = "ui://bq3h5instvmxxpc";

    class WXFUI_player_boom_3 extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "player_boom_3"));
        }
        onConstruct() {
            this.m_xs = (this.getChild("xs"));
            this.m_ss = (this.getChild("ss"));
        }
    }
    WXFUI_player_boom_3.URL = "ui://bq3h5instvmxxpd";

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
    WXFUI_bullet2.URL = "ui://bq3h5instvmxxpe";

    class WXFUI_setting extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "setting"));
        }
        onConstruct() {
            this.m_vol = (this.getChild("vol"));
        }
    }
    WXFUI_setting.URL = "ui://bq3h5insugvixpg";

    class WXFUI_volume extends fairygui.GComponent {
        constructor() {
            super();
        }
        static createInstance() {
            return (fairygui.UIPackage.createObject("Game", "volume"));
        }
        onConstruct() {
            this.m_n3 = (this.getChild("n3"));
        }
    }
    WXFUI_volume.URL = "ui://bq3h5insugvixpi";

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
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_14.URL, WXFUI_enemy_fire_14);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_jumpBtn.URL, WXFUI_jumpBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fireBtn.URL, WXFUI_fireBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_throwBtn.URL, WXFUI_throwBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_1_1.URL, WXFUI_player_stay_1_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_2_1.URL, WXFUI_player_stay_2_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemyStay_5.URL, WXFUI_enemyStay_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_5.URL, WXFUI_enemy_fire_5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy5.URL, WXFUI_enemy5);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_3_1.URL, WXFUI_player_stay_3_1);
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
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_setBtn.URL, WXFUI_setBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy11.URL, WXFUI_enemy11);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy12.URL, WXFUI_enemy12);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Bomb.URL, WXFUI_Bomb);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerInfoView.URL, WXFUI_PlayerInfoView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_PlayerCtlView.URL, WXFUI_PlayerCtlView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirCtlView.URL, WXFUI_dirCtlView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirBtn.URL, WXFUI_dirBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_susBtn.URL, WXFUI_susBtn);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BoomView.URL, WXFUI_BoomView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_3_1.URL, WXFUI_player_fire_3_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_1_1.URL, WXFUI_player_fire_1_1);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_2_1.URL, WXFUI_player_fire_2_1);
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
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy6.URL, WXFUI_enemy6);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy13.URL, WXFUI_enemy13);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy14.URL, WXFUI_enemy14);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_enemy_fire_13.URL, WXFUI_enemy_fire_13);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_2_2.URL, WXFUI_player_fire_2_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_2_3.URL, WXFUI_player_fire_2_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_1_2.URL, WXFUI_player_fire_1_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_1_3.URL, WXFUI_player_fire_1_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_3_2.URL, WXFUI_player_fire_3_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_fire_3_3.URL, WXFUI_player_fire_3_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_1_2.URL, WXFUI_player_stay_1_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_1_3.URL, WXFUI_player_stay_1_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_2_3.URL, WXFUI_player_stay_2_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_2_2.URL, WXFUI_player_stay_2_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_3_2.URL, WXFUI_player_stay_3_2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_stay_3_3.URL, WXFUI_player_stay_3_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_player_boom_3.URL, WXFUI_player_boom_3);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet2.URL, WXFUI_bullet2);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_TipsPopView.URL, WXFUI_TipsPopView);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_setting.URL, WXFUI_setting);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_volume.URL, WXFUI_volume);
            fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_bullet1.URL, WXFUI_bullet1);
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
