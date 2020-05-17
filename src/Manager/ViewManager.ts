
import { WarView } from "../View/WarView";
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import Player from "../View/Player";
import Enemy from "../View/Enemy";
import Bullet from "../View/Bullet";

export class ViewManager {

    private static _instance: ViewManager;


    // private bgView: BackGroundView;
    public warView: WarView;
    private player: Player;
    private enemy: Enemy;

    private bulletArr: Bullet[] = [];
    private enemyArr: Enemy[] = [];

    private isChecking: boolean = false;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public showStartView(): void {
        this.initView();

        // Laya.stage.addChild(this.bgView.view.displayObject);
        Laya.stage.addChild(this.warView.warView.displayObject);
        this.warView.warView.addChild(this.player.rolePlayer);
        this.player.rolePlayer.x = 200;
        this.player.rolePlayer.y = 400;
        // this.player.setStay();
        console.log("开始初始化界面");

        this.warView.warView.addChild(this.enemy.enemy);
        this.enemy.enemy.x = 800;
        this.enemy.enemy.y = 400;
        this.enemy.setFire();
        this.enemyArr.push(this.enemy);
    }

    public createBullet(): Bullet {
        var b: Bullet = new Bullet();
        b.initView();
        b.setBulletData(this.rolePlayer.weaponType, this.rolePlayer.direction);
        var p: Laya.Point = this.rolePlayer.rolePlayer.localToGlobal(this.rolePlayer["firePos" + this.rolePlayer.weaponType].x, this.rolePlayer["firePos" + this.rolePlayer.weaponType].y);
        var y: number = this.bulletRandomY();
        if (this.rolePlayer.direction == 1) {
            b.view.x = Math.abs(this.warView.warView.x) + p.x + b.view.width - 20;
            b.view.y = p.y - this.bulletRandomY();
        } else {
            b.view.x = Math.abs(this.warView.warView.x) + p.x - b.view.width * 2 + 20;
            b.view.y = p.y - this.bulletRandomY();
        }
        this.warView.warView.addChild(b.view);
        this.bulletArr.push(b);
        this.addFrameTimer();
        return b;
    }

    private addFrameTimer(): void {
        if (this.isChecking) return;
        this.isChecking = true;
        Laya.timer.frameLoop(3, this, this.updateBulletPos);
    }

    public checkBulletHit(): void {
        if (this.isChecking) return;

    }

    public initView(): void {
        this.warView = new WarView();
        this.player = new Player();
        this.enemy = new Enemy();

        this.warView.initView();
        this.player.initView();
        this.enemy.initView();
    }

    public get rolePlayer(): Player {
        return this.player;
    }

    public updateBulletPos(): void {
        for (let i = this.bulletArr.length - 1; i >= 0; i--) {
            var b: Bullet = this.bulletArr[i];
            if (b.isEnd) {
                b.view.dispose();
                this.bulletArr.splice(i, 1);
                b = null;
                continue;
            }
            b.updateView();
            for (let j = 0; j < this.enemyArr.length; j++) {
                var e: Enemy = this.enemyArr[j];
                if (b.view.x >= e.enemy.x && b.view.x < e.enemy.x + e.enemy.width && b.view.y >= e.enemy.y && b.view.y <= e.enemy.y + e.enemy.height) {
                    e.beHit();
                    b.view.dispose();
                    this.bulletArr.splice(i, 1);
                    b = null;
                }
            }
        }

        if (this.bulletArr.length < 1 || this.enemyArr.length < 1) {
            Laya.timer.clear(this, this.updateBulletPos);
            this.isChecking = false;
            console.log("clearFrameLoop");

        }
    }


    public updateViewPort(moveX: number): void {
        // this.bgView.updateViewPort(moveX);
        this.warView.updateViewPort(moveX);
    }

    private bulletRandomY(): number {
        return Math.floor(Math.random() * 10) + 10;
    }

}