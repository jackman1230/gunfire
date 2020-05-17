
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import { PlayerData } from "../Data/PlayerData";
import Bullet from "./Bullet";

export default class Player {

    public rolePlayer: WXFUI_Player;
    public playerAni: PlayerAni;
    public body: fairygui.GLoader;
    public fireTypeCtl: fairygui.Controller;
    public firePosCtl: fairygui.Controller;
    public firePos1: fairygui.GLoader;
    public firePos2: fairygui.GLoader;

    public direction: number = 0;

    private sRun: boolean = false;//人物是否在跑
    private sFire: boolean = false;
    private sBoom: boolean = false;
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;

    private speed: number = 5;
    private jumpHigh: number = 200;
    public weaponType: number = 1;

    private rigidBody: Laya.RigidBody;
    private boxCollider: Laya.BoxCollider;

    constructor() { }

    public initView() {
        this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player") as WXFUI_Player;
        this.rolePlayer.setPivot(0.5, 0.5);

        this.body = this.rolePlayer.getChildAt(0) as fairygui.GLoader;
        this.firePos1 = this.rolePlayer.getChildAt(1) as fairygui.GLoader;
        this.firePos2 = this.rolePlayer.getChildAt(2) as fairygui.GLoader;
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
        // this.rigidBody.setVelocity({ x: this.speed, y: 0 });
        this.rigidBody.linearDamping = 0;
        this.boxCollider.width = this.rolePlayer.displayObject.width;
        this.boxCollider.height = this.rolePlayer.displayObject.height;
        // this.boxCollider.refresh
        this.boxCollider.friction = 0;
        console.log(this.boxCollider);
        // r.group = 1;
        // Laya.Browser.window.matter  _sysPhysicToNode

        // this.rolePlayer.displayObject
        // this.rigidBody.type = "kinematic";

        // Laya.Physics.I.positionIterations

        this.setStay();
        this.setRight();

        Laya.stage.on(Laya.Event.KEY_DOWN, this, this.keyDowmEvent);
        Laya.stage.on(Laya.Event.KEY_UP, this, this.keyUpEvent);
        Laya.stage.on(Laya.Event.MOUSE_DOWN, this, this.setFire);
        Laya.stage.on(Laya.Event.MOUSE_UP, this, this.setFireEnd);

        var nu: number = 0;
        // Laya.timer.loop(500, this, () => {
        //     nu++;
        //     console.log("roleplayer--" + this.rolePlayer.x, this.rolePlayer.y);
        //     console.log(this.boxCollider);
        //     var w = this.rigidBody.getWorldCenter();
        //     console.log("worldpos22");
        //     console.log(w)
        //     // this.rolePlayer.x = w.x;
        //     // this.rolePlayer.y = w.y;
        //     if (nu > 6) {
        //         Laya.timer.clearAll(this);
        //     }
        // })
    };

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
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 68:
                this.keyRight = true;
                console.log("右");
                this.setRight();
                if (this.sRun) return;
                this.setRun();
                this.stillRun();
                break;
            case 32:
                console.log("跳");
                if (this.keyJump) return;
                this.setJump();
                break;
            case 81:
                console.log("扔雷");
                if (this.sBoom) return;
                this.setBoom();
                break;
            case 69:
                console.log("切枪");
                this.changeWeaponType();
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

    public setJump(): void {
        // if (this.sBoom) return;
        this.setBoomComplete();
        this.keyJump = true;
        this.bodyLeg.url = "ui://Game/legJump";
        Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y - this.jumpHigh }, 300, null, Laya.Handler.create(this, this.jumpEnd));
    }

    private jumpEnd(): void {
        Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y + this.jumpHigh }, 300, null, Laya.Handler.create(this, () => {
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
        }));
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
        var w = this.rigidBody.getWorldCenter();
        if (this.direction == 1) {
            // this.rigidBody.setVelocity({ x: this.speed, y: 0 });
            this.rolePlayer.x += this.speed;//做一个卡点的坐标可以随意移动
            if (this.rolePlayer.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.Browser.clientWidth / 2) {
                // this.rolePlayer.x = Laya.Browser.clientWidth / 2;
                // w.x = Laya.Browser.clientWidth / 2;
                ViewManager.instance.updateViewPort(this.speed);
            }
            // if (w.x - Math.abs(ViewManager.instance.warView.warView.x) >= Laya.Browser.clientWidth / 2) {
            //     // this.rolePlayer.x = Laya.Browser.clientWidth / 2;
            //     ViewManager.instance.updateViewPort(this.speed);
            // }
        } else {
            this.rigidBody.setVelocity({ x: -this.speed, y: 0 });
            if (w.x < Math.abs(ViewManager.instance.warView.warView.x))
                w.x = Math.abs(ViewManager.instance.warView.warView.x);
        }
        // else {
        //     this.rolePlayer.x -= this.speed;
        //     if (this.rolePlayer.x < Math.abs(ViewManager.instance.warView.warView.x))
        //         this.rolePlayer.x = Math.abs(ViewManager.instance.warView.warView.x);
        // }


        console.log("roleplayer--" + this.rolePlayer.x, this.rolePlayer.y);
        // console.log(this.boxCollider);
        console.log("www--", w.x, w.y);
        var b = this.rigidBody.getCenter();
        console.log("bbb--", b.x, b.y);

    }

    public setFire(): void {
        if (this.sFire) return;
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
    private stillFireNum: number = 1;
    private stillFire(): void {
        this.stillFireNum++;
        if (this.stillFireNum % 2 == 0) {
            this["firePos" + this.weaponType].visible = false;
        } else {
            this["firePos" + this.weaponType].visible = true;
            ViewManager.instance.createBullet();
        }
    }



    private setFireEnd(): void {
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

    public setBoom(): void {
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

    private setBoomComplete(): void {
        this.sBoom = false;
        if (this.keyJump) return;
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

    public stopMove(): void {
        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        this.keyJump = false;
        this.bodyLeg.url = "ui://Game/legStay";
        this.rigidBody.setVelocity({ x: 0, y: 0 });
        Laya.timer.clear(this, this.stillRun);
    }

    public setStay(): void {
        this.body.url = "ui://Game/player_stay_" + this.weaponType;
        this.stopMove();
        Laya.timer.clear(this, this.stillFire);
    }

    private changeWeaponType(): void {
        if (this.sBoom) return;
        this.weaponType++;
        if (this.weaponType > PlayerData.WEAPON_MAX) {
            this.weaponType = PlayerData.WEAPON_PIS;
        }
        this.body.url = "ui://Game/player_stay_" + this.weaponType;
        if (this.sRun) this.bodyLeg.url = "ui://Game/legMove";
        if (this.keyJump) this.bodyLeg.url = "ui://Game/legJump";
    }

    public beHit(): void {
        Laya.timer.clear(this, this.setColor);
        this.body.color = "#ff0000";
        Laya.timer.once(200, this, this.setColor);
        console.log("player--be--hit");
    }
    private setColor(): void {
        this.body.color = "#ffffff";
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