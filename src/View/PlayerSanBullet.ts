import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import BulletBody from "./Body/BulletBody";
import { GameData } from "../Data/GameData";
import { ui } from "../ui/layaMaxUI";
import WXFUI_sandan from "../fui/Game/WXFUI_sandan";

export default class PlayerSanBullet {
    public scene: Laya.Sprite;
    public view: WXFUI_sandan;
    // public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;
    public bulletIndex: number = 0;

    private body: Laya.RigidBody;
    private box: Laya.BoxCollider;

    constructor() { }

    createView(type: number, dir: number, index: number): void {
        this.bulletType = type;
        this.direction = dir;
        this.bulletIndex = index;
        this.view = fairygui.UIPackage.createObject("Game", "sandan") as WXFUI_sandan;
        this.view.m_zidan.url = "ui://Game/playerzidan" + this.bulletType;
        this.scene = new ui.BulletSanUI();
        this.loadComplete();
    }

    private loadComplete(): void {
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.scene.addComponent(BulletBody);
        // console.log("BulletBody---");

        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.box.label = this.body.label = "PlayerBullet" + this.bulletType;
        this.setBulletPos();

        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
    }

    private hitEnemy(s: any): void {
        if (s.s == this.box.owner) {
            this.body.setVelocity({ x: 0, y: 0 });
            this.view.m_zidan.url = "ui://Game/bulletDisAni";
            this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
        }
    }

    public disposeAll(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.disposeBullet);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        if (this.scene) {
            this.scene.removeSelf();
        }
        this.view.dispose();
        Laya.Pool.recover("PlayerSanBullet", this);
    }
    private disposeBullet(s: Laya.Sprite): void {
        if (s == this.body.owner) {
            this.disposeAll();
        }
    }

    private setBulletPos(): void {
        var p: Laya.Point = this.getBulletOffSetPos(this.direction);
        var c: Laya.Point = ViewManager.instance.rolePlayer.roleBody.getWorldCenter();
        this.scene.addChild(this.view.displayObject);
        var b: BulletBody = this.scene.getComponent(BulletBody);
        b.onAwake();
        this.scene.x = c.x + p.x;
        this.scene.y = c.y + p.y;
        console.log("onAwake---");
        if (this.direction > 0) {
            if (this.direction == 4) {//向上
                if (this.bulletIndex == 0) {//left
                    this.body.setVelocity({ x: -2, y: -10 });
                } else if (this.bulletIndex == 1) {//up
                    this.body.setVelocity({ x: 0, y: -10 });
                } else if (this.bulletIndex == 2) {//right
                    this.body.setVelocity({ x: 2, y: -10 });
                }
            } else if (this.direction == 3) {//右斜上
                if (this.bulletIndex == 0) {//up
                    this.body.setVelocity({ x: 11, y: -11 });
                } else if (this.bulletIndex == 1) {//forward
                    this.body.setVelocity({ x: 11, y: -9 });
                } else if (this.bulletIndex == 2) {//down
                    this.body.setVelocity({ x: 11, y: -7 });
                }
            } else {//向前
                if (this.bulletIndex == 0) {//up
                    this.body.setVelocity({ x: 12, y: -2 });
                } else if (this.bulletIndex == 1) {//forward
                    this.body.setVelocity({ x: 12, y: 0 });
                } else if (this.bulletIndex == 2) {//down
                    this.body.setVelocity({ x: 12, y: 2 });
                }
            }
        } else {
            if (this.direction == -4) {//向上
                if (this.bulletIndex == 0) {//left
                    this.body.setVelocity({ x: -2, y: -10 });
                } else if (this.bulletIndex == 1) {//up
                    this.body.setVelocity({ x: 0, y: -10 });
                } else if (this.bulletIndex == 2) {//right
                    this.body.setVelocity({ x: 2, y: -10 });
                }
            } else if (this.direction == -3) {//左斜上
                if (this.bulletIndex == 0) {//up
                    this.body.setVelocity({ x: -11, y: -11 });
                } else if (this.bulletIndex == 1) {//forward
                    this.body.setVelocity({ x: -11, y: -9 });
                } else if (this.bulletIndex == 2) {//down
                    this.body.setVelocity({ x: -11, y: -7 });
                }
            } else {//向前
                if (this.bulletIndex == 0) {//up
                    this.body.setVelocity({ x: -12, y: -2 });
                } else if (this.bulletIndex == 1) {//forward
                    this.body.setVelocity({ x: -12, y: 0 });
                } else if (this.bulletIndex == 2) {//down
                    this.body.setVelocity({ x: -12, y: 2 });
                }
            }
        }
    }

    private getBulletOffSetPos(d: number): Laya.Point {
        var p: Laya.Point = new Laya.Point();
        if (d == 1) {//右
            p.x = 75; p.y = -20;
        } else if (d == -1) {//左
            p.x = -100; p.y = -20;
        } else if (d == 4) {//右正上
            p.x = -20; p.y = -120;
        } else if (d == -4) {//左正上
            p.x = 0; p.y = -120;
        } else if (d == 3) {//右斜上
            p.x = 50; p.y = -100;
        } else if (d == -3) {//左斜上
            p.x = -65; p.y = -100;
        } else if (d == 5) {//右蹲下
            p.x = 75; p.y = -3;
        } else if (d == -5) {//左蹲下
            p.x = -105; p.y = -3;
        }
        return p;
    }
}