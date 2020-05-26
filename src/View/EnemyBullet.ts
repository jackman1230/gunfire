import WXFUI_zidan from "../fui/Game/WXFUI_zidan";
import BulletBody from "./Body/BulletBody";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";

export default class EnemyBullet {
    public scene: Laya.Sprite;
    public view: WXFUI_zidan;
    public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;

    private body: Laya.RigidBody;
    private box: Laya.BoxCollider;

    private parentPos: Laya.Point;

    constructor() { }

    initView(type: number, dir: number, s: Laya.Point): void {
        this.bulletType = type;
        this.direction = dir;
        this.parentPos = s;
        Laya.Scene.load("Bullet.scene", Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(s: Laya.Scene): void {
        console.log("enemyBullet.scene--loadComplete");

        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        this.zidan = this.view.getChildAt(0).asLoader;

        this.scene = s;
        this.scene.addComponent(BulletBody);
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.box.label = this.body.label = "enemyBullet";
        this.zidan.url = "ui://Game/zidan1";


        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);


        this.setBulletPos();
        EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
    }

    private setBulletPos(): void {
        var p: Laya.Point = ViewManager.instance.getEnemyBulletOffSetPos(this.direction, this.bulletType);

        if (this.direction == 1) {
            this.view.setSkew(0, 0);
            this.body.setVelocity({ x: 10, y: 0 });
        } else {
            this.view.setSkew(180, 180);
            this.body.setVelocity({ x: -10, y: 0 });
        }
        this.scene.x = this.parentPos.x + p.x;
        this.scene.y = this.parentPos.y + p.y;
        // console.log("parent--", this.parent.view.x, this.parent.view.y, this.scene.x, this.scene.y);
    }


    private dispose(s: Laya.Sprite): void {
        if (s == this.scene) {
            EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
            Laya.Pool.recover("enemyBullet", this);
            this.view.dispose();
            console.log("销毁子弹--enemyBullet");
        }
    }
}