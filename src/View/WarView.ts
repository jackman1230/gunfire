import WXFUI_WarView from "../fui/Game/WXFUI_WarView";
import { ViewManager } from "../Manager/ViewManager";
import { GameManager } from "../Manager/GameManager";
import { ui } from "../ui/layaMaxUI";
import { SoundManager } from "../Manager/SoundManager";
import { MooSnowSDK } from "../Manager/MooSnowSDK";

export class WarView {

    public warView: WXFUI_WarView;
    public scene: Laya.Sprite;//地图场景
    constructor() { }
    public createView() {
        var index: number = GameManager.instance.curLevelData.mapIndex;
        if (index == 1) {
            this.scene = new ui.map_1UI();
        } else if (index == 2) {
            this.scene = new ui.map_2UI();
        } else if (index == 3) {
            this.scene = new ui.map_3UI();
        } else if (index == 4) {
            this.scene = new ui.map_4UI();
        } else if (index == 5) {
            this.scene = new ui.map_5UI();
        } else if (index == 6) {
            this.scene = new ui.map_6UI();
        } else if (index == 7) {
            this.scene = new ui.map_7UI();
        } else if (index == 8) {
            this.scene = new ui.map_8UI();
        } else {
            return;
        }
        this.loadComplete();
        // Laya.Scene.load("map_" + GameManager.instance.curLevelData.mapIndex + ".scene", Laya.Handler.create(this, this.loadComplete));
    };

    private loadComplete(): void {
        // this.scene = s;
        console.log("warView-------");

        this.warView = fairygui.UIPackage.createObject("Game", "WarView") as WXFUI_WarView;
        this.warView.m_bg.url = "res/map_" + GameManager.instance.curLevelData.mapIndex + ".jpg";
        this.warView.m_bg2.url = "res/map_" + GameManager.instance.curLevelData.mapIndex + "_2.jpg";

        Laya.Physics.I.worldRoot = this.scene;

        ViewManager.instance.createPlayer();//创建人物
        GameManager.instance.createEnemyData();//创建当前关卡的敌人
        GameManager.instance.createObstacleData();//创建当前关卡的障碍物

        this.warView.x = GameManager.instance.curLvData.warViewPos[0];
        this.warView.y = GameManager.instance.curLvData.warViewPos[1];
        this.warView.displayObject.addChild(this.scene);
        Laya.stage.addChildAt(this.warView.displayObject, 0);

        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            MooSnowSDK.showBanner(false);
            Laya.timer.once(2500, this, this.clearBanner);
        }
    }

    private clearBanner(): void {
        MooSnowSDK.hideBanner();
    }

    private showReMenAd(): void {
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.showADListView();
    }
    
    public updateViewPort(moveX: number): void {
        // ViewManager.instance.warView.warView.width - this.roleSprite.width - 20;
        // if (this.warView.x - moveX > Laya.stage.width - ViewManager.instance.warView.warView.width - 20) {
        Laya.Tween.to(this.warView, { x: this.warView.x - moveX }, 500, Laya.Ease.linearIn);
        // Laya.timer.once(900, this, () => {
        //     ViewManager.instance.player.tweenRun = false;
        // });
        // } else {
        //     Laya.Tween.to(this.warView, { x: Laya.stage.width - ViewManager.instance.warView.warView.width - 20 }, 450, Laya.Ease.circOut);
        //     Laya.timer.once(500, this, () => {
        //         ViewManager.instance.player.tweenRun = false;
        //     });
        // }
        // console.log("moveX--", (this.warView.x - moveX));
        // console.log("warView--", this.warView.x);

        // this.warView.x -= moveX;
    }

    public dispose(): void {
        if (this.scene) {
            this.scene.removeChildren();
            this.scene.removeSelf();
        }
        if (this.warView) {
            this.warView.displayObject.removeChildren();
            this.warView.dispose();
        }
        Laya.timer.clear(this, this.clearBanner);
        this.recover();
    }

    public recover(): void {
        Laya.Pool.recover("warView", this);
    }

    public removeView(): void {
        this.warView.displayObject.removeChild(this.scene);
        Laya.stage.removeChild(this.warView.displayObject);
    }

}
