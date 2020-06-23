import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import Enemy from "./Enemy";
import WXFUI_BoomView from "../fui/Game/WXFUI_BoomView";
import BoomBody from "./Body/BoomBody";

export default class BoomView {
    public scene: Laya.Sprite;
    public view: WXFUI_BoomView;
    // public boom: fairygui.GLoader;

    public boomType: number = 1;
    public direction: number = 1;

    private speed: number = 35;
    private body: Laya.RigidBody;
    private box: Laya.CircleCollider;

    private _parent: Laya.Sprite;
    private isPlayer: boolean;
    private pos: Laya.Point;
    constructor() { }

    createView(type: number, s: Laya.Point, b: boolean): void {
        this.boomType = type;
        this.isPlayer = b;
        this.pos = s;
        Laya.Scene.load("BoomBody.scene", Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(s: Laya.Scene): void {
        // console.log("boomBody.scene--loadComplete");

        this.view = fairygui.UIPackage.createObject("Game", "BoomView") as WXFUI_BoomView;
        // this.boom = this.view.getChildAt(0).asLoader;

        this.scene = s;
        this.scene.addComponent(BoomBody);
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.CircleCollider);
        if (this.isPlayer) {
            this.box.label = this.body.label = "PlayerBoom";
        } else {
            this.box.label = this.body.label = "enemyBoom";
        }

        this.scene.addChild(this.view.displayObject);

        ViewManager.instance.warView.scene.addChild(this.scene);
        // this.parent.scene.addChild(this.scene);

        this.view.m_boom.url = "ui://Game/boom_" + this.boomType;
        this.view.m_boom.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.showComplete));

        this.setBoomViewPos();


        // EventManager.instance.addNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
    }

    private setBoomViewPos(): void {
        this.scene.x = this.pos.x - this.scene.width / 2;
        this.scene.y = this.pos.y - this.scene.height / 2;
        // this.scene.x = p.x;
        // this.scene.y = p.y;
    }

    private showComplete(): void {
        this.calDamage();
        this.dispose();
    }

    private calDamage(): void {

    }

    private dispose(): void {
        // if (s == this.scene) {
        // EventManager.instance.offNotice(GameEvent.BULLET_DISPOSE, this, this.dispose);
        Laya.Pool.recover("boomView", this);
        this.view.dispose();
        this.scene.removeSelf();
        // console.log("销毁子弹--enemyBullet");
        // }
    }
}