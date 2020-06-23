import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import GameBinder from "../fui/Game/GameBinder";

export class AssetsManager {
    private static _instance: AssetsManager;
    public static assetsData = [];
    public static loadingAssetsData = [];
    constructor() {
    }

    public static get instance(): AssetsManager {
        if (this._instance == null)
            this._instance = new AssetsManager();
        return this._instance;
    }

    public loadLoadingAssetsData(): void {
        AssetsManager.loadingAssetsData.push(
            { url: "res/loading_atlas0.png", type: Laya.Loader.IMAGE },
            { url: "res/loading_atlas_n8quey.jpg", type: Laya.Loader.IMAGE },
            { url: "res/loading.wxfui", type: Laya.Loader.BUFFER }
        );
        Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
    }

    private loadingAssetsComplete(): void {
        fairygui.UIPackage.addPackage("res/loading");
        console.log("loading界面资源加载完成--显示loading界面，并开始加载游戏资源");
        ViewManager.instance.createLoaningView();
        this.loadAssetsData();
    }

    public loadAssetsData() {
        AssetsManager.assetsData.push(
            { url: "res/Game_atlas0.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_1.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_2.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_3.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_4.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_5.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas_n8qun1.jpg", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas_n8qun7.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_9.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_10.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_11.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_12.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_13.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_14.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_15.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_16.png", type: Laya.Loader.IMAGE },
            { url: "res/LevelData.json", type: Laya.Loader.JSON },
            { url: "res/map_1.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_3.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_4.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_5.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_6.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_7.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_8.jpg", type: Laya.Loader.IMAGE },
            { url: "res/Game.wxfui", type: Laya.Loader.BUFFER }

        );
        console.log(AssetsManager.assetsData);

        Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete), Laya.Handler.create(this, this.onloadingProgress));
    }

    private onloadingProgress(progress: number): void {
        ViewManager.instance.setLoadongProgress(progress);
    }

    private loadComplete(): void {
        fairygui.UIPackage.addPackage("res/Game");

        console.log("资源加载完成");
        ViewManager.instance.hideLoadingView();
        GameManager.instance.startGame();
    }
}

