import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import WXFUI_goodsView from "../fui/Game/WXFUI_goodsView";
import { ViewManager } from "../Manager/ViewManager";

export default class GoodsView {

    public scene: Laya.Sprite;
    public view: WXFUI_goodsView;
    public load: fairygui.GLoader;

    public type: number = 1;

    protected box: Laya.BoxCollider;
    protected body: Laya.RigidBody;

    protected pos: Laya.Point;

    constructor() { }

    createView(type: number, s: Laya.Point): void {
        this.type = type;
        this.pos = s;
        Laya.Scene.load("GoodsBody.scene", Laya.Handler.create(this, this.loadComplete));
    }

    protected loadComplete(s: Laya.Scene): void {
        console.log("GoodsBody.scene--loadComplete", s);
        this.scene = s;
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);

        this.view = fairygui.UIPackage.createObject("Game", "goodsView") as WXFUI_goodsView;
        this.view.m_load.url = "ui://Game/createGoodsAni";
        this.view.m_load.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniComplete))

        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.setBombPos();

        EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);

    }

    private createAniComplete(): void {
        this.view.m_load.url = "ui://Game/goods_" + this.type;
    }

    private dispose(s: Laya.Sprite): void {
        if (s == this.box.owner) {
            EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
            EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.type);

            this.scene.removeSelf();
            this.view.dispose();
            Laya.Pool.recover("goods", this);
        }
    }


    protected setBombPos(): void {
        this.scene.x = this.pos.x + 20;
        this.scene.y = this.pos.y;
    }

}