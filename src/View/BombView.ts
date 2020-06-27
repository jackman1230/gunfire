import BulletBody from "./Body/BulletBody";
import { ViewManager } from "../Manager/ViewManager";
import GameEvent from "../Control/GameEvent";
import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import WXFUI_Bomb from "../fui/Game/WXFUI_Bomb";
import { BombData } from "../Data/GameData";
import BombBody from "./Body/BombBody";
import BoomView from "./BoomView";
import { SoundManager } from "../Manager/SoundManager";

export default class BombView {
    public scene: Laya.Sprite;
    public view: WXFUI_Bomb;
    public trans: fairygui.Transition;

    public bombType: number = 1;
    public direction: number = 1;
    public isPlayer: boolean = false;

    protected body: Laya.RigidBody;
    protected box: Laya.BoxCollider;

    protected parentPos: Laya.Point;
    protected offPos: Laya.Point;

    constructor() { }

    createView(type: number, dir?: number, s?: Laya.Point, p?: boolean, offPos?: Laya.Point): void {
        this.bombType = type;
        this.direction = dir;
        this.parentPos = s;
        this.isPlayer = p;
        this.offPos = offPos;
        Laya.Scene.load("BombBody.scene", Laya.Handler.create(this, this.loadComplete));
    }

    protected loadComplete(s: Laya.Scene): void {
        // console.log("bomb.scene--loadComplete", this.bombType);

        this.view = fairygui.UIPackage.createObject("Game", "Bomb") as WXFUI_Bomb;
        this.view.m_boom.visible = this.view.m_boom2.visible = false;
        if (this.bombType == BombData.BOMB_MOR) {
            this.view.m_boom.visible = true;
            this.trans = this.view.getTransitionAt(0);
        } else if (this.bombType == BombData.BOMB_ENEMY_GRE || this.bombType == BombData.BOMB_MY_GRE) {
            this.view.m_boom2.visible = true;
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
        this.view.m_boom.url = this.view.m_boom2.url = "ui://Game/zhadan_" + this.bombType;
        if (this.bombType == BombData.BOMB_ENEMY_GRE)
            this.view.m_boom2.content.setPlaySettings(0, -1, 0, 0);

        if (this.bombType == BombData.BOMB_MY_GRE || this.bombType == BombData.BOMB_ENEMY_GRE)
            this.trans.play(null, 1);

        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.setBombPos();

        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
        EventManager.instance.addNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
        EventManager.instance.addNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
    }

    protected setBombPos(): void {
        if (this.direction == 1) {
            this.body.setVelocity({ x: 7, y: -6 });
            if (this.bombType == BombData.BOMB_MOR)
                this.trans.play(null, 1, 0, 0, 1.25);
        } else {
            this.body.setVelocity({ x: -7, y: -6 });
            if (this.bombType == BombData.BOMB_MOR)
                this.trans.play(null, 1, 0, 1.5, 2.75);
        }
        this.scene.x = this.parentPos.x + this.offPos.x;
        this.scene.y = this.parentPos.y + this.offPos.y;

    }

    protected showBoomView(): void {
        SoundManager.instance.playSound("boom");
        var bomb: BoomView = Laya.Pool.getItemByClass("boomView", BoomView);
        var p: Laya.Point = ViewManager.instance.getBodyCenterPos(this.scene);
        bomb.createView(ViewManager.instance.getBoomAniTypeByBomb(this.bombType), p, this.isPlayer);
    }

    protected dispose(s: any): void {
        if (s.s == this.box.owner) {
            this.showBoomView();
            this.disposeAll();
        }
    }

    protected disposeAll(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
        Laya.Pool.recover("bombView", this);
        if (this.view) this.view.dispose();
        this.scene.removeSelf();
    }

}