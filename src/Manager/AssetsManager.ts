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
            { url: "loading/loading_atlas0.png", type: Laya.Loader.IMAGE },
            { url: "loading/loading_atlas_n8quey.jpg", type: Laya.Loader.IMAGE },
            { url: "loading/loading.proto", type: Laya.Loader.BUFFER }
        );
        if (!Laya.Browser.onWeiXin) {
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
        } else {
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onLoaded));
        }
    }

    private onLoaded(): void {
        //小游戏官方的分包加载方式
        let wxLoad = Laya.Browser.window.wx;
        const loadTask = wxLoad["loadSubpackage"]({
            name: 'res', // name 可以填 name 或者 root
            success: function (res) {
                // 分包加载成功后通过 success 回调
                AssetsManager.instance.loadingAssetsComplete();
            },
            fail: function (res) {
                // 分包加载失败通过 fail 回调
            }
        })

        // loadTask.onProgressUpdate(res => {
        //     console.log('下载进度', res.progress)
        //     console.log('已经下载的数据长度', res.totalBytesWritten)
        //     console.log('预期需要下载的数据总长度', res.totalBytesExpectedToWrite)
        // })
    }

    private loadingAssetsComplete(): void {
        fairygui.UIPackage.addPackage("loading/loading");
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
            { url: "res/Game.proto", type: Laya.Loader.BUFFER }

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

