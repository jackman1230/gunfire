

import { ViewManager } from "../Manager/ViewManager";
import EnemyBody from "./Body/EnemyBody";
import Enemy from "./Enemy";
import { EnemyInfo } from "../Data/PlayerData";
import { BombData } from "../Data/GameData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";
import { ui } from "../ui/layaMaxUI";

export default class Chopper extends Enemy {

    constructor() { super() }

    public createView(d: EnemyInfo) {
        super.initData(d);
        // this.scene = new ui.ChopperBodyUI();
        this.scene = new ui.ChopperBodyUI();
        this.loadComplete();
        // Laya.Scene.load("ChopperBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    public initView(): void {
        super.initView();
        var b: EnemyBody = this.scene.getComponent(EnemyBody);
        b.activeDis = 800;
    }

    protected activeEnemy(s: Laya.Sprite): void {
        //角色距离靠近至500，激活攻击
        if (this.isActive) return;
        if (this.isDeath) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.setRun();
            this.setStillFire();
            Laya.timer.loop(4000, this, this.setStillFire);
            Laya.timer.loop(5000, this, this.setRun);
        }
    }

    public setRun(): void {
        var roleX: number = ViewManager.instance.rolePlayer.roleSprite.x;
        if (this.scene.x > roleX) {//直升机在人物右边
            Laya.Tween.to(this.scene, { x: roleX - this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
        } else {//直升机在人物左边
            Laya.Tween.to(this.scene, { x: roleX + this.getDis(), y: this.scene.y + this.getRandomY() }, 2000);
        }
    }
    private stillFire: number = 0;
    public setStillFire(): void {
        this.setFire();
        Laya.timer.loop(300, this, this.setFire);
    }

    public setFire(): void {
        this.stillFire++;
        var p: Laya.Point = new Laya.Point(this.view.width / 2, this.view.height)
        ViewManager.instance.createChopperBomb(BombData.BOMB_CHOPPER, ViewManager.instance.getBodyCenterPos(this.scene), p);
        SoundManager.instance.playSound("bombDrop");
        if (this.stillFire >= 5) {
            this.stillFire = 0;
            Laya.timer.clear(this, this.setFire);
        }
    }


    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        Laya.Tween.clearAll(this.scene);
        this.enemy.url = "ui://Game/boom_5";
        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        if (this.isBoss) {
            // GameManager.instance.bossDeath = true;
            // EventManager.instance.dispatcherEvt(GameEvent.VICITORY_LEVEL);
            GameManager.instance.victoryGame();
        }
        SoundManager.instance.playSound("boom");
        // this.createGoods();
    }

    protected clearWarView(): void {
        this.dispose();
        Laya.timer.clearAll(this);
    }

    protected recover(): void {
        Laya.Pool.recover("chopper", this);
    }

    private getDis(): number {
        return (Math.random() * 200 + 100);
    }
    private randomY: boolean = false;
    private getRandomY(): number {
        this.randomY = !this.randomY;
        var r: number = Math.random();
        if (this.randomY) {
            return (r * 20 + 30);
        } else {
            return (r * -20 - 30);
        }
    }

}