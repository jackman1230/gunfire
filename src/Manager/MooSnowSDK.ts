import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import { SoundManager } from "./SoundManager";

export class MooSnowSDK {

    public static misTouchNum: number = 0;

    public static mistouchPos: number = 0;


    public static login(): void {
        moosnow.platform.login(() => {
            console.log('登录成功 ')
        });

        MooSnowSDK.showAutoBanner();
    }

    public static finishLoading(): void {
        moosnow.http.finishLoading();
    }

    public static startGame(lv: number): void {
        /**
         * 统计开始游戏
         * @param level 关卡数 必须是1 || 2 || 1.1 || 12.2 格式
         */
        moosnow.http.startGame(lv + "")
    }

    public static endGame(lv: number, isWin: boolean): void {
        /**
      * 统计结束游戏
      * @param level 关卡数 必须是1 || 2 || 1.1 || 12.2 格式
      * @param isWin 是否成功
      */
        moosnow.http.endGame(lv + "", isWin)
    }
    /**
        * 视频统计
         * @param type 0：视频点击 1：视频观看完成
         * @param info 信息 ex:“领取三倍金币”
         * @param level 关卡数	没有请填”0”
         * 注意：点击之后上报一次，type=0，观看完视频后应再上报一次，type=1。
         */
    public static videoPoint(type: number, lv: number, str: string): void {

        moosnow.http.videoPoint(type + "", str, lv + "")
    }
    /**
    * 获取广告
    */
    public static getAD(): void {
        moosnow.ad.getAd((r) => {
            console.log('广告数据 ', r);
            GameManager.instance.adList = r.indexLeft.concat();
            GameManager.instance.setADlist();

        })
    }

    /**
     * 显示平台的banner广告
     * @param remoteOn 是否被后台开关控制 默认 true，误触的地方传 true  普通的地方传 false
     * @param callback 点击回调
     * @param position banner的位置，默认底部
     * @param style 自定义样式
     */
    public static showBanner(isWuChu: boolean): void {
        moosnow.platform.showBanner(false, (isOpend) => {
            //目前仅支持微信平台
            console.log('用户是否点击了banner ', isOpend);
            if (isOpend) {
                if (isWuChu) {
                    MooSnowSDK.hideBanner();
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX)
                        ViewManager.instance.clickChestView.clickSuccess();
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {

                    }
                }
            }
        });
    }

    public static hideBanner(): void {
        moosnow.platform.hideBanner();
    }

    public static showAutoBanner(): void {
        //在进入游戏后，调用一次该方法,该方法会展示banner ，并自动关闭
        moosnow.platform.showAutoBanner();
    }

    /**
     * 显示平台video广告
     * type:1看视频得奖励，2看视频原地复活
     */
    public static showVideo(type: number, data: any): void {
        var d: any = data;
        SoundManager.instance.offSound();
        if (type == 1) {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, "看视频获得物资");
        } else {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, "看视频原地复活");
        }

        moosnow.platform.showVideo(res => {
            switch (res) {
                case moosnow.VIDEO_STATUS.NOTEND:
                    console.log('视频未观看完成 ')
                    ViewManager.instance.showTipsView("未看完视频无法获得奖励哦");
                    break;
                case moosnow.VIDEO_STATUS.ERR:
                    console.log('获取视频错误 ')
                    ViewManager.instance.showTipsView("视频获取失败，请稍后再试");
                    break;
                case moosnow.VIDEO_STATUS.END:
                    console.log('观看视频结束 ')
                    if (type == 1 && data) {
                        GameManager.instance.buyShopItem(d, true);
                        ViewManager.instance.beforeWar.updateView();
                        MooSnowSDK.videoPoint(1, GameManager.instance.choiseLevel, "看视频获得物资");
                    } else {
                        GameManager.instance.continueGameByVideo();
                        MooSnowSDK.videoPoint(1, GameManager.instance.choiseLevel, "看视频原地复活");
                    }
                default:
                    break;
            }
            SoundManager.instance.openSound();
        })
    }


    /**
    * 获取位移间隔次数，启动游戏时调用
    * @param callback 回调参数为misTouchPosNum :int，当misTouchPosNum =0时关闭位移误点，
    当misTouchPosNum =1时，每次都触发误点（即当misTouchPosNum =n(0除外)时，每	隔n次，触发位移1次）
    */
    public static getMistouchPosNum(): void {
        var misTouchPosNum = 0;
        moosnow.http.getMistouchPosNum((res) => {
            MooSnowSDK.mistouchPos = misTouchPosNum = res;		//位移次数间隔
            console.log("误点位移次数间隔", res);

        })
    }

    /**
     * 获取误点间隔次数，启动游戏时调用
     * @param callback 回调参数为misTouchNum:int，当misTouchNum=0时关闭误点，
        当misTouchNum=1时，每次都触发误点（即当misTouchNum=n(0除外)时，每	隔n次，触发误点1次）
    */
    public static getMisTouchNum(): void {
        var misTouchNum = 0;
        moosnow.http.getMisTouchNum((res) => {
            MooSnowSDK.misTouchNum = misTouchNum = res;		//误点次数间隔
            console.log("误点次数间隔", res);
        })
    }
    /**
     * 微信平台 其他打点
     * @param str 
     */
    public static setPoint(str: string): void {
        moosnow.http.point(str);
    }

    /**
     * 获取所有参数
     * @param str 
     */
    public static getAllConfig(): any {
        var data: any;
        moosnow.http.getAllConfig(res => {
            data = res;
            console.log("游戏的所有配置数据", res);
        });
        return data;
    }

    /**
     * 获取平台类型
     * @param str 
     */
    public static getPlatform(): number {
        let curPlatform = moosnow.getAppPlatform();
        // QQ
        // moosnow.APP_PLATFORM.QQ
        // WX
        // moosnow.APP_PLATFORM.WX
        return curPlatform;
    }

    /**
    * 盒子广告
    * @param callback 关闭回调
    * @param remoteOn 被后台开关控制  一般首页传 false  需要误触的地方传true
    */
    public static showQQADBox(): void {
        moosnow.platform.showAppBox((res) => {
            //res ==-1 表示后台没有开启功能  res==0 表示用户主动关闭了盒子
            if (res) {

            }
            console.log('关闭盒子')
        }, false);
    }


















}