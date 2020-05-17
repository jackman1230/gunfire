
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import { PlayerData } from "../Data/PlayerData";
import EnemyAni from "./EnemyAni";

export default class Enemy {

    public view: WXFUI_enemy;
    public enemyAni: EnemyAni;
    public enemy: fairygui.GLoader;

    public enemyType: number = 1;

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
        this.view = fairygui.UIPackage.createObject("Game", "enemy") as WXFUI_enemy;
        this.view.setPivot(0.5, 0.5);

        // this.fire_pos = this.view.getChildAt(1) as fairygui.GTextField;
        this.enemyCtl = this.view.getController("ctl");
        this.enemy = this.view.getChildAt(0) as fairygui.GLoader;

        this.enemyAni = new EnemyAni();
        this.enemyAni.initView(this.enemyType);

        this.enemy.url = "ui://Game/enemy" + this.enemyType;

    };

    public beHit(): void {
        Laya.timer.clear(this, this.setColor);
        this.enemy.color = "#ff0000";
        Laya.timer.once(200, this, this.setColor);
        console.log("enemy--be--hit");
    }

    private setColor(): void {
        this.enemy.color = "#ffffff";
    }


    public setLeft(): void {
        if (this.direction == -1) return;
        this.direction = -1;
        this.view.skewY = 0;
    }

    public setRight(): void {
        if (this.direction == 1) return;
        this.direction = 1;
        this.view.skewY = 180;
    }

    public setIdle(): void {
        if (this.enemyType < 5) {

        }
    }

    public setRun(): void {
        if (this.sRun) return;
        this.enemy.url = this.enemyAni.runAniUrl;
    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.view.x += this.speed;
            if (this.view.x >= Laya.Browser.clientWidth / 2) {
                this.view.x = Laya.Browser.clientWidth / 2;
            }
        } else {
            this.view.x -= this.speed;
            if (this.view.x < 1)
                this.view.x = 1;
        }
    }

    public setFire(): void {
        Laya.timer.loop(2000, this, this.setFire);
        // this.enemy.addChild(this.enemyAni.fireAni);
        this.enemy.url = this.enemyAni.fireAniUrl;

        // this.enemyAni.fireAni.setPlaySettings(1, -1, 1, 1)
    }

    public setBoom(): void {
        // this.body.displayObject.removeChildren();
        // this.body.asMovieClip.setPlaySettings(1, -1, 1, 1, Laya.Handler.create(this, this.setBoomComplete));
    }

    public setStay(): void {
        // this.enemy.removeChildren();
        // this.enemy.addChild(this.enemyAni.stay);
        this.enemy.url = this.enemyAni.stayAniUrl;

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
        // this.enemy.addChild(this.enemyAni.deathAni);
        this.enemy.url = this.enemyAni.deathAniUrl;
    }

    public getBody(): fairygui.GComponent {
        return this.enemy.component;
    }

    public getBodyLoader(): fairygui.GLoader {
        return this.enemy.component.getChildAt(0).asLoader;
    }

}