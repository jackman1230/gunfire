
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import { GameData, ShotDirectionData } from "../Data/GameData";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";

export default class Enemy {
    //常规兵种
    public scene: Laya.Sprite;
    public view: fairygui.GComponent;
    public enemy: fairygui.GLoader;
    // public enemyLoader: fairygui.GLoader;

    public enemyType: number = 5;

    protected direction: number = 0;
    protected box: Laya.BoxCollider;

    protected sRun: boolean = false;//人物是否在跑
    protected keyRight: boolean = false;
    protected keyLeft: boolean = false;
    protected keyJump: boolean = false;

    protected speed: number = 10;
    protected jumpHigh: number = 200;
    protected isDeath: boolean = false;

    protected blood: number = 1;
    protected damage: number;
    protected activeDis: number;
    protected pos: Laya.Point;
    protected expRate: number[] = [];
    protected enemyData: EnemyInfo;
    protected isBoss: boolean = false;

    constructor() { }

    public createView(d: EnemyInfo) {
        this.initData(d);
        Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
    };

    protected initData(d: EnemyInfo): void {
        this.enemyData = d;
        this.direction = d.direction;
        this.enemyType = d.type;
        this.blood = d.blood;
        this.damage = d.damage;
        this.activeDis = d.activeDis;
        this.pos = d.pos;
        this.expRate = d.expRate.concat();
        this.isBoss = d.isBoss;
    }

    public loadComplete(s: Laya.Sprite) {
        this.scene = s;
        this.view = fairygui.UIPackage.createObject("Game", "enemy") as fairygui.GComponent;
        this.view.setPivot(0.5, 0.5);
        this.enemy = this.view.getChildAt(0) as fairygui.GLoader;
        this.initView();
    };

    public initView(): void {
        this.enemy.url = "ui://Game/enemy" + this.enemyType;
        this.scene.addChild(this.enemy.displayObject);
        this.scene.addComponent(EnemyBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.isDeath = false;
        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        ViewManager.instance.warView.scene.addChild(this.scene);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);

        this.setDirection();
        Laya.timer.loop(2000, this, this.setFire);
    }

    private pauseGame(): void {
        this.bodyLoader.playing = !GameManager.instance.isPauseGame;
        if (this.enemyType == GameData.ENEMY_MOR) {
            this.bodyLoader.component.getChildAt(0).asLoader.playing = !GameManager.instance.isPauseGame;
            this.bodyLoader.component.getChildAt(1).asMovieClip.playing = !GameManager.instance.isPauseGame;
        }
    }

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood--;
            Laya.timer.clear(this, this.setColor);
            if (this.blood <= 0) {
                this.setDeath();
            } else {
                if (this.enemyType == GameData.ENEMY_MOR) {
                    this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ff0000";
                    this.bodyLoader.component.getChildAt(1).asMovieClip.color = "#ff0000";
                } else
                    this.bodyLoader.color = "#ff0000";
                Laya.timer.once(200, this, this.setColor);
            }
        }
    }

    protected setColor(): void {
        this.bodyLoader.color = "#ffffff";
    }

    public setDirection(): void {
        if (this.direction == ShotDirectionData.LEFT) {
            this.bodyLoader.skewY = 0;
        } else {
            this.bodyLoader.skewY = 180;
        }
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
        if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
            this.bodyLoader.url = "ui://Game/enemyIdle_1";
        } else if (this.enemyType == GameData.ENEMY_MAC) {
            this.bodyLoader.url = "ui://Game/enemyIdle_2";
        } else if (this.enemyType == GameData.ENEMY_FIRE) {
            this.bodyLoader.url = "ui://Game/enemyStay_4";
        } else if (this.enemyType == GameData.ENEMY_MOR) {
            this.bodyLoader.url = "ui://Game/enemyStay_5";
        } else if (this.enemyType == GameData.ENEMY_TANK_1) {
            this.bodyLoader.url = "ui://Game/enemy11";
        } else if (this.enemyType == GameData.ENEMY_TANK_2) {
            this.bodyLoader.url = "ui://Game/enemy12";
        }
        // else if (this.enemyType == GameData.ENEMY_CHOPPER) {
        //     this.bodyLoader.url = "ui://Game/enemy10";
        // } else {
        //     this.bodyLoader.url = "ui://Game/enemyIdle_1";
        // }
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
        // Laya.timer.once(3000, this, this.setFire);
        if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
            if (this.getRandomFire() == 1) {//手枪
                this.bodyLoader.url = "ui://Game/enemy_fire_1";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
            } else {//扔雷
                this.bodyLoader.url = "ui://Game/enemy_fire_2";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
            }
        } else if (this.enemyType == GameData.ENEMY_MAC) {//机枪
            this.bodyLoader.url = "ui://Game/enemy_fire_3";
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
        } else if (this.enemyType == GameData.ENEMY_FIRE) {//火箭筒
            this.bodyLoader.url = "ui://Game/enemy_fire_4";
        } else if (this.enemyType == GameData.ENEMY_MOR) {//迫击炮
            this.bodyLoader.url = "ui://Game/enemy_fire_5";
            this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
            this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
        } else {
            console.log("没有对应的敌人攻击效果");
        }

    }

    protected morComplete(): void {
        ViewManager.instance.createBomb(GameData.ENEMY_MOR, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
        this.setIdle();
    }

    protected shotComplete(): void {
        ViewManager.instance.createEnemyBullet(GameData.ENEMY_PIS, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        this.setIdle();
    }

    protected shot2Complete(): void {
        ViewManager.instance.createEnemyBullet(GameData.ENEMY_MAC, this.direction, ViewManager.instance.getBodyCenterPos(this.scene));
        this.setIdle();
    }

    protected bombComplete(): void {
        ViewManager.instance.createBomb(GameData.ENEMY_GRE, this.direction, ViewManager.instance.getBodyCenterPos(this.scene), false);
        this.setIdle();
    }
    protected tankeComplete(): void {
    }

    public setStay(): void {
        this.setIdle();
    }


    protected setBoomComplete(): void {
        this.setStay();
        console.log("rengshouliudan");
    }

    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clearAll(this);
        // if (this.enemyType == GameData.ENEMY_MOR) {
        this.enemy.url = "ui://Game/death_" + this.getRandomDeath();
        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        // }
        // this.bodyLoader.url = "ui://Game/death_" + this.getRandomDeath();
        // this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        if (this.isBoss) {
            GameManager.instance.bossDeath = true;
        }
        this.createGoods();

    }

    protected createGoods(): void {
        if (this.expRate.length > 0) {
            var p: Laya.Point = new Laya.Point();
            p.x = this.scene.x + this.scene.width / 2;
            p.y = this.scene.y + this.scene.height / 2;
            ViewManager.instance.createGoods(1, p);
        }
    }

    protected dispose(): void {
        EventManager.instance.offNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        Laya.timer.clearAll(this);
        this.scene.removeSelf();
        this.view.dispose();
        this.recover();
    }

    protected recover(): void {
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

    public getRandomDeath(): number {
        var r: number = Math.random();
        if (r > 0.75) return 4;
        if (r > 0.5) return 3;
        if (r > 0.25) return 2;
        return 1;
    }
}