
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import PlayerBody from "./Body/PlayerBody";
import BoomView from "./BoomView";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { PlayerData } from "../Data/PlayerData";

export default class Player extends Laya.Script {

    public rolePlayer: WXFUI_Player;
    public playerAni: PlayerAni;
    public body: fairygui.GLoader;

    public direction: number = 0;

    private sRun: boolean = false;//人物是否在跑
    private sFire: boolean = false;
    private sBoom: boolean = false;
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;
    // private isDeath: boolean = false;

    private speed: number = 5;
    private jumpHigh: number = 200;
    public weaponType: number = 1;

    public roleSprite: Laya.Sprite;
    private roleBody: Laya.RigidBody;

    // private _hp: number = 100;

    constructor() { super() }

    public createView() {
        Laya.Scene.load("PlayerBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    private loadComplete(s: Laya.Sprite): void {

        this.roleSprite = s;
        this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player") as WXFUI_Player;
        this.rolePlayer.setPivot(0.5, 0.5);

        ViewManager.instance.warView.scene.addChild(this.roleSprite);
        var d: any = GameManager.instance.curLvData;
        this.roleSprite.x = d.rolePos[0];
        this.roleSprite.y = d.rolePos[1];

        this.body = this.rolePlayer.getChildAt(0) as fairygui.GLoader;

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


    private keyUpEvent(e: any): void {
        var keyCode: number = e["keyCode"];
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

    private keyDowmEvent(e: any): void {
        var keyCode: number = e["keyCode"];
        // console.log(keyCode);

        switch (keyCode) {
            case 87:
                console.log("上");
                break;
            case 83:
                console.log("下");
                break;
            case 65:
                this.keyLeft = true;
                // console.log("左");
                this.setLeft();
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 68:
                this.keyRight = true;
                // console.log("右");
                this.setRight();
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 32:
                console.log("跳");
                // if (this.keyJump) return;
                this.setJump();
                break;
            case 81:
                console.log("扔雷");
                if (this.sBoom) return;
                if (GameManager.instance.roleInfo.bombNum <= 0) return;
                this.setBoom();
                break;
            case 69:
                console.log("切枪");

                // this.changeWeaponType(2);
                break;
        }
    }

    public setLeft(): void {
        if (this.direction == -1) return;
        this.direction = -1;
        this.rolePlayer.skewY = 0;
    }

    public setRight(): void {
        if (this.direction == 1) return;
        this.direction = 1;
        this.rolePlayer.skewY = 180;
    }

    private colliGround(): void {
        if (this.keyJump) this.jumpEnd();
        // if (this.jummpTween && this.keyJump)
        //     Laya.Tween.clear(this.jummpTween);

    }

    private jummpTween: laya.utils.Tween;
    public setJump(): void {
        // if (this.sBoom) return;
        this.setBoomComplete();
        this.keyJump = true;
        this.bodyLeg.url = "ui://Game/legJump";
        this.roleBody.setVelocity({ x: 0, y: -10 });
        EventManager.instance.dispatcherEvt(GameEvent.PLAYER_JUMP);
        // this.jummpTween = Laya.Tween.to(this.roleBody, { y: this.roleBody.y - this.jumpHigh }, 350, null, Laya.Handler.create(this, this.jumpEnd));
    }

    private jumpEnd(): void {
        // this.jummpTween = Laya.Tween.to(this.roleSprite, { y: this.roleSprite.y + this.jumpHigh }, 350, null, Laya.Handler.create(this, () => {
        this.keyJump = false;
        if (this.sBoom) {
            this.setBoomComplete();
        } else if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
        }
        if (this.sRun) {
            this.bodyLeg.url = "ui://Game/legMove";
            this.bodyLeg.content.rewind();
            return;
        }
        this.stopMove();
        // }));
    }

    // private runTime: number = 50;
    public setRun(): void {
        if (this.sRun) return;
        if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
        } else {
            this.body.url = "ui://Game/player_stay_" + this.weaponType;
        }
        this.bodyLeg.url = "ui://Game/legMove";
        this.sRun = true;
        Laya.timer.clear(this, this.stillRun);
        Laya.timer.frameLoop(1, this, this.stillRun);

    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.roleSprite.x += this.speed;//做一个卡点的坐标可以随意移动
            if (GameManager.instance.bossDeath) {
                if (this.roleSprite.x > ViewManager.instance.warView.warView.width - 200) {
                    // EventManager.instance.dispatcherEvt(GameEvent.VICITORY_LEVEL);
                    GameManager.instance.victoryGame();
                }
            }
            if (Math.abs(ViewManager.instance.warView.warView.x) + Laya.stage.width > ViewManager.instance.warView.warView.width - 20)
                return;
            if (this.roleSprite.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.stage.width / 2) {
                ViewManager.instance.updateViewPort(this.speed);
            }
        } else {
            this.roleSprite.x -= this.speed;
            if (this.roleSprite.x < Math.abs(ViewManager.instance.warView.warView.x))
                this.roleSprite.x = Math.abs(ViewManager.instance.warView.warView.x);
        }
    }

    public setFire(): void {
        if (this.sFire) return;
        if (this.sBoom) return;
        this.sFire = true;
        this.body.url = "ui://Game/player_fire_" + this.weaponType;
        this.rolePlayer.m_fireType.selectedIndex = this.weaponType - 1;
        Laya.timer.clear(this, this.stillFire);
        this.rolePlayer["m_firePos" + this.weaponType].visible = true;
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
        if (this.weaponType == PlayerData.WEAPON_RIFLE) {//如果是来福枪
            var c: fairygui.MovieClip = this.rolePlayer["m_firePos" + this.weaponType].content;
            c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
        } else {//如果是子弹枪
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

    private stillFireNum: number = 1;
    private stillFire(): void {
        if (this.sBoom) return;
        this.stillFireNum++;
        if (this.stillFireNum % 2 == 0) {
            this.rolePlayer["m_firePos" + this.weaponType].visible = false;
        } else {
            this.rolePlayer["m_firePos" + this.weaponType].visible = true;
            ViewManager.instance.createBullet();
        }
        if (this.weaponType != PlayerData.WEAPON_PIS) {
            EventManager.instance.dispatcherEvt(GameEvent.USE_PLAYER_BULLET);
        }
    }

    private rilfeComplete(): void {
        if (this.sFire) {
            var c: fairygui.MovieClip = this.rolePlayer["m_firePos" + this.weaponType].content;
            c.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.rilfeComplete));
        }
    }

    private setFireEnd(): void {
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

    public setBoom(): void {
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

    private setBoomComplete(): void {
        this.sBoom = false;
        if (this.keyJump) return;
        // this.bodyLeg.content.rewind();
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

    // private stopFire(): void {
    //     this.sFire = false;
    //     Laya.timer.clear(this, this.stillFire);
    // }

    public stopMove(): void {
        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        this.keyJump = false;
        this.bodyLeg.url = "ui://Game/legStay";
        // this.rigidBody.setVelocity({ x: 0, y: 0 });
        Laya.timer.clear(this, this.stillRun);
    }

    public setStay(): void {
        this.body.url = "ui://Game/player_stay_" + this.weaponType;
        this.stopMove();
        Laya.timer.clear(this, this.stillFire);
    }

    private changeWeaponType(type: number): void {
        // if (this.sBoom) return;
        // this.sFire = false;
        // this.weaponType++;
        this.weaponType = GameManager.instance.roleInfo.weaponType = type;
        if (this.sFire) {
            this.body.url = "ui://Game/player_fire_" + this.weaponType;
        } else
            this.body.url = "ui://Game/player_stay_" + this.weaponType;

        // if (this.sRun) this.bodyLeg.url = "ui://Game/legMove";
        // if (this.keyJump) this.bodyLeg.url = "ui://Game/legJump";
    }

    private setDeath(): void {
        if (GameManager.instance.roleInfo.isDeath) return;
        GameManager.instance.roleInfo.isDeath = true;
        Laya.timer.clearAll(this);
        EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.beHit);
        this.body.url = "ui://Game/player_death";
        this.body.content.setPlaySettings(0, -1, 1, this.body.content.frameCount - 1, Laya.Handler.create(this, this.deathComplete));
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

        console.log("player--be--hit");
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

}