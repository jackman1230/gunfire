import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import GameBinder from "../fui/Game/GameBinder";

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
            // { url: "res/Game_atlas0_6.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_7.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_8.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_9.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_10.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_11.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_12.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_13.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_14.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_15.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_16.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_17.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_18.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_19.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_20.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_21.png", type: Laya.Loader.IMAGE },
            // { url: "res/Game_atlas0_22.png", type: Laya.Loader.IMAGE },
            { url: "res/LevelData.json", type: Laya.Loader.JSON },
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

