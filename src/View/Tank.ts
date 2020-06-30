import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";
import { GameData } from "../Data/GameData";

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

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood -= s.d;
            Laya.timer.clear(this, this.setColor);
            if (this.blood <= 0) {
                this.setDeath();
            } else {
                this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                Laya.timer.once(200, this, this.setColor);
            }
        }
    }

    protected setColor(): void {
        this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ffffff";
    }

    public setFire(): void {
        this.bodyLoader.url = "ui://Game/enemy_fire_" + this.enemyType;
        if (this.enemyType == GameData.ENEMY_TANK_1 || this.enemyType == GameData.ENEMY_TANK_2) {
            this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.tankShotComplete));
        }
        SoundManager.instance.playSound("tank_fire");
        ViewManager.instance.createEnemyBullet(this.enemyType, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));

    }

    protected tankShotComplete(): void {
        this.setIdle();
    }

    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        this.bodyLoader.url = "";
        var ani: fairygui.GMovieClip = fairygui.UIPackage.createObject("Game", "boom_5").asMovieClip;
        ani.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        ani.x = 20;
        ani.y = -100;
        this.bodyLoader.displayObject.addChild(ani.displayObject);
        if (this.isBoss) {
            GameManager.instance.bossDeath = true;
        }
        SoundManager.instance.playSound("boom");
        // this.createGoods();
    }

    private getDeathBoomPos(): void {

    }

    protected recover(): void {
        Laya.Pool.recover("tank", this);
    }
}