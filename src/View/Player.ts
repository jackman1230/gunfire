
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import { ViewManager } from "../Manager/ViewManager";
import PlayerBody from "./Body/PlayerBody";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { PlayerData } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import PlayerCtlView from "./PlayerCtlView";
import PlayerBullet from "./PlayerBullet";
import { ui } from "../ui/layaMaxUI";
import { GameData } from "../Data/GameData";
import PlayerDirView from "./PlayerDirView";

export class Player extends Laya.Script {

    public rolePlayer: WXFUI_Player;
    public body: fairygui.GLoader;

    public direction: number = 1;//方向1为右，-1为左

    public sRun: boolean = false;//人物是否在跑
    private sFire: boolean = false;//机枪，手枪连续射击
    private sBoom: boolean = false;
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;
    private stillRifle: boolean = false;
    private isSquatDown: boolean = false;

    private speed: number = 5;
    private jumpHigh: number = 200;
    public weaponType: number = 1;

    public roleSprite: Laya.Sprite;
    public roleBody: Laya.RigidBody;
    public roleBox: Laya.BoxCollider;
    public bodyScript: PlayerBody;

    //操作控制界面
    public playerCtlView: PlayerCtlView;
    //方向控制界面
    public playerDirView: PlayerDirView;
    public faceType: number = 1;//面朝向

    constructor() { super() }

    public createView() {
        this.roleSprite = new ui.PlayerBodyUI();
        this.loadComplete();
        // Laya.Scene.load("PlayerBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    private loadComplete(): void {
        // this.roleSprite = s;
        this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player") as WXFUI_Player;
        this.rolePlayer.setPivot(0.5, 0.5);
        this.body = this.rolePlayer.getChildAt(0) as fairygui.GLoader;

        this.rolePlayer.m_fireType.selectedIndex = 0;
        this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = this.rolePlayer.m_firePos3.visible = false;

        this.roleBody = this.roleSprite.getComponent(Laya.RigidBody);
        this.roleBox = this.roleSprite.getComponent(Laya.BoxCollider);

        this.roleSprite.addChild(this.rolePlayer.displayObject);
        this.roleSprite.addComponent(PlayerBody);
        this.bodyScript = this.roleSprite.getComponent(PlayerBody);

        if (!this.playerCtlView) this.playerCtlView = new PlayerCtlView();
        // fairygui.GRoot.inst.addChild(this.playerCtlView.view);

        if (!this.playerDirView) this.playerDirView = new PlayerDirView();
        // fairygui.GRoot.inst.addChild(this.playerDirView.view);

        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        this.addEvent();
        this.resetData();
        this.setStay();
    }

    private addEvent(): void {
        EventManager.instance.addNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
        EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);
        EventManager.instance.addNotice(GameEvent.GOTO_HOLE, this, this.gotoHole);

        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_DOWN, this, this.keyFireDown);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_UP, this, this.keyFireUp);
        this.playerCtlView.view.m_fire.on(Laya.Event.MOUSE_OUT, this, this.keyFireUp);
        this.playerCtlView.view.m_bomb.on(Laya.Event.CLICK, this, this.onClickBomb);
        this.playerCtlView.view.m_jump.on(Laya.Event.CLICK, this, this.onClickJump);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_OUT, this, this.addCtlViewMouseUp);
        // this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);

    }

    public resetData(): void {
        this.addEvent();
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        var d: any = GameManager.instance.curLvData;
        this.roleSprite.x = d.rolePos[0];
        this.roleSprite.y = d.rolePos[1];
        this.sBoom = false;
        this.sRun = false;
        this.stillRifle = false;
        this.usePan = false;
        this.setFireEnd();
        this.jumpEnd();
        this.changeWeaponType(GameManager.instance.roleInfo.weaponType);
        ViewManager.instance.warView.scene.addChild(this.roleSprite);
        // GameManager.instance.roleInfo.bulletNum = 100;
        Laya.timer.clearAll(this);
        Laya.timer.loop(500, this, this.moveMap);
        this.setStay();

    }
    //原地复活加无敌
    public playerRes(): void {
        this.addCtlViewMouseUp(null);
        this.addEvent();
        this.sBoom = false;
        this.sRun = false;
        this.stillRifle = false;
        this.usePan = false;
        this.keyJump = false;
        this.keyFireUp();
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        Laya.timer.clearAll(this);
        Laya.timer.loop(500, this, this.moveMap);
        this.setStay();
        Laya.timer.once(3000, this, this.cancleInvincible);
        this.bodyLeg.color = "#ffff00";
        this.bodybody.color = "#ffff00";
    }

    //取消无敌
    private cancleInvincible(): void {
        GameManager.instance.roleInfo.isInvincible = false;
        this.setColor();
    }
    //掉到洞里面去了
    private gotoHole(): void {
        this.setDeath();
    }

    //取消方向控制
    private addCtlViewMouseUp(e: Laya.Event): void {
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
        this.playerDirView.view.m_dirBtn.y = this.playerDirView.view.m_dirBtn.x = 0;
        this.setFaceDirection();
        this.setStandUp();
        this.stopMove();
    }

    private setFaceDirection(): void {
        if (this.faceType > 0) {
            this.faceType = this.direction = 1;
            this.setFaceRight();
        } else {
            this.faceType = this.direction = -1;
            this.setFaceLeft();
        }
    }

    private keyFire: boolean = false;
    private keyFireDown(): void {
        this.keyFire = true;
        this.setFire();
    }

    private keyFireUp(): void {
        this.keyFire = false;
        this.setFireEnd();
    }


    private curTouchId: number = 0;
    private addMouseDown(e: Laya.Event): void {
        this.curTouchId = e.touchId;
        this.setDirection();
        this.playerDirView.view.m_mask.on(Laya.Event.MOUSE_MOVE, this, this.onMoveHandle);
    }

    private onMoveHandle(e: Laya.Event): void {
        if (e.touchId != this.curTouchId) return;
        this.setDirection();
    }

    private setDirection(): void {
        var pos: Laya.Point = this.playerDirView.view.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY)
        pos.x += 131;
        pos.y += 131;

        this.playerDirView.view.m_dirBtn.x = pos.x;
        this.playerDirView.view.m_dirBtn.y = pos.y;
        if (pos.x > 130)
            this.playerDirView.view.m_dirBtn.x = 130;
        if (pos.x < -130)
            this.playerDirView.view.m_dirBtn.x = -130;
        if (pos.y > 130)
            this.playerDirView.view.m_dirBtn.y = 130;
        if (pos.y < -130)
            this.playerDirView.view.m_dirBtn.y = -130;
        var face: number = ViewManager.instance.getPlayerDirection(pos);
        if (face == this.faceType) return;
        this.faceType = GameManager.instance.roleInfo.direction = face;
        this.setFaceType();
    }

    private setFaceType(): void {
        if (this.faceType > 0) {
            this.setFaceRight();
            if (this.faceType == 1) {
                this.direction = 1;
                this.setRightRun();
                this.setStandUp();
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
                if (this.faceType == 5) {
                    this.setSquatDown();
                } else
                    this.setStandUp();
            }
        } else {
            this.setFaceLeft();
            if (this.faceType == -1) {
                this.direction = -1;
                this.setLeftRun();
                this.setStandUp();
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
                if (this.faceType == -5) {
                    this.setSquatDown();
                } else
                    this.setStandUp();
            }
        }
    }

    //蹲下
    private setSquatDown(): void {
        if (this.isSquatDown) return
        this.isSquatDown = true;
        this.roleSprite.y += 20;
        this.roleBox.height = 70;
        this.rolePlayer.y = -20;
        console.log("setSquatDown");

    }
    private setStandUp(): void {
        if (!this.isSquatDown) return;
        this.isSquatDown = false;
        this.roleSprite.y -= 20;
        this.roleBox.height = 90;
        this.rolePlayer.y = 0;
        console.log("setStandUp");
    }
    private setFaceRight(): void {
        this.rolePlayer.skewY = 180;
        this.keyRight = true;
        this.keyLeft = false;
        this.setPlayerDir();
    }

    private setFaceLeft(): void {
        this.keyLeft = true;
        this.keyRight = false;
        this.rolePlayer.skewY = 0;
        this.setPlayerDir();
    }
    private onClickBomb(): void {
        if (this.sBoom) return;
        if (GameManager.instance.roleInfo.bombNum <= 0) return;
        this.setBoom();
    }

    private onClickJump(): void {
        if (this.keyJump) return;
        this.setJump();
    }

    public setLeftRun(): void {
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    public setRightRun(): void {
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    private setPlayerDir(): void {
        if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        } else {
            if (this.keyJump) return;
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        }
    }

    private colliGround(): void {
        this.jumpEnd();

    }

    private jummpTween: laya.utils.Tween;
    public setJump(): void {
        this.keyJump = this.bodyScript.keyJump = true;
        this.setBoomComplete();
        this.bodyLeg.url = "ui://Game/legJump";

        this.roleBody.setVelocity({ x: 0, y: -11 });
        this.roleBox.refresh();
        Laya.timer.once(200, this, this.jumpHighHandle);
        // this.jummpTween = Laya.Tween.to(this.roleSprite, { y: this.roleSprite.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpHighHandle));
    }

    private jumpHighHandle(): void {
        this.bodyScript.keyJumpEnd = true;
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_JUMP);
    }

    private jumpEnd(): void {
        this.keyJump = false;
        this.stopMove();
        if (GameManager.instance.roleInfo.isDeath) return;
        if (this.sBoom) {
            this.setBoomComplete();
        }
    }

    public setRun(): void {
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_RUN);
        // this.roleBody.type = "dynamic";
        if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        }
        if (this.keyJump)
            this.bodyLeg.url = "ui://Game/legJump";
        else {
            this.bodyLeg.url = "ui://Game/legMove";
        }
        this.sRun = true;
        Laya.timer.clear(this, this.stillRun);
        Laya.timer.frameLoop(1, this, this.stillRun);
    }

    private moveMap(): void {
        if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
            return;
        if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - this.roleSprite.width / 2 >= Laya.stage.width / 2) {
            var dis: number = this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - Laya.stage.width / 2;
            ViewManager.instance.updateViewPort(dis);
        }
    }

    // public tweenRun: boolean = false;
    public stillRun(): void {
        if (this.direction == 1) {
            this.roleSprite.x += this.speed;
            if (this.roleSprite.x > ViewManager.instance.warView.warView.width - this.roleSprite.width - 200) {
                this.roleSprite.x = ViewManager.instance.warView.warView.width - this.roleSprite.width - 200;
                // return;
            }
            if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 200)
                return;
            // if (this.tweenRun) return;
            // if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - this.roleSprite.width / 2 >= Laya.stage.width / 2) {
            //     var dis: number = this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) - Laya.stage.width / 2;
            //     // ViewManager.instance.updateViewPort(this.speed);
            //     this.tweenRun = true;
            //     ViewManager.instance.updateViewPort(dis);
            // }
        } else if (this.direction == -1) {
            this.roleSprite.x -= this.speed;
            if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
        }
    }


    public setFire(): void {
        if (this.sFire) return;
        if (this.stillRifle) return;
        if (GameManager.instance.roleInfo.isDeath) return;
        this.playWeaponSound();
        var p: boolean = GameManager.instance.useWeaponPan(this.roleSprite.x, this.roleSprite.y, this.direction);
        if (p) {
            this.setPanFire();
            return;
        }
        this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        this.rolePlayer.m_fireType.selectedIndex = this.weaponType - 1;
        this.setFireAniSkew();
        Laya.timer.clear(this, this.stillFire);
        this.rolePlayer["m_firePos" + this.weaponType].visible = true;
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
        var b: PlayerBullet = ViewManager.instance.createBullet();
        if (this.weaponType == PlayerData.WEAPON_RIFLE) {//如果是来福枪
            this.stillRifle = true;
            Laya.timer.once(600, this, this.rilfeComplete);
        } else {//如果是子弹枪
            this.sFire = true;
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

    private stillFireNum: number = 1;
    private stillFire(): void {
        // if (this.sBoom) return;
        this.setFireAniSkew();
        this.stillFireNum++;
        if (this.stillFireNum % 2 == 0) {
            this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
        } else {
            this.rolePlayer["m_firePos" + this.weaponType].visible = true;
        }
        ViewManager.instance.createBullet();
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
        this.playWeaponSound();
    }

    private rilfeComplete(): void {
        this.stillRifle = false;
        if (this.keyFire) {
            this.setFire();
        } else {
            this.setFireEnd();
            this.stopFire();
        }
    }

    private usePan: boolean = false;
    private setPanFire(): void {
        if (this.faceType == 5) {
            this.body.url = "ui://Game/player_fire_5_5";
        } else {
            this.body.url = "ui://Game/player_fire_5_1";
        }
        this.usePan = true;
        this.bodybody.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.panFireComplete));
        Laya.timer.frameOnce(2, this, () => {
            ViewManager.instance.showPlayerPanBody();
        });
        if (this.sRun) {
            this.bodyLeg.url = "ui://Game/legMove";
            return;
        }
        if (this.keyJump)
            this.bodyLeg.url = "ui://Game/legJump";
    }

    private panFireComplete(): void {
        this.usePan = false;
        ViewManager.instance.hidePlayerPanBody();
        if (this.keyFire) {
            this.setFire();
        } else {
            this.setFireEnd();
            this.stopFire();
        }
    }

    private setFireEnd(): void {
        Laya.timer.clear(this, this.stillFire);
        this.sFire = false;
        this.stillFireNum = 1;
        this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
        if ((this.weaponType == PlayerData.WEAPON_MAC || this.weaponType == PlayerData.WEAPON_PIS) && !this.usePan) {
            this.stopFire();
        }
    }
    private stopFire(): void {
        this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        if (this.keyJump) {
            this.bodyLeg.url = "ui://Game/legJump";
            return;
        }
        if (this.sRun) {
            this.bodyLeg.url = "ui://Game/legMove";
        }
    }

    private setFireAniSkew(): void {
        this.rolePlayer.m_firePos.selectedIndex = Math.abs(this.faceType) - 1;
        if (Math.abs(this.faceType) == 1) {
            this.rolePlayer.m_firePos1.setSkew(180, 180);
            this.rolePlayer.m_firePos2.setSkew(180, 180);
        } else if (Math.abs(this.faceType) == 2) {
            this.rolePlayer.m_firePos1.setSkew(160, 160);
            this.rolePlayer.m_firePos2.setSkew(160, 160);
        } else if (Math.abs(this.faceType) == 3) {
            this.rolePlayer.m_firePos1.setSkew(200, 200);
            this.rolePlayer.m_firePos2.setSkew(200, 200);
        } else if (Math.abs(this.faceType) == 4) {
            this.rolePlayer.m_firePos1.setSkew(270, 270);
            this.rolePlayer.m_firePos2.setSkew(270, 270);
        } else if (Math.abs(this.faceType) == 5) {
            this.rolePlayer.m_firePos1.setSkew(180, 180);
            this.rolePlayer.m_firePos2.setSkew(180, 180);
        }
    }

    public setBoom(): void {
        this.sBoom = true;
        // this.rolePlayer["m_firePos" + this.weaponType].visible = false;
        EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);
        this.body.url = "ui://Game/player_boom_" + this.weaponType;
        this.bodybody.content.setPlaySettings(0, -1, 1, -1);
        Laya.timer.once(700, this, this.setBoomComplete);
        ViewManager.instance.createBomb(PlayerData.WEAPON_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
    }

    private setBoomComplete(): void {
        this.sBoom = false;
        if (this.sFire)
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        else
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
    }


    public stopMove(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        Laya.timer.clear(this, this.stillRun);
        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        this.bodyLeg.url = "ui://Game/legStay";
    }

    public setStay(): void {
        if (this.faceType > 0) {
            this.direction = 1;
            this.rolePlayer.skewY = 180;
        } else {
            this.direction = -1;
            this.rolePlayer.skewY = 0;
        }
        Laya.timer.clear(this, this.stillFire);
        this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        this.stopMove();
    }

    private changeWeaponType(type: number): void {
        this.weaponType = GameManager.instance.roleInfo.weaponType = type;
        if (this.sFire) {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.setFire();
        } else {
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        }
        if (this.keyJump) {
            this.bodyLeg.url = "ui://Game/legJump";
            return;
        }
        if (this.sRun) {
            this.bodyLeg.url = "ui://Game/legMove";
        }

    }

    private setDeath(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        GameManager.instance.roleInfo.isDeath = true;
        Laya.timer.clearAll(this);
        this.removeEvent();
        this.setFireEnd();
        this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
        this.body.url = "ui://Game/player_death";
        this.bodybody.content.setPlaySettings(0, -1, 1, this.body.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
        this.playDeathSound();
        ViewManager.instance.showAfterWarView(3);
    }

    public victoryGame(): void {
        this.setStay();
        this.removeEvent();
        this.rolePlayer.m_firePos1.visible = this.rolePlayer.m_firePos2.visible = false;
        GameManager.instance.roleInfo.curlvCoin += GameData.VICTORY_LEVEL_COIN;
        GameManager.instance.roleInfo.totalCoin += GameData.VICTORY_LEVEL_COIN;
        ViewManager.instance.playerInfoView.updateCoin();
    }

    private playDeathSound(): void {
        var s: number = 1;
        var r: number = Math.random();
        if (r > 0.75) s = 4;
        if (r > 0.5) s = 3;
        if (r > 0.25) s = 2;
        s = 1;
        SoundManager.instance.playSound("die_" + s);
    }

    private playWeaponSound(): void {
        SoundManager.instance.playSound("weapon_" + this.weaponType);

    }

    private deathComplete(): void {
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_DEATH)
    }

    private disposeEnemyBullet(s: any): void {

    }
    public beHit(s: any): void {
        this.disposeEnemyBullet(s);
        // console.log("playerBehit");
        if (GameManager.instance.roleInfo.isInvincible) return;
        if (GameManager.instance.roleInfo.isDeath) return;
        GameManager.instance.roleInfo.blood--;
        EventManager.instance.dispatcherEvt(GameEvent.DEC_PLAYER_BLOOD);
        if (GameManager.instance.roleInfo.blood <= 0) {
            GameManager.instance.roleInfo.blood = 0;
            this.setDeath();
            return;
        }
        Laya.timer.clear(this, this.setColor);
        // this.rolePlayer.m_body.color = "#ff0000";
        this.bodyLeg.color = "#ff0000";
        this.bodybody.color = "#ff0000";
        Laya.timer.once(200, this, this.setColor);
    }
    private setColor(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        this.bodyLeg.color = "#ffffff";
        this.bodybody.color = "#ffffff";
    }

    private get bodyComponent(): fairygui.GComponent {
        return this.body.component;
    }

    private get bodyLeg(): fairygui.GLoader {
        if (this.bodyComponent)
            return this.bodyComponent.getChildAt(0).asLoader;
    }

    private get bodybody(): fairygui.GLoader {
        if (this.bodyComponent)
            return this.bodyComponent.getChildAt(1).asLoader;
    }

    public dispose(): void {
        this.removeEvent();

        Laya.timer.clearAll(this);
        this.roleSprite.removeChildren();
        this.roleSprite.removeSelf();
        this.rolePlayer.dispose();
        this.roleSprite.destroy();
        this.roleSprite = null;
        this.recover();
    }

    private removeEvent(): void {
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_DOWN, this, this.setFire);
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_UP, this, this.setFireEnd);
        this.playerCtlView.view.m_fire.off(Laya.Event.MOUSE_OUT, this, this.setFireEnd);
        this.playerCtlView.view.m_bomb.off(Laya.Event.CLICK, this, this.onClickBomb);
        this.playerCtlView.view.m_jump.off(Laya.Event.CLICK, this, this.onClickJump);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_DOWN, this, this.addMouseDown);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_UP, this, this.addCtlViewMouseUp);
        this.playerDirView.view.m_mask.off(Laya.Event.MOUSE_OUT, this, this.addCtlViewMouseUp);

        Laya.stage.off(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
        Laya.stage.off(Laya.Event.KEY_UP, this, this.keyUpEvent);

        EventManager.instance.offNotice(GameEvent.PLAYER_COLLISION_GROUND, this, this.colliGround);
        EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.CHANGE_PLAYER_WEAPON, this, this.changeWeaponType);

    }

    protected recover(): void {
        Laya.Pool.recover("player", this);
    }


    private keyUpEvent(e: any): void {
        var keyCode: number = e["keyCode"];
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

    private keyDowmEvent(e: any): void {
        var keyCode: number = e["keyCode"];
        switch (keyCode) {
            case 87:
                // this.setFire();
                console.log("上");
                // this.setStandUp();
                // this.isSquatDown = false;
                // this.roleSprite.y -= 20;
                // this.roleBox.height = 90;
                // this.rolePlayer.y = 0;
                this.faceType = 5;
                this.setFaceType();
                break;
            case 83:
                console.log("下");
                // this.isSquatDown = true;
                // this.roleSprite.y += 20;
                // this.roleBox.height = 70;
                // this.rolePlayer.y = -20;
                // this.setSquatDown();
                this.faceType = -5;
                this.setFaceType();
                break;
            case 65:
                this.keyLeft = true;
                this.rolePlayer.skewY = 0;
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 68:
                this.keyRight = true;
                this.rolePlayer.skewY = 180;
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
        }
    }

}