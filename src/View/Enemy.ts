
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import { PlayerData } from "../Data/PlayerData";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";

export default class Enemy {
    //常规兵种
    public scene: Laya.Sprite;
    public view: WXFUI_enemy;
    public enemy: fairygui.GLoader;
    public enemyLoader: fairygui.GLoader;

    public enemyType: number = 5;

    private fire_pos: fairygui.GTextField;
    public enemyCtl: fairygui.Controller


    private direction: number = -1;

    private sRun: boolean = false;//人物是否在跑
    private keyRight: boolean = false;
    private keyLeft: boolean = false;
    private keyJump: boolean = false;

    private speed: number = 10;
    private jumpHigh: number = 200;

    public hp: number = 100;

    constructor() { }

    public initView() {
        Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    public loadComplete(s: Laya.Sprite) {
        this.scene = s;
        this.view = fairygui.UIPackage.createObject("Game", "enemy") as WXFUI_enemy;
        this.view.setPivot(0.5, 0.5);
        this.enemyCtl = this.view.getController("ctl");
        this.enemy = this.view.getChildAt(0) as fairygui.GLoader;

        this.enemy.url = "ui://Game/enemy" + this.enemyType;

        this.scene.addChild(this.enemy.displayObject);
        this.scene.addComponent(EnemyBody);

        this.scene.x = 1000;
        this.scene.y = 400;
        ViewManager.instance.warView.scene.addChild(this.scene);
        EventManager.instance.addNotice(GameEvent.BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.BOMB_HIT_ENEMY, this, this.beHit);

        // this.setLeft();
        this.setRight();
        Laya.timer.loop(2000, this, this.setFire);
    };

    public beHit(): void {
        this.hp -= 30;
        Laya.timer.clear(this, this.setColor);
        this.bodyLoader.color = "#ff0000";
        if (this.hp <= 0) {
            this.setDeath();
        } else {
            Laya.timer.once(200, this, this.setColor);
        }
    }

    private setColor(): void {
        this.bodyLoader.color = "#ffffff";
    }

    public setLeft(): void {
        if (this.direction == -1) return;
        this.direction = -1;
        this.bodyLoader.skewY = 0;
    }

    public setRight(): void {
        if (this.direction == 1) return;
        this.direction = 1;
        this.bodyLoader.skewY = 180;
    }

    public setIdle(): void {
        if (this.enemyType == PlayerData.ENEMY_PIS || this.enemyType == PlayerData.ENEMY_GRE) {
            this.bodyLoader.url = "ui://Game/enemyIdle_1";
        } else if (this.enemyType == PlayerData.ENEMY_MAC) {
            this.bodyLoader.url = "ui://Game/enemyIdle_2";
        } else if (this.enemyType == PlayerData.ENEMY_FIRE) {
            this.bodyLoader.url = "ui://Game/enemyStay_4";
        } else if (this.enemyType == PlayerData.ENEMY_MOR) {
            this.bodyLoader.url = "ui://Game/enemyStay_5";
        } else {
            this.bodyLoader.url = "ui://Game/enemyIdle_1";
        }
        this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
    }

    public setRun(): void {
        if (this.sRun) return;
        this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
        this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
    }

    public stillRun(): void {
        if (this.direction == 1) {
            this.scene.x += this.speed;
            if (this.scene.x >= Laya.Browser.clientWidth / 2) {
                this.scene.x = Laya.Browser.clientWidth / 2;
            }
        } else {
            this.scene.x -= this.speed;
            if (this.scene.x < 1)
                this.scene.x = 1;
        }
    }

    public setFire(): void {
        Laya.timer.once(3000, this, this.setFire);
        if (this.enemyType == PlayerData.ENEMY_PIS || this.enemyType == PlayerData.ENEMY_GRE) {
            if (this.getRandomFire() == 1) {//手枪
                this.bodyLoader.url = "ui://Game/enemy_fire_1";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
            } else {//扔雷
                this.bodyLoader.url = "ui://Game/enemy_fire_2";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
            }
        } else if (this.enemyType == PlayerData.ENEMY_MAC) {//机枪
            this.bodyLoader.url = "ui://Game/enemy_fire_3";
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
        } else if (this.enemyType == PlayerData.ENEMY_FIRE) {//火箭筒
            this.bodyLoader.url = "ui://Game/enemy_fire_4";
        } else if (this.enemyType == PlayerData.ENEMY_MOR) {//迫击炮
            this.bodyLoader.url = "ui://Game/enemy_fire_5";
            this.bodyLoader.component.getChildAt(0).asMovieClip.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
            this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
        } else {
            console.log("没有对应的敌人攻击效果");
        }
    }

    private morComplete(): void {
        ViewManager.instance.createBomb(PlayerData.ENEMY_MOR, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
        this.setIdle();
    }

    private shotComplete(): void {
        ViewManager.instance.createEnemyBullet(PlayerData.ENEMY_PIS, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        this.setIdle();
    }

    private shot2Complete(): void {
        ViewManager.instance.createEnemyBullet(PlayerData.ENEMY_MAC, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        this.setIdle();
    }

    private bombComplete(): void {
        ViewManager.instance.createBomb(PlayerData.ENEMY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
        this.setIdle();
    }

    public setStay(): void {
        this.setIdle();
    }


    private setBoomComplete(): void {
        this.setStay();
        console.log("rengshouliudan");
    }

    public setDeath(): void {
        this.bodyLoader.url = "ui://Game/death_" + this.enemyType;
        this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
    }

    private dispose(): void {
        EventManager.instance.offNotice(GameEvent.BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.BOMB_HIT_ENEMY, this, this.beHit);
        Laya.timer.clearAll(this);
        this.scene.removeSelf();
        this.view.dispose();
        Laya.Pool.recover("enenmy", this);
    }

    public get component(): fairygui.GComponent {
        return this.enemy.component;
    }

    public get bodyLoader(): fairygui.GLoader {
        return this.enemy.component.getChildAt(0).asLoader;
    }

    public getRandomFire(): number {
        if (Math.random() > 0.5) return 1;
        return 2;
    }
}