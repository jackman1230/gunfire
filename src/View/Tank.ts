import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";

export default class Tank extends Enemy {
    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);

        Laya.Scene.load("TankBody" + this.enemyType + ".scene", Laya.Handler.create(this, this.loadComplete));
    };


    // public initView(): void {
    //     this.enemy.url = "ui://Game/enemy" + this.enemyType;
    //     this.scene.addChild(this.enemy.displayObject);
    //     this.scene.addComponent(EnemyBody);
    //     this.box = this.scene.getComponent(Laya.BoxCollider);

    //     this.isDeath = false;

    //     this.scene.x = this.pos.x;
    //     this.scene.y = this.pos.y;
    //     ViewManager.instance.warView.scene.addChild(this.scene);
    //     EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
    //     EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);

    //     this.setDirection();
    //     // Laya.timer.loop(2000, this, this.setFire);
    // }




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
        this.createGoods();
    }

    protected recover(): void {
        Laya.Pool.recover("tank", this);
    }
}