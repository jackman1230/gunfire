export class AssetsData {

    public static assetsData = [];

    constructor() {

    }

    public static loadAssetsData(): any {
        this.assetsData.push(
            [{ url: "assets/Game_atlas0.png", type: Laya.Loader.IMAGE },
            { url: "assets/Game.fui", type: Laya.Loader.BUFFER }
            ],
        );

        Laya.loader.load(this.assetsData, Laya.Handler.create(this, this.loadComplete))




        return this.assetsData;
    }

    private static loadComplete(): void {

    }




}