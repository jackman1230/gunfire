
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import PlayerBody from "./Body/PlayerBody";
import BoomView from "./BoomView";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { PlayerData } from "../Data/PlayerData";
import { SoundManager } from "../Manager/SoundManager";
import PlayerCtlView from "./PlayerCtlView";
import PlayerBullet from "./PlayerBullet";
import { ui } from "../ui/layaMaxUI";

export class Player extends Laya.Script {

    public rolePlayer: WXFUI_Player;
    public body: fairygui.GLoader;

    public direction: number = 1;//方向1为右，-1为左

    private sRun: boolean = false;//人物是否在跑
    private sFire: boolean = false;
    private sBoom: boolean = false;
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;
    private stillRifle: boolean = false;

    private speed: number = 5;
    private jumpHigh: number = 200;
    public weaponType: number = 1;

    public roleSprite: Laya.Sprite;
    private roleBody: Laya.RigidBody;
    private roleCol: Laya.BoxCollider;
    private bodyScript: PlayerBody;

    private playerCtlView: PlayerCtlView;
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
        this.roleCol = this.roleSprite.getComponent(Laya.BoxCollider);

        this.roleSprite.addChild(this.rolePlayer.displayObject);
        this.roleSprite.addComponent(PlayerBody);
        this.bodyScript = this.roleSprite.getComponent(PlayerBody);

        if (!this.playerCtlView) this.playerCtlView = new PlayerCtlView();
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

    public resetPos(): void {
        var d: any = GameManager.instance.curLvData;
        this.roleSprite.x = d.rolePos[0];
        this.roleSprite.y = d.rolePos[1];
        this.weaponType = GameManager.instance.roleInfo.weaponType;
        ViewManager.instance.warView.scene.addChild(this.roleSprite);

    }


    private addCtlViewMouseUp(): void {
        this.playerCtlView.view.m_ctl.m_dirBtn.y = this.playerCtlView.view.m_ctl.m_dirBtn.x = 0;
        this.setStay();
    }

    private addMouseDown(e: any): void {
        this.setDirection();
        this.playerCtlView.view.m_ctl.m_mask.on(Laya.Event.MOUSE_MOVE, this, this.setDirection);
    }

    private setDirection(): void {
        var pos: Laya.Point = this.playerCtlView.view.m_ctl.globalToLocal(Laya.stage.mouseX, Laya.stage.mouseY)
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
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
            }
        } else {
            this.keyLeft = true;
            this.keyRight = false;
            this.rolePlayer.skewY = 0;
            if (this.faceType == -1) {
                this.direction = -1;
                this.setLeftRun();
            } else {
                this.sRun = false;
                Laya.timer.clear(this, this.stillRun);
            }
        }
        this.setPlayerDir();
    }

    private addStageMouseUp(): void {
        this.playerCtlView.view.m_ctl.m_mask.off(Laya.Event.MOUSE_MOVE, this, this.setDirection);
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
        // console.log(keyCode);
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
            case 32:
                // console.log("跳");
                // if (this.keyJump) return;
                // this.setJump();
                break;
            case 81:

                break;
            case 69:
                console.log("切枪");

                // this.changeWeaponType(2);
                break;
        }
    }
    private onClickBomb(): void {
        console.log("扔雷");
        if (this.sBoom) return;
        if (GameManager.instance.roleInfo.bombNum <= 0) return;
        this.setBoom();
    }

    private onClickJump(): void {
        console.log("跳");
        if (this.keyJump) return;
        this.setJump();
    }

    public setLeftRun(): void {
        // this.setRun();
        // this.rolePlayer.skewY = 0;
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    public setRightRun(): void {
        // this.setRun();
        // this.keyRight = true;
        // this.rolePlayer.skewY = 180;
        if (this.sRun) return;
        this.setRun();
        this.stillRun();
    }

    private setPlayerDir(): void {
        if (!this.sFire) {
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        } else {
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);

        }
    }

    private colliGround(): void {
        if (this.keyJump)
            this.jumpEnd();

    }

    private jummpTween: laya.utils.Tween;
    public setJump(): void {
        this.keyJump = true;
        this.setBoomComplete();
        this.bodyLeg.url = "ui://Game/legJump";

        this.jummpTween = Laya.Tween.to(this.roleSprite, { y: this.roleSprite.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpHighHandle));
    }

    private jumpHighHandle(): void {
        this.bodyScript.keyJump = true;
        // EventManager.instance.dispatcherEvt(GameEvent.PLAYER_JUMP);
    }

    private jumpEnd(): void {
        console.log("PLAYER_COLLISION_GROUND---");
        this.keyJump = false;
        if (GameManager.instance.roleInfo.isDeath = true) return;
        if (this.sBoom) {
            this.setBoomComplete();
        } else if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + this.direction;
        }
        if (this.sRun) {
            this.bodyLeg.url = "ui://Game/legMove";
            this.bodyLeg.content.rewind();
            return;
        }
        this.stopMove();
    }

    public setRun(): void {
        EventManager.instance.dispatcherEvt(GameEvent.PLAYER_RUN);
        if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        } else {
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        }
        this.bodyLeg.url = "ui://Game/legMove";
        this.sRun = true;
        Laya.timer.clear(this, this.stillRun);
        Laya.timer.frameLoop(1, this, this.stillRun);
    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.roleSprite.x += this.speed;//做一个卡点的坐标可以随意移动
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
        } else if (this.direction == -1) {
            this.roleSprite.x -= this.speed;
            if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
        }
    }

    public setFire(): void {
        if (this.sFire) return;
        if (this.sBoom) return;
        if (this.stillRifle) return;
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
        var b: PlayerBullet = ViewManager.instance.createBullet();
        if (this.weaponType == PlayerData.WEAPON_RIFLE) {//如果是来福枪
            this.stillRifle = true;
            Laya.timer.once(700, this, this.rilfeComplete);
            Laya.timer.loop(800, this, this.stillFire);
        } else {//如果是子弹枪
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
        if (this.sBoom) return;


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
        }
    }

    private rilfeComplete(): void {
        this.stillRifle = false;
    }

    private setFireEnd(): void {
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

    public setBoom(): void {
        this.sBoom = true;
        // this.rolePlayer["m_firePos" + this.weaponType].visible = false;
        EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BOMB);
        this.body.url = "ui://Game/player_boom_" + this.weaponType;
        this.bodybody.content.setPlaySettings(0, -1, 1, -1);
        Laya.timer.once(700, this, this.setBoomComplete);
        ViewManager.instance.createBomb(PlayerData.WEAPON_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.roleSprite), true);
        // if (this.sRun) {
        //     this.bodyLeg.url = "ui://Game/legMove";
        //     this.bodyLeg.content.setPlaySettings(0, -1, 0, 0);
        //     return;
        // }
        // if (this.keyJump)
        //     this.bodyLeg.url = "ui://Game/legJump";
    }

    private setBoomComplete(): void {
        this.sBoom = false;
        // if (this.keyJump) return;
        // this.bodyLeg.content.rewind();
        if (this.sFire)
            this.body.url = "ui://Game/player_fire_" + this.weaponType + "_" + Math.abs(this.faceType);
        else
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
        // if (this.sRun) {
        //     this.bodyLeg.url = "ui://Game/legMove";
        //     return;
        // }
        // if (this.keyJump)
        //     this.bodyLeg.url = "ui://Game/legJump";
    }


    public stopMove(): void {
        EventManager.instance.dispatcherEvt(GameEvent.PLAYER_STAY);
        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        // this.keyJump = false;
        this.bodyLeg.url = "ui://Game/legStay";
        Laya.timer.clear(this, this.stillRun);
    }

    public setStay(): void {
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

    private changeWeaponType(type: number): void {
        this.weaponType = GameManager.instance.roleInfo.weaponType = type;
        if (this.sFire) {
            Laya.timer.clear(this, this.stillFire);
            this.sFire = false;
            this.setFire();
        } else
            this.body.url = "ui://Game/player_stay_" + this.weaponType + "_" + Math.abs(this.faceType);
    }

    private setDeath(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        GameManager.instance.roleInfo.isDeath = true;
        Laya.timer.clearAll(this);
        EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        this.body.url = "ui://Game/player_death";
        this.body.content.setPlaySettings(0, -1, 1, this.body.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
        this.playDeathSound();
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

    public beHit(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        Laya.timer.clear(this, this.setColor);
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
        return this.bodyComponent.getChildAt(0).asLoader;
    }

    private get bodybody(): fairygui.GLoader {
        return this.bodyComponent.getChildAt(1).asLoader;
    }

    public dispose(): void {
        // EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);
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
        // EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.dispose);


        Laya.timer.clearAll(this);
        this.roleSprite.removeChildren();
        this.roleSprite.removeSelf();
        this.rolePlayer.dispose();
        this.roleSprite.destroy();
        this.roleSprite = null;
        this.recover();
    }

    protected recover(): void {
        Laya.Pool.recover("player", this);
    }

}