import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";

export class AssetsManager {
    private static _instance: AssetsManager;
    public static assetsData = [];

    constructor() {
    }

    public static get instance(): AssetsManager {
        if (this._instance == null)
            this._instance = new AssetsManager();
        return this._instance;
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
            { url: "res/map_1.jpg", type: Laya.Loader.IMAGE },
            { url: "res/Game.wxfui", type: Laya.Loader.BUFFER }

        );
        console.log(AssetsManager.assetsData);

        Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(): void {
        fairygui.UIPackage.addPackage("res/Game");

        console.log("资源加载完成");
        GameManager.instance.startGame();
    }
}

