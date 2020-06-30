import WXFUI_zidan from "../fui/Game/WXFUI_zidan";
import BulletBody from "./Body/BulletBody";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import { GameData } from "../Data/GameData";

export default class EnemyBullet {
    public scene: Laya.Sprite;
    public view: WXFUI_zidan;
    // public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;

    private body: Laya.RigidBody;
    private box: Laya.BoxCollider;

    private parentPos: Laya.Point;

    constructor() { }

    createView(type: number, dir: number, s: Laya.Point): void {
        this.bulletType = type;
        this.direction = dir;
        this.parentPos = s;
        Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(s: Laya.Scene): void {
        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        this.scene = s;
        // console.log("enemyBullet.scene--loadComplete", this.box.id);
        if (this.bulletType == GameData.ENEMY_TANK_1 || this.bulletType == GameData.ENEMY_TANK_2 || this.bulletType == GameData.ENEMY_TANK_3 || this.bulletType == GameData.ENEMY_TANK_4) {
            this.view.m_zidan.url = "ui://Game/zhadan_4";
        } else
            this.view.m_zidan.url = "ui://Game/zidan3";


        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);


        this.setBulletPos();

        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
        EventManager.instance.addNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
        EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);

    }

    private setBulletPos(): void {
        var p: Laya.Point = ViewManager.instance.getEnemyBulletOffSetPos(this.direction, this.bulletType);
        this.scene.x = this.parentPos.x + p.x;
        this.scene.y = this.parentPos.y + p.y;
        this.scene.addComponent(BulletBody);
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.box.label = this.body.label = "enemyBullet";
        if (this.direction == 1) {
            this.view.setSkew(0, 0);
            this.body.setVelocity({ x: 10, y: 0 });
        } else {
            this.view.setSkew(180, 180);
            this.body.setVelocity({ x: -10, y: 0 });
        }
        // console.log("parent--", this.parent.view.x, this.parent.view.y, this.scene.x, this.scene.y);
    }

    private bulletHitPlayer(s: any): void {
        if (s.s == this.box.owner) {
            EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
            EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);

            this.body.setVelocity({ x: 0, y: 0 });
            this.view.m_zidan.url = "ui://Game/bulletDisAni";
            this.view.m_zidan.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.disposeAll));
        }
    }
    public disposeAll(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.ENEMY_BULLET_HIT_PLAYER, this, this.bulletHitPlayer);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);

        this.scene.removeSelf();
        this.view.dispose();
        Laya.Pool.recover("enemyBullet", this);
    }

    private dispose(s: Laya.Sprite): void {
        if (s == this.box.owner) {
            this.disposeAll();
        }
    }
}