import WXFUI_WarView from "../fui/Game/WXFUI_WarView";
import { ViewManager } from "../Manager/ViewManager";
import ObstacleView from "./ObstacleView";
import { ObstacleType } from "../Data/GameData";
import { LayerData } from "../Data/LayerData";
import { GameManager, EnemyInfo } from "../Manager/GameManager";
import Player from "./Player";

export class WarView {

    public warView: WXFUI_WarView;
    public scene: Laya.Sprite;//地图场景
    constructor() { }
    public createView() {
        Laya.Scene.load("map_1.scene", Laya.Handler.create(this, this.loadComplete));
    };

    private loadComplete(s: Laya.Scene): void {
        this.scene = s;
        this.warView = fairygui.UIPackage.createObject("Game", "WarView") as WXFUI_WarView;
        Laya.Physics.I.worldRoot = this.scene;

        this.warView.displayObject.addChild(this.scene);

        Laya.stage.addChildAt(this.warView.displayObject, 0);

        this.initRole();
        this.initEnemy();
        ViewManager.instance.createPlayerInfoView();
    }

    private initRole(): void {
        if (!ViewManager.instance.rolePlayer) {
            ViewManager.instance.player = new Player();
            ViewManager.instance.player.createView();
        }
    }

    private initEnemy(): void {
        var enemyArr: any[] = GameManager.instance.curLvData.enemy.concat();
        console.log("enemyArr--", enemyArr);
        for (let i = 0; i < enemyArr.length; i++) {
            var t: any = enemyArr[i];
            var d: EnemyInfo = new EnemyInfo();
            d.expRate = t.expRate.concat();
            d.pos = new Laya.Point(t.pos[0], t.pos[1]);
            d.activeDis = t.activeDis;
            d.damage = t.damage;
            d.blood = t.blood;
            d.dir = t.dir;
            d.isBoss = t.isBoss;
            d.type = t.type;
            if (d) {
                ViewManager.instance.createEnemy(d);
            }
        }
    }

    public updateViewPort(moveX: number): void {
        this.warView.x -= moveX;
    }

}
