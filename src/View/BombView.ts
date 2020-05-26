import BulletBody from "./Body/BulletBody";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import WXFUI_Bomb from "../fui/Game/WXFUI_Bomb";
import { BombData } from "../Data/PlayerData";
import BombBody from "./Body/BombBody";
import BoomView from "./BoomView";

export default class BombView {
    public scene: Laya.Sprite;
    public view: WXFUI_Bomb;
    public bomb: fairygui.GLoader;
    public bomb2: fairygui.GLoader;
    public trans: fairygui.Transition;

    public bombType: number = 1;
    public direction: number = 1;
    public isPlayer: boolean = false;

    private body: Laya.RigidBody;
    private box: Laya.BoxCollider;

    private parentPos: Laya.Point;
    private offPos: Laya.Point;

    constructor() { }

    initView(type: number, dir: number, s: Laya.Point, p: boolean, offPos?: Laya.Point): void {
        this.bombType = type;
        this.direction = dir;
        this.parentPos = s;
        this.isPlayer = p;
        this.offPos = offPos;
        Laya.Scene.load("BombBody.scene", Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(s: Laya.Scene): void {
        console.log("bomb.scene--loadComplete", this.bombType);

        this.view = fairygui.UIPackage.createObject("Game", "Bomb") as WXFUI_Bomb;
        this.bomb = this.view.getChildAt(0).asLoader;
        this.bomb2 = this.view.getChildAt(1).asLoader;
        this.bomb.visible = this.bomb2.visible = false;
        if (this.bombType == BombData.BOMB_5) {
            this.bomb.visible = true;
            this.trans = this.view.getTransitionAt(0);
        } else if (this.bombType == BombData.BOMB_2 || this.bombType == BombData.BOMB_1) {
            this.bomb2.visible = true;
            this.trans = this.view.getTransitionAt(1);
        }
        this.scene = s;
        this.scene.addComponent(BombBody);
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        if (this.isPlayer) {
            this.box.label = this.body.label = "PlayerBomb";
        } else {
            this.box.label = this.body.label = "enemyBomb";
        }
        this.bomb2.url = this.bomb.url = "ui://Game/zhadan_" + this.bombType;
        if (this.bombType == BombData.BOMB_2)
            this.bomb2.content.setPlaySettings(0, -1, 0, 0);

        if (this.bombType != BombData.BOMB_4 && this.bombType != BombData.BOMB_5)
            this.trans.play(null, 1);

        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.setBombPos();

        EventManager.instance.addNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
    }

    private setBombPos(): void {
        if (this.direction == 1) {
            this.body.setVelocity({ x: 7, y: -6 });
            if (this.bombType == BombData.BOMB_5)
                this.trans.play(null, 1, 0, 0, 1.25);

        } else {
            this.body.setVelocity({ x: -7, y: -6 });
            if (this.bombType == BombData.BOMB_5)
                this.trans.play(null, 1, 0, 1.5, 2.75);
        }
        this.scene.x = this.parentPos.x + this.offPos.x;
        this.scene.y = this.parentPos.y + this.offPos.y;
    }


    private showBoomView(): void {
        var bomb: BoomView = Laya.Pool.getItemByClass("boomView", BoomView);
        var p: Laya.Point = ViewManager.instance.getBodyCenterPos(this.scene);
        bomb.initView(this.getBoomType(), p, this.isPlayer);
    }

    private getBoomType(): number {
        if (this.bombType == BombData.BOMB_1 || this.bombType == BombData.BOMB_2) {
            return 1;
        } else if (this.bombType == BombData.BOMB_5) {
            return 2;
        } else if (this.bombType == BombData.BOMB_4) {
            return 3;
        }
        return 1;
    }

    private dispose(s: Laya.Sprite): void {
        if (s == this.scene) {
            this.showBoomView();
            EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose)
            Laya.Pool.recover("bombView", this);
            this.view.dispose();
            console.log("销毁炸弹--", this.bombType);
        }
    }

}