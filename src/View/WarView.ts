import WXFUI_WarView from "../fui/Game/WXFUI_WarView";
import { ViewManager } from "../Manager/ViewManager";

export class WarView {

    public warView: WXFUI_WarView;
    public scene: Laya.Sprite;//地图场景


    constructor() { }
    public initView() {
        Laya.Scene.load("map_1.scene", Laya.Handler.create(this, this.loadComplete));
    };

    private loadComplete(s: Laya.Scene): void {
        this.scene = s;
        this.warView = fairygui.UIPackage.createObject("Game", "WarView") as WXFUI_WarView;
        Laya.Physics.I.worldRoot = this.scene;

        this.warView.displayObject.addChild(this.scene);
        this.scene.addChild(ViewManager.instance.rolePlayer.roleBody);

        ViewManager.instance.rolePlayer.roleBody.x = 800;
        ViewManager.instance.rolePlayer.roleBody.y = 400;
        ViewManager.instance.rolePlayer.setStay();

        Laya.stage.addChild(this.warView.displayObject);


        ViewManager.instance.createEnemy();
        // this.scene.viewport
    }

    public updateViewPort(moveX: number): void {
        this.warView.x -= moveX;
    }

}
