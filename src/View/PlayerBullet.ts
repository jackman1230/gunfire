import WXFUI_zidan from "../fui/Game/WXFUI_zidan";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import BulletBody from "./Body/BulletBody";
import { GameData } from "../Data/GameData";
import { ui } from "../ui/layaMaxUI";

export default class PlayerBullet {
    public scene: Laya.Sprite;
    public view: WXFUI_zidan;
    // public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;

    private speed: number = 35;
    private body: Laya.RigidBody;
    private box: Laya.BoxCollider;

    constructor() { }

    createView(type: number, dir: number): void {
        this.bulletType = type;
        this.direction = dir;
        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        this.view.m_zidan.url = "ui://Game/playerzidan" + this.bulletType;
        if (this.bulletType == GameData.WEAPON_RIFLE) {
            // Laya.Scene.load("BulletRifle.scene", Laya.Handler.create(this, this.loadComplete));
            if (this.direction == 4 || this.direction == -4) {
                this.scene = new ui.BulletRifleUpUI();
            } else
                this.scene = new ui.BulletRifleUI();
            // this.scene = Laya.Pool.getItemByClass("BulletRifleUI", ui.BulletRifleUI);
        } else {
            // this.scene = Laya.Pool.getItemByClass("BulletUI", ui.BulletUI);
            if (this.direction == 4 || this.direction == -4) {
                this.scene = new ui.BulletUpUI();
            } else
                this.scene = new ui.BulletUI();
            // Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
        }
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
        if (this.bulletType == GameData.WEAPON_RIFLE) return;
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
            // if (this.bulletType == GameData.WEAPON_RIFLE) {
            //     Laya.Pool.recover("BulletRifleUI", this.scene);
            // } else {
            //     Laya.Pool.recover("BulletUI", this.scene);
            // }
        }
        this.view.dispose();
        Laya.Pool.recover("PlayerBullet", this);
    }
    private disposeBullet(s: Laya.Sprite): void {
        if (s == this.body.owner) {
            this.disposeAll();
        }
    }

    private setBulletPos(): void {
        var p: Laya.Point = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
        var c: Laya.Point = ViewManager.instance.rolePlayer.roleBody.getWorldCenter();
        if (this.bulletType == GameData.WEAPON_RIFLE) {
            this.view.x = p.x;
            this.view.y = p.y;
            this.scene.addChild(this.view.displayObject);
            var b: BulletBody = this.scene.getComponent(BulletBody);
            b.onAwake();
            console.log("onAwake---");
            if (this.direction > 0) {
                this.scene.x = c.x + 45;
                if (this.direction == 2) {//右下
                    this.scene.y = c.y;
                    this.view.setSkew(15, 15);
                } else if (this.direction == 3) {//右上
                    this.scene.y = c.y - this.scene.height;
                    this.view.setSkew(-15, -15);
                } else if (this.direction == 4) {//上
                    this.scene.y = c.y - this.scene.height;
                    this.scene.x = c.x - this.scene.width / 2;
                    this.view.setSkew(-90, -90);
                } else {
                    this.scene.y = c.y - this.scene.height / 2;
                    this.view.setSkew(0, 0);//右
                }
            } else {
                this.scene.x = c.x - this.scene.width - 45;
                if (this.direction == -2) {//左下
                    this.scene.y = c.y;
                    this.view.setSkew(165, 165);
                } else if (this.direction == -3) {//左上
                    this.scene.y = c.y - this.scene.height;
                    this.view.setSkew(195, 195);
                } else if (this.direction == -4) {//上
                    this.scene.y = c.y - this.scene.height;
                    this.scene.x = c.x - this.scene.width / 2;
                    this.view.setSkew(270, 270);
                } else {
                    this.scene.y = c.y - this.scene.height / 2;
                    this.view.setSkew(180, 180);//左
                }
            }
            this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
        } else {
            if (this.direction == 1 || this.direction == -1) {
                var y: number = ViewManager.instance.bulletRandomY();
                this.scene.x = c.x + p.x;
                this.scene.y = c.y - y + p.y;
            } else {
                this.scene.x = c.x + p.x;
                this.scene.y = c.y + p.y;
            }
            // console.log("scene--", this.scene.x, this.scene.y);

            this.scene.addChild(this.view.displayObject);
            var b: BulletBody = this.scene.getComponent(BulletBody);
            b.onAwake();
            if (this.direction > 0) {
                if (this.direction == 2) {//右下
                    this.view.setSkew(25, 25);
                    this.body.setVelocity({ x: 11, y: 8 });
                } else if (this.direction == 3) {//右上
                    this.view.setSkew(-25, -25);
                    this.body.setVelocity({ x: 11, y: -8 });
                } else if (this.direction == 4) {//上
                    // this.scene.y = c.y - this.scene.height;
                    this.view.setSkew(-90, -90);
                    this.body.setVelocity({ x: 0, y: -10 });
                } else {
                    this.view.setSkew(0, 0);//右
                    this.body.setVelocity({ x: 12, y: 0 });
                }
            } else {
                if (this.direction == -2) {//左下
                    this.view.setSkew(155, 155);
                    this.body.setVelocity({ x: -11, y: 8 });
                } else if (this.direction == -3) {//左上
                    this.view.setSkew(205, 205);
                    this.body.setVelocity({ x: -11, y: -8 });
                } else if (this.direction == -4) {//上
                    // this.scene.y = c.y - this.scene.height;
                    this.view.setSkew(270, 270);
                    this.body.setVelocity({ x: 0, y: -10 });
                } else {
                    this.view.setSkew(180, 180);//左
                    this.body.setVelocity({ x: -12, y: 0 });
                }
            }
        }
    }

}