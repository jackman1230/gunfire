import WXFUI_zidan from "../fui/Game/WXFUI_zidan";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import BulletBody from "./Body/BulletBody";

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

        Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(s: Laya.Scene): void {
        console.log("PlayerBullet.scene--loadComplete");

        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        // this.zidan = this.view.getChildAt(0).asLoader;

        this.scene = s;
        this.scene.addComponent(BulletBody);
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.box.label = this.body.label = "PlayerBullet";
        this.view.m_zidan.url = "ui://Game/zidan" + this.bulletType;

        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.setBulletPos();

        // EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
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

    private disposeAll(): void {
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.hitEnemy);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.hitEnemy);
        Laya.Pool.recover("PlayerBullet", this);
        this.view.dispose();
        this.scene.removeSelf();
        // this.scene = null;
        // this.view = null;
        console.log("销毁子弹--PlayerBullet");
    }

    private setBulletPos(): void {
        var p: Laya.Point = ViewManager.instance.getPlayerBulletOffSetPos(this.direction, this.bulletType);
        var y: number = ViewManager.instance.bulletRandomY();
        var c: Laya.Point = (ViewManager.instance.rolePlayer.roleSprite.getComponent(Laya.RigidBody) as Laya.RigidBody).getWorldCenter();
        if (this.direction == 1) {
            this.view.setSkew(0, 0);
            this.scene.x = c.x + p.x;
            this.body.setVelocity({ x: 10, y: 0 });
        } else {
            this.view.setSkew(180, 180);
            this.scene.x = c.x + p.x;
            this.body.setVelocity({ x: -10, y: 0 });
        }
        this.scene.y = c.y - y + p.y;

    }

}