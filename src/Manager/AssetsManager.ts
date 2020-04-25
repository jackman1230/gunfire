
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
            { url: "res/Game.fui", type: Laya.Loader.BUFFER }

        );
        console.log(AssetsManager.assetsData);

        Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete));
    }

    private loadComplete(): void {
        console.log("资源加载完成");
        
    }
}

