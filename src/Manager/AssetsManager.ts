import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import { MooSnowSDK } from "./MooSnowSDK";

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

        if (Laya.Browser.onPC) {
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));
            return;
        }

        // this.setVersionUrl(AssetsManager.loadingAssetsData);
        if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.WX) {
            console.log("onWeiXin");
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onWXLoaded));
        } else if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.QQ) {
            console.log("loadQQ");
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onQQLoaded));
        } else if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.VIVO) {
            console.log("loadVIVO");
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onVIVOLoaded));
        } else {
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.loadingAssetsComplete));

        }
    }

    private onWXLoaded(): void {
        if (moosnow.getAppPlatform() == moosnow.APP_PLATFORM.QQ) {
            console.log("loadQQ");
            Laya.loader.create(AssetsManager.loadingAssetsData, Laya.Handler.create(this, this.onQQLoaded));
            return;
        }
        //微信小游戏官方的分包加载方式
        let wxLoad = Laya.Browser.window.wx;
        const wxloadTask = wxLoad["loadSubpackage"]({
            name: 'res', // name 可以填 name 或者 root
            success: function (res) {
                // 分包加载成功后通过 success 回调
                AssetsManager.instance.loadingAssetsComplete();
            },
            fail: function (res) {
                // 分包加载失败通过 fail 回调
                console.log("分包加载wx失败");
            }
        })
    }

    private onQQLoaded(): void {
        //qq小游戏官方的分包加载方式
        let qqLoad = Laya.Browser.window.qq;
        const qqloadTask = qqLoad["loadSubpackage"]({
            name: 'res', // name 可以填 name 或者 root
            success: function (res) {
                // 分包加载成功后通过 success 回调
                AssetsManager.instance.loadingAssetsComplete();
            },
            fail: function (res) {
                // 分包加载失败通过 fail 回调
                console.log("分包加载qq失败");
            }
        })
    }

    private onVIVOLoaded(): void {//vivo小游戏
        //vivo小游戏官方的分包加载方式
        let qgLoad = Laya.Browser.window.qg;
        const qgloadTask = qgLoad["loadSubpackage"]({
            name: 'res', // name 可以填 name 或者 root
            success: function (res) {
                // 分包加载成功后通过 success 回调
                AssetsManager.instance.loadingAssetsComplete();
            },
            fail: function (res) {
                // 分包加载失败通过 fail 回调
                console.log("分包加载vivo失败");
            }
        })
    }

    private loadingAssetsComplete(): void {
        fairygui.UIPackage.addPackage("loading/loading");
        console.log("loading界面资源加载完成--显示loading界面，并开始加载游戏资源");
        MooSnowSDK.getMistouchPosNum();
        MooSnowSDK.getMisTouchNum();
        MooSnowSDK.getAllConfig();
        // Laya.timer.once(6000,this,()=>{
        // })
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
            { url: "res/Game_atlas0_8.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_9.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas0_10.png", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas_n8qun1.jpg", type: Laya.Loader.IMAGE },
            { url: "res/Game_atlas_n8qun7.png", type: Laya.Loader.IMAGE },
            { url: "res/LevelData.json", type: Laya.Loader.JSON },
            { url: "res/LevelData2.json", type: Laya.Loader.JSON },
            { url: "res/map_1.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_3.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_4.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_5.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_6.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_7.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_8.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_1_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_2_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_3_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_4_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_5_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_6_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_7_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/map_8_2.jpg", type: Laya.Loader.IMAGE },
            { url: "res/Game.proto", type: Laya.Loader.BUFFER },
            { url: "res/zhujue_body.png", type: Laya.Loader.IMAGE },
            { url: "res/zhujue_body.sk", type: Laya.Loader.BUFFER },
            { url: "res/hero_arm.png", type: Laya.Loader.IMAGE },
            { url: "res/hero_arm.sk", type: Laya.Loader.BUFFER },
            { url: "res/sound/bgm.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/BombDrop.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/boom.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/btn_click.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/btn_press.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/die_1.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/die_2.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/die_3.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/die_4.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/enemy_fire.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/gameOver.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/get_goods.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/obstacleBoom.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/obstacleBoom2.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/tank_fire.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/weapon_1.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/weapon_2.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/weapon_3.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/weapon_10.mp3", type: Laya.Loader.SOUND },
            { url: "res/sound/chapterBgm.mp3", type: Laya.Loader.SOUND }
        );
        // console.log(AssetsManager.assetsData);

        // this.setVersionUrl(AssetsManager.assetsData);

        Laya.loader.create(AssetsManager.assetsData, Laya.Handler.create(this, this.loadComplete), Laya.Handler.create(this, this.onloadingProgress));
    }

    private onloadingProgress(progress: number): void {
        ViewManager.instance.setLoadongProgress(progress);
    }

    private loadComplete(): void {
        fairygui.UIPackage.addPackage("res/Game");
        ViewManager.instance.hideLoadingView();
        moosnow.http.finishLoading();
        GameManager.instance.startGame();
    }

    private setVersionUrl(arr: any[]): void {
        for (let i = 0; i < arr.length; i++) {
            var t: any = arr[i];
            t.url = this.getVersionUrl(t.url);
        }
    }

    private getVersionUrl(s: string): string {
        var v: any = Laya.loader.getRes("version.json");
        if (v[s]) {
            return v[s]
        }
        return s;
    }

}

