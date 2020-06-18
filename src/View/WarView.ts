import WXFUI_WarView from "../fui/Game/WXFUI_WarView";
import { ViewManager } from "../Manager/ViewManager";
import ObstacleView from "./ObstacleView";
import { ObstacleType, GameData } from "../Data/GameData";
import Player from "./Player";
import { GameManager } from "../Manager/GameManager";
import { EnemyInfo } from "../Data/PlayerData";

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



        GameManager.instance.createPlayer();//创建人物
        GameManager.instance.createEnemyData();//创建当前关卡的敌人
        GameManager.instance.createObstacleData();//创建当前关卡的障碍物
    }

    public updateViewPort(moveX: number): void {
        this.warView.x -= moveX;
    }

}
