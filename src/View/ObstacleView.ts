
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import PlayerAni from "./PlayerAni";
import { ViewManager } from "../Manager/ViewManager";
import WXFUI_enemy from "../fui/Game/WXFUI_enemy";
import EnemyBody from "./Body/EnemyBody";
import GameEvent from "../Control/GameEvent";
import { EventManager } from "../Manager/EventManager";
import { GameData } from "../Data/GameData";
import { ObstacleInfo } from "../Data/PlayerData";

export default class ObstacleView {
    public scene: Laya.Sprite;
    public view: fairygui.GComponent;
    public load: fairygui.GLoader;

    public type: number = 1;

    protected direction: number = 0;
    protected box: Laya.PolygonCollider;

    protected isDeath: boolean = false;

    protected blood: number = 1;

    protected pos: Laya.Point;

    constructor() { }

    public createView(d: ObstacleInfo) {
        this.type = d.type;
        this.blood = d.blood;
        this.pos = d.pos;

        Laya.Scene.load("ObstacleView_" + this.type + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    public loadComplete(s: Laya.Sprite) {
        this.view = fairygui.UIPackage.createObject("Game", "obstacleView") as fairygui.GComponent;
        this.view.setPivot(0.5, 0.5);
        this.load = this.view.getChildAt(0) as fairygui.GLoader;
        this.scene = s;
        this.initView();
    };

    public initView(): void {
        this.load.url = "ui://Game/obstacle_" + this.type;
        this.scene.addChild(this.view.displayObject);
        this.scene.addComponent(EnemyBody);
        this.box = this.scene.getComponent(Laya.PolygonCollider);

        this.isDeath = false;

        this.scene.x = this.pos.x;
        this.scene.y = this.pos.y;
        ViewManager.instance.warView.scene.addChild(this.scene);
        EventManager.instance.addNotice(GameEvent.PLAYER_BOMB_HIT_OBSTACLE, this, this.beHit);
        EventManager.instance.addNotice(GameEvent.PLAYER_BULLET_HIT_OBSTACLE, this, this.beHit);

    }

    public beHit(s: any): void {
        if (this.isDeath) return;
        if (s.o == this.box.owner) {
            this.blood--;
            Laya.timer.clear(this, this.setColor);
            if (this.blood <= 0) {
                this.setDeath();
            } else {
                this.load.color = "#ff0000";
                Laya.timer.once(200, this, this.setColor);
            }
        }
    }

    protected setColor(): void {
        this.load.color = "#ffffff";
    }


    public setDeath(): void {
        this.isDeath = true;
        Laya.timer.clearAll(this);
        this.load.url = "ui://Game/boom_" + ViewManager.instance.getBoomAniTypeByObsType(this.type);;
        this.load.content.setPlaySettings(0, -1, 1, 0, Laya.Handler.create(this, this.dispose));

        // var p: Laya.Point = new Laya.Point();
        // p.x = this.scene.x + this.scene.width / 2;
        // p.y = this.scene.y + this.scene.height / 2;
        // ViewManager.instance.createGoods(1, p);
    }

    protected dispose(): void {
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.beHit);
        EventManager.instance.offNotice(GameEvent.PLAYER_BULLET_HIT_ENEMY, this, this.beHit);
        Laya.timer.clearAll(this);
        this.scene.removeSelf();
        this.view.dispose();
        Laya.Pool.recover("obstacle", this);
    }
}