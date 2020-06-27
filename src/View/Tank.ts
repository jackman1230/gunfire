import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";

export default class Tank extends Enemy {
    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);

        Laya.Scene.load("TankBody" + this.enemyType + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    protected activeEnemy(s: Laya.Sprite): void {
        //角色距离靠近至500，激活攻击
        if (this.isActive) return;
        if (this.isDeath) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.setFire();
            Laya.timer.loop(2000, this, this.setFire);
        }
    }

    // public setRun(): void {
    //     if (this.sRun) return;
    //     this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
    //     this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
    // }

    // public stillRun(): void {
    //     if (this.direction == 1) {
    //         this.scene.x += this.speed;
    //         if (this.scene.x >= Laya.Browser.clientWidth / 2) {
    //             this.scene.x = Laya.Browser.clientWidth / 2;
    //         }
    //     } else {
    //         this.scene.x -= this.speed;
    //         if (this.scene.x < 1)
    //             this.scene.x = 1;
    //     }
    // }

    public setFire(): void {
        this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
        this.bodyLoader.component.getChildAt(0).asMovieClip.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankShotComplete));
        ViewManager.instance.createEnemyBullet(this.enemyType, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));

    }

    protected tankShotComplete(): void {
        this.setIdle();
    }

    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        this.enemy.url = "ui://Game/boom_5";
        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        if (this.isBoss) {
            GameManager.instance.bossDeath = true;
        }
        SoundManager.instance.playSound("boom");
        // this.createGoods();
    }

    protected recover(): void {
        Laya.Pool.recover("tank", this);
    }
}