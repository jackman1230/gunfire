import { ViewManager } from "../Manager/ViewManager";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";
import { GameData } from "../Data/GameData";
import EnemyBody from "./Body/EnemyBody";
import { ui } from "../ui/layaMaxUI";

export default class Tank extends Enemy {
    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);
        if (this.enemyType == 11) {
            this.scene = new ui.TankBody11UI();
        } else if (this.enemyType == 12) {
            this.scene = new ui.TankBody12UI();
        } else if (this.enemyType == 13) {
            this.scene = new ui.TankBody13UI();
        } else if (this.enemyType == 14) {
            this.scene = new ui.TankBody14UI();
        }
        this.loadComplete();
        // Laya.Scene.load("TankBody" + this.enemyType + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    protected activeEnemy(s: Laya.Sprite): void {
        //角色距离靠近至500，激活攻击
        if (this.isActive) return;
        if (this.isDeath) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.doActive();
            Laya.timer.loop(2000, this, this.doActive);
        }
    }

    private doActive(): void {
        this.setFire();
        this.setRun();
    }

    public initView(): void {
        super.initView();
        var b: EnemyBody = this.scene.getComponent(EnemyBody);
        b.activeDis = 800;
    }

    public setRun(): void {
        var roleDir: number = ViewManager.instance.rolePlayer.direction;
        var roleX: number = ViewManager.instance.rolePlayer.roleSprite.x;
        if (roleX > this.scene.x) {
            this.direction = 1;
            this.setDirection();
        } else {
            this.direction = -1;
            this.setDirection();
        }
        Laya.Tween.to(this.scene, { x: this.scene.x + this.getRandomX() }, 2000);
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
        Laya.Tween.clearAll(this.scene);
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

    protected clearWarView(): void {
        this.dispose();
        Laya.timer.clearAll(this);
    }

    protected recover(): void {
        Laya.Pool.recover("tank", this);
    }

    private randomX: boolean = false;
    private getRandomX(): number {
        this.randomX = !this.randomX;
        var r: number = Math.random();
        if (this.randomX) {
            return (r * 20 + 50);
        } else {
            return (r * -20 - 50);
        }
    }
}