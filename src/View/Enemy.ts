

import { ViewManager } from "../Manager/ViewManager";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import { GameData, ShotDirectionData } from "../Data/GameData";
import { EnemyInfo } from "../Data/PlayerData";
import { GameManager } from "../Manager/GameManager";
import { SoundManager } from "../Manager/SoundManager";
import { ui } from "../ui/layaMaxUI";

export default class Enemy {
    //常规兵种
    public scene: Laya.Sprite;
    public view: fairygui.GComponent;
    public enemy: fairygui.GLoader;
    // public enemyLoader: fairygui.GLoader;
    private enemyScript: EnemyBody;

    public enemyType: number = 5;

    protected direction: number = 0;
    protected box: Laya.BoxCollider;
    protected body: Laya.RigidBody;

    protected sRun: boolean = false;//人物是否在跑
    protected keyRight: boolean = false;
    protected keyLeft: boolean = false;
    protected keyJump: boolean = false;

    protected speed: number = 10;
    protected jumpHigh: number = 200;
    public isDeath: boolean = false;

    protected blood: number = 1;
    protected damage: number;
    protected activeDis: number;
    protected pos: Laya.Point;
    protected expRate: number[] = [];
    protected enemyData: EnemyInfo;
    protected isBoss: boolean = false;
    public isActive: boolean = false;

    public name: string = ""

    constructor() { }

    public createView(d: EnemyInfo) {
        this.initData(d);
        this.scene = new ui.EnemyBodyUI();
        // Laya.Scene.load("EnemyBody.scene", Laya.Handler.create(this, this.loadComplete));
        this.loadComplete();
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
        this.isActive = false;
        this.isDeath = false;
        this.name = d.name;
        Laya.timer.clear(this, this.setFire);
    }

    public loadComplete() {
        // this.scene = s;
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
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.enemyScript = this.scene.getComponent(EnemyBody)
        if (this.enemyType == GameData.ENEMY_JUNGUAN) {
            this.enemyScript.activeDis = 900;
        }

        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
        EventManager.instance.addNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
        EventManager.instance.addNotice(GameEvent.OBSTACLE_BOOM, this, this.obstacleBoom);
        EventManager.instance.addNotice(GameEvent.PLAYER_PAN_HIT_ENEMY, this, this.beHit);




        this.setDirection();
        this.setStay();
        // Laya.timer.loop(2000, this, this.setFire);

        this.showEnemyName();

    }

    protected activeEnemy(s: Laya.Sprite): void {
        //角色距离靠近至500，激活攻击
        if (this.isActive) return;
        if (this.isDeath) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.setFire();
            Laya.timer.loop(3000, this, this.setFire);
        }
    }

    protected pauseGame(): void {
        if (this.isDeath) return;
        this.bodyLoader.playing = !GameManager.instance.isPauseGame;
        if (this.enemyType == GameData.ENEMY_MOR) {
            this.bodyLoader.component.getChildAt(0).asLoader.playing = !GameManager.instance.isPauseGame;
            this.bodyLoader.component.getChildAt(1).asMovieClip.playing = !GameManager.instance.isPauseGame;
        }
    }

    private obstacleBoom(s: Laya.Sprite): void {
        //障碍物爆炸的时候有敌人站在上面，敌人直接死亡
        if (this.enemyScript.obstacleBox && this.enemyScript.obstacleBox.owner && s == this.enemyScript.obstacleBox.owner) {
            this.body.gravityScale = 2;
            this.box.density = 5;
            this.body.setVelocity({ x: 0, y: 1 });
            this.box.refresh();
            this.enemyScript.isDrop = true;
            console.log("obstacleBoom--");

        }
        // this.setDeath();
        // if (s == this.enemyScript.obstacleBox.owner) {
        // }

    }

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood -= s.d;
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
        if (this.enemyType == GameData.ENEMY_MOR) {
            this.bodyLoader.component.getChildAt(0).asLoader.content.color = "#ffffff";
            this.bodyLoader.component.getChildAt(1).asMovieClip.color = "#ffffff";
        } else
            this.bodyLoader.color = "#ffffff";
    }

    public setDirection(): void {
        if (this.direction == ShotDirectionData.LEFT) {
            this.bodyLoader.skewY = 0;
        } else {
            this.bodyLoader.skewY = 180;
        }
    }

    public setIdle(): void {
        if (this.isDeath) return;
        if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
            this.bodyLoader.url = "ui://Game/enemyIdle_1";
        } else if (this.enemyType == GameData.ENEMY_MAC) {
            this.bodyLoader.url = "ui://Game/enemyIdle_2";
        } else if (this.enemyType == GameData.ENEMY_FIRE) {
            this.bodyLoader.url = "ui://Game/enemyStay_4";
        } else if (this.enemyType == GameData.ENEMY_MOR) {
            this.bodyLoader.url = "ui://Game/enemyStay_5";
        } else if (this.enemyType == GameData.ENEMY_JUNGUAN) {
            this.bodyLoader.url = "ui://Game/enemyStay_6";
        } else if (this.enemyType == GameData.ENEMY_TANK_1) {
            this.bodyLoader.url = "ui://Game/enemy11";
        } else if (this.enemyType == GameData.ENEMY_TANK_2) {
            this.bodyLoader.url = "ui://Game/enemy12";
        } else if (this.enemyType == GameData.ENEMY_TANK_3) {
            this.bodyLoader.url = "ui://Game/enemy13";
        } else if (this.enemyType == GameData.ENEMY_TANK_4) {
            this.bodyLoader.url = "ui://Game/enemy14";
        }
        this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
    }

    public setRun(): void {
        if (this.isDeath) return;
        if (this.sRun) return;
        this.bodyLoader.url = "ui://Game/enemy_run_" + this.enemyType;
        // this.bodyLoader.content.setPlaySettings(0, -1, 0, 0);
    }

    public stillRun(): void {
        if (this.isDeath) return;
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
        if (this.isDeath) return;
        if (this.enemyType == GameData.ENEMY_PIS || this.enemyType == GameData.ENEMY_GRE) {
            if (this.getRandomFire() == 1) {//手枪
                SoundManager.instance.playSound("enemy_fire");
                this.bodyLoader.url = "ui://Game/enemy_fire_1";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shotComplete));
            } else {//扔雷
                this.bodyLoader.url = "ui://Game/enemy_fire_2";
                this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.bombComplete));
            }
        } else if (this.enemyType == GameData.ENEMY_MAC) {//机枪
            SoundManager.instance.playSound("enemy_fire");
            this.bodyLoader.url = "ui://Game/enemy_fire_3";
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
        } else if (this.enemyType == GameData.ENEMY_FIRE) {//火箭筒
            SoundManager.instance.playSound("BombDrop");
            this.bodyLoader.url = "ui://Game/enemy_fire_4";
        } else if (this.enemyType == GameData.ENEMY_MOR) {//迫击炮
            SoundManager.instance.playSound("BombDrop");
            this.bodyLoader.url = "ui://Game/enemy_fire_5";
            this.bodyLoader.component.getChildAt(0).asLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.morComplete));
            this.bodyLoader.component.getChildAt(1).asMovieClip.setPlaySettings(0, -1, 1, 0);
        } else if (this.enemyType == GameData.ENEMY_JUNGUAN) {//机枪
            SoundManager.instance.playSound("enemy_fire");
            this.bodyLoader.url = "ui://Game/enemy_fire_6";
            this.bodyLoader.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.shot2Complete));
        } else {
            console.log("没有对应的敌人攻击效果");
        }

    }

    public setDeath(): void {
        if (this.isDeath) return;
        this.isDeath = true;
        Laya.timer.clear(this, this.setFire);
        var s: number = this.getRandomDeath();
        SoundManager.instance.playSound("die_" + s);
        if (this.enemyType == GameData.ENEMY_JUNGUAN) {
            this.enemy.url = "ui://Game/death_" + this.enemyType;
        } else
            this.enemy.url = "ui://Game/death_" + s;

        this.enemy.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        Laya.timer.once(500, this, this.dispose);
        this.createGoods();
        if (this.isBoss) {
            GameManager.instance.victoryGame();
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
    }



    protected createGoods(): void {
        if (this.expRate.length > 0) {
            var r: number = Math.random();
            var rate: number = 0;
            var type: number = 0;
            for (let i = 0; i < this.expRate.length; i += 2) {
                rate += this.expRate[i + 1];
                if (rate >= r) {
                    type = this.expRate[i];
                    if (type > 0) {
                        var p: Laya.Point = new Laya.Point();
                        p.x = this.scene.x + this.scene.width / 2;
                        p.y = this.scene.y + this.scene.height / 2;
                        ViewManager.instance.createGoods(type, p);
                    }
                    break;
                }
            }
        }
    }

    protected clearWarView(): void {
        this.dispose();
    }

    public dispose(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearWarView);
        EventManager.instance.offNotice(GameEvent.ACTIVE_ENEMY, this, this.activeEnemy);
        EventManager.instance.offNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);
        // EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.OBSTACLE_BOOM, this, this.obstacleBoom);
        EventManager.instance.offNotice(GameEvent.PLAYER_PAN_HIT_ENEMY, this, this.beHit);

        Laya.timer.clearAll(this);
        if (this.scene)
            this.scene.removeSelf();
        if (this.view)
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

    private showEnemyName(): void {
        if (!GameData.SHOW_ENEMY_NAME) return;
        var txt: Laya.Text = new Laya.Text();
        txt.width = 50;
        txt.height = 30;
        txt.fontSize = 20;
        txt.color = "#ffff00";
        txt.text = this.name;
        this.enemy.displayObject.addChild(txt);
    }
}