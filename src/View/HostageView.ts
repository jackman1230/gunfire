import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { ViewManager } from "../Manager/ViewManager";
import { ui } from "../ui/layaMaxUI";
import WXFUI_hostage from "../fui/Game/WXFUI_hostage";
import HostageBody from "./Body/HostageBody";
import { EnemyInfo } from "../Data/PlayerData";
import { GoodsType } from "../Data/GameData";

export default class HostageView {

    public scene: Laya.Sprite;
    public view: WXFUI_hostage;
    public load: fairygui.GLoader;

    protected box: Laya.BoxCollider;
    protected body: Laya.RigidBody;

    protected pos: Laya.Point;

    private isActive: boolean = false;

    constructor() { }

    createView(d: EnemyInfo): void {
        this.scene = new ui.HostageBodyUI();
        this.pos = d.pos;
        this.loadComplete();
    }

    protected loadComplete(): void {
        this.body = this.scene.getComponent(Laya.RigidBody);
        this.box = this.scene.getComponent(Laya.BoxCollider);
        this.scene.addComponent(HostageBody);
        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        this.view = fairygui.UIPackage.createObject("Game", "hostage") as WXFUI_hostage;
        this.scene.addChild(this.view.displayObject);
        ViewManager.instance.warView.scene.addChild(this.scene);

        EventManager.instance.addNotice(GameEvent.ACTIVE_HOSTAGE, this, this.activeHostage);

    }

    private activeHostage(s: Laya.Sprite): void {
        if (this.isActive) return;
        if (this.box.owner == s) {
            this.isActive = true;
            this.view.m_en.url = "ui://Game/hostageAni";
            this.view.m_en.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));
        }
    }
    private dispose(s: Laya.Sprite): void {
        var p: Laya.Point = new Laya.Point();
        p.x = this.scene.x + this.scene.width / 2;
        p.y = this.scene.y + this.scene.height / 2;
        ViewManager.instance.createGoods(GoodsType.GoodsType_BOX, p);

        EventManager.instance.offNotice(GameEvent.ACTIVE_HOSTAGE, this, this.activeHostage);
        this.view.removeChildren();
        if (this.view) this.view.dispose();
        if (this.scene) {
            this.scene.removeSelf();
        }
        Laya.Pool.recover("hostage", this);
    }

}