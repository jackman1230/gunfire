
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import { PlayerData } from "../Data/PlayerData";
import EnemyAni from "./EnemyAni";

export default class Enemy {

    public enemy: WXFUI_enemy;
    public enemyAni: EnemyAni;

    public enemyType: number = 1;

    private enemy_stay: fairygui.GLoader;
    private enemy_fire: fairygui.GLoader;
    private fire_pos: fairygui.GTextField;
    public enemyCtl: fairygui.Controller


    private direction: number = 0;

    private sRun: boolean = false;//人物是否在跑
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;

    private speed: number = 10;
    private jumpHigh: number = 200;

    constructor() { }

    public initView() {
        this.enemy = fairygui.UIPackage.createObject("Game", "enemy") as WXFUI_enemy;
        this.enemy.setPivot(0.5, 0.5);

        // this.enemy_stay = this.enemy.getChildAt(0) as fairygui.GLoader;
        // this.enemy_fire = this.enemy.getChildAt(1) as fairygui.GLoader;
        this.fire_pos = this.enemy.getChildAt(2) as fairygui.GTextField;
        this.enemyCtl = this.enemy.getController("ctl");

        this.enemyAni = new EnemyAni();
        this.enemyAni.initView(this.enemyType);

        // this.enemy_stay.url = "";
        // this.enemy_fire.url = "";
        // this.enemy_stay.displayObject.removeChildren();
        // this.enemy.removeChildren();
        // this.enemy.displayObject.addChild(this.playerAni.legStay.displayObject);
        // this.enemy.displayObject.addChild(this.playerAni.body_1.displayObject);


    };


    public setLeft(): void {
        if (this.direction == -1) return;
        this.direction = -1;
        this.enemy.skewY = 0;
    }

    public setRight(): void {
        if (this.direction == 1) return;
        this.direction = 1;
        this.enemy.skewY = 180;
    }

    // public setJump(): void {
    //     this.keyJump = true;
    //     this.leg.displayObject.removeChildren();
    //     this.leg.displayObject.addChild(this.playerAni.legJump.displayObject);
    //     // this.playerAni.legJump.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.jumpEnd));
    //     this.playerAni.legJump.setPlaySettings(1, -1, 1, 5);
    //     Laya.Tween.to(this.enemy, { y: this.enemy.y - this.jumpHigh }, 400, null, Laya.Handler.create(this, this.jumpEnd));
    //     // this.leg.url = "ui://Game/legJump";
    // }

    private runTime: number = 0;
    public setRun(): void {
        if (this.sRun) return;
        this.enemy.addChild(this.enemyAni.runAni);
        // this.enemyAni.runAni.playing
        // this.leg.displayObject.removeChildren();
        // this.leg.displayObject.addChild(this.playerAni.legMove.displayObject);

        // this.sRun = true;
        // Laya.timer.clear(this, this.stillRun);
        // Laya.timer.loop(50, this, this.stillRun);
    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.enemy.x += this.speed;
            if (this.enemy.x >= Laya.Browser.clientWidth / 2) {
                this.enemy.x = Laya.Browser.clientWidth / 2;
                this.runTime++;
                ViewManager.instance.updateViewPort(this.runTime * this.speed);
            }
        } else {
            this.enemy.x -= this.speed;
            if (this.enemy.x < 1)
                this.enemy.x = 1;
        }
        console.log("人物X坐标---", this.enemy.x);
    }

    public setFire(): void {
        Laya.timer.loop(2000, this, this.setFire);
        this.enemy.addChild(this.enemyAni.fireAni);
        
        this.enemyAni.fireAni.setPlaySettings(1, -1, 1, 1)
        // this.leg.displayObject.removeChildren();
    }

    public setBoom(): void {
        // this.body.displayObject.removeChildren();
        // this.body.asMovieClip.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.setBoomComplete));
    }

    public setStay(): void {
        // this.enemy.removeChildren();
        this.enemy.addChild(this.enemyAni.stay);

        // this.keyLeft = false;
        // this.keyRight = false;
        // this.sRun = false;
        // // this.runTime = 0;
        // Laya.timer.clear(this, this.stillRun);
    }


    private setBoomComplete(): void {
        this.setStay();
        console.log("rengshouliudan");
    }

    public setDeath(): void {
        // this.enemy.removeChildren();
        this.enemy.addChild(this.enemyAni.deathAni);
    }

}