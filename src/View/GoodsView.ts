import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import WXFUI_goodsView from "../fui/Game/WXFUI_goodsView";
import { ViewManager } from "../Manager/ViewManager";
import { GoodsType } from "../Data/GameData";
import { SoundManager } from "../Manager/SoundManager";
import { ui } from "../ui/layaMaxUI";
import GoodsBody from "./Body/GoodsBody";

export default class GoodsView {

    public scene: Laya.Sprite;
    public view: WXFUI_goodsView;
    public load: fairygui.GLoader;

    public type: number = 1;

    protected box: Laya.BoxCollider;
    protected body: Laya.RigidBody;

    protected pos: Laya.Point;
    protected mc: fairygui.GMovieClip;

    constructor() { }

    createView(type: number, s: Laya.Point): void {
        this.type = type;
        this.pos = s;
        this.scene = new ui.GoodsBodyUI();
        this.loadComplete();
        // Laya.Scene.load("GoodsBody.scene", Laya.Handler.create(this, this.loadComplete));
    }

    protected loadComplete(): void {
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.scene.addComponent(GoodsBody);

        this.view = fairygui.UIPackage.createObject("Game", "goodsView") as WXFUI_goodsView;
        this.mc = fairygui.UIPackage.createObject("Game", "createGoodsAni").asMovieClip;
        // this.view.m_load.url = "ui://Game/createGoodsAni";
        this.mc.x = -this.mc.width / 2 + 20;
        this.mc.y = -this.mc.height / 2;
        this.mc.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.createAniComplete))
        this.view.addChild(this.mc);
        // this.view.m_load.url = "ui://Game/goods_" + this.type;


        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);
        this.setBombPos();

        EventManager.instance.addNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
        EventManager.instance.addNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);

    }

    private createAniComplete(): void {
        this.view.removeChild(this.mc);
        this.view.m_load.url = "ui://Game/goods_" + this.type;
        if (this.type != GoodsType.GoodsType_COIN && this.type != GoodsType.GoodsType_GRE) {
            this.view.m_load.content.setPlaySettings(0, -1, 0, 0);
        }
    }

    private dispose(s: Laya.Sprite): void {
        if (s == this.box.owner) {
            SoundManager.instance.playSound("get_goods");
            this.clearView();
        }
    }
    private clearView(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.clearView);
        EventManager.instance.offNotice(GameEvent.PLAYER_GET_GOODS, this, this.dispose);
        EventManager.instance.dispatcherEvt(GameEvent.CHANGE_PLAYER_GOODS, this.type);

        this.view.removeChildren();
        if (this.view) this.view.dispose();
        if (this.scene) {
            this.scene.removeSelf();
        }
        Laya.Pool.recover("goods", this);
    }


    protected setBombPos(): void {
        this.scene.x = this.pos.x + 20;
        this.scene.y = this.pos.y;
    }

}