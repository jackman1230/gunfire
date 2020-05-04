
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";

export default class Player {

    public rolePlayer: WXFUI_Player;

    private playerAni: PlayerAni;

    private leg: fairygui.GLoader;
    private body: fairygui.GLoader;

    private direction: number = 0;

    private sRun: boolean = false;//人物是否在跑
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;

    private speed: number = 10;
    private jumpHigh: number = 150;

    constructor() { }

    public initView() {
        this.rolePlayer = fairygui.UIPackage.createObject("Game", "Player") as WXFUI_Player;
        this.rolePlayer.setPivot(0.5, 0.5);

        this.leg = this.rolePlayer.getChildAt(0) as fairygui.GLoader;
        this.body = this.rolePlayer.getChildAt(1) as fairygui.GLoader;

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

    };

    private keyUpEvent(e: any): void {
        var keyCode: number = e["keyCode"];
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
        this.keyJump = true;
        this.leg.displayObject.removeChildren();
        this.leg.displayObject.addChild(this.playerAni.legJump.displayObject);
        // this.playerAni.legJump.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.jumpEnd));
        this.playerAni.legJump.setPlaySettings(1, -1, 1, 5);
        Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y - this.jumpHigh }, 400, null, Laya.Handler.create(this, this.jumpEnd));
        // this.leg.url = "ui://Game/legJump";
    }

    public setRun(): void {
        if (this.sRun) return;
        this.leg.displayObject.removeChildren();
        this.leg.displayObject.addChild(this.playerAni.legMove.displayObject);

        this.sRun = true;
        Laya.timer.clear(this, this.stillRun);
        Laya.timer.loop(50, this, this.stillRun);
    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.rolePlayer.x += this.speed;
        } else {
            this.rolePlayer.x -= this.speed;
            if (this.rolePlayer.x < 1)
                this.rolePlayer.x = 1;
        }
        console.log("人物X坐标---", this.rolePlayer.x);

    }

    public setFire(): void {
        this.leg.displayObject.removeChildren();
        // this.body.url = "ui://Game/fire_2";
    }

    public setBoom(): void {
        this.body.displayObject.removeChildren();
        this.body.asMovieClip.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.setBoomComplete));
    }

    public setStay(): void {
        this.leg.displayObject.removeChildren();
        this.leg.displayObject.addChild(this.playerAni.legStay.displayObject);
        this.playerAni.legStay.x = 5;
        this.playerAni.legStay.y = 10;

        this.keyLeft = false;
        this.keyRight = false;
        this.sRun = false;
        Laya.timer.clear(this, this.stillRun);
    }

    private jumpEnd(): void {
        this.keyJump = false;
        // Laya.Tween.to(this.rolePlayer, { y: this.rolePlayer.y + this.jumpHigh }, 400, null, () => {

        // });
        this.leg.displayObject.removeChildren();
        if (this.sRun) {
            this.leg.displayObject.addChild(this.playerAni.legMove.displayObject);
            return;
        }

        this.setStay();
    }

    private setBoomComplete(): void {
        this.setStay();
        console.log("rengshouliudan");

    }

}