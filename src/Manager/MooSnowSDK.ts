import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import { SoundManager } from "./SoundManager";
import { EventManager } from "./EventManager";
import GameEvent from "../Control/GameEvent";
import { VideoData, VideoType, VideoInfo } from "../Data/VideoData";

export class MooSnowSDK {

    public static misTouchNum: number = 0;

    public static mistouchPos: number = 0;


    public static login(): void {
        moosnow.platform.login(() => {
            console.log('登录成功 ')
        });
        if (MooSnowSDK.getPlatform() == moosnow.APP_PLATFORM.WX)
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
    public static showBanner(isWuChu: boolean = false): void {
        moosnow.platform.showBanner(isWuChu, (isOpend) => {
            //目前仅支持微信平台
            console.log('用户是否点击了banner ', isOpend);
            if (isOpend) {
                if (isWuChu) {
                    MooSnowSDK.hideBanner();
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX)
                        ViewManager.instance.clickChestView.clickSuccess();
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
                        ViewManager.instance.clickAdView.showReward();
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
     * data:获得道具数据
     * videoData.type:1看视频得奖励，2看视频原地复活,3双倍金币，4获得宝箱
     */
    public static showVideo(data: any, videoData: VideoData, successFun?: Function): void {
        if (SoundManager.instance.isOpenSound) {//如果打开了音效，关闭音效
            Laya.SoundManager.soundMuted = true;
            Laya.SoundManager.musicMuted = true;
        }
        if (videoData.type == VideoType.VIDEOTYPE_ITEM) {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_ITEM);
        } else if (videoData.type == VideoType.VIDEOTYPE_LIFE) {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_LIFE);
        } else if (videoData.type == VideoType.VIDEOTYPE_DOUBLE_COIN) {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_DOUBLE_COIN);
        } else if (videoData.type == VideoType.VIDEOTYPE_BOX) {
            MooSnowSDK.videoPoint(0, GameManager.instance.choiseLevel, VideoInfo.VIDEOINFO_BOX);
        }

        moosnow.platform.showVideo(res => {
            switch (res) {
                case moosnow.VIDEO_STATUS.NOTEND:
                    console.log('视频未观看完成 ');
                    if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                        ViewManager.instance.showNoVideoView(videoData, data, successFun);
                    } else
                        ViewManager.instance.showTipsView("未看完视频无法获得奖励哦");
                    break;
                case moosnow.VIDEO_STATUS.ERR:
                    console.log('获取视频错误 ');
                    ViewManager.instance.showTipsView("视频获取失败，请稍后再试");
                    break;
                case moosnow.VIDEO_STATUS.END:
                    console.log('观看视频结束 ')
                    GameManager.instance.showVideoResp(data, videoData, successFun);
                    MooSnowSDK.videoPoint(1, GameManager.instance.choiseLevel, videoData.info);
                    break;
            }
            if (SoundManager.instance.isOpenSound) {
                Laya.SoundManager.soundMuted = false;
                Laya.SoundManager.musicMuted = false;
                SoundManager.instance.playBGM(SoundManager.instance.bgmName);
            }
        });
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
    * @param closeShowBannerr 关闭界面后是否显示banner
    */
    public static showQQADBox(isWuChu: boolean = false, closeShowBannerr: boolean = false): void {
        moosnow.platform.showAppBox((res) => {
            //res ==-1 表示后台没有开启功能  res==0 表示用户主动关闭了盒子
            if (res <= 0) {
                moosnow.platform.hideAppBox();
                EventManager.instance.dispatcherEvt(GameEvent.CLOSE_APP_AD_BOX);
            }
            if (isWuChu && res == 0) {
                ViewManager.instance.hidePopUpView(ViewManager.instance.clickAdView);
                MooSnowSDK.hideQQADBox();
            }
            // console.log('关闭盒子')
        }, false);
    }

    /**
    * 隐藏盒子广告并显示结算界面
    */
    public static hideQQADBox(): void {
        moosnow.platform.hideAppBox(
            () => {
                ViewManager.instance.showResultView();
            }
        );
    }

    /**
    *开始录制
    */
    public static startRecord(): void {
        moosnow.platform.startRecord(300, (e) => {
            console.log('是否是抖音', e)
        });
    }

    /**
    * 停止录制
    */
    public static stopRecord(): void {
        moosnow.platform.stopRecord((res) => {
            if (res.videoPath) {
                //录制的视频路径
                let videoPath = res.videoPath;

                // setTimeout(() => {
                //     this.shareRecord();
                // }, 200);
            }
        });
    }

    /**
    * 分享视频
    */
    public static shareRecord(): void {
        moosnow.platform.share({
            channel: moosnow.SHARE_CHANNEL.VIDEO
        }, (res) => {
            console.log('分享结束', res)
        }, (res) => {
            //仅iphone 会有  安卓时间太短会唤起录像功能
            console.log('录屏时间太短', res)
        });
        // /**
        //      * 分享
        //      * @param query 分享参数 { channel:moosnow.SHARE_CHANNEL.LINK }  
        //      * SHARE_CHANNEL.LINK, SHARE_CHANNEL.ARTICLE, SHARE_CHANNEL.TOKEN, SHARE_CHANNEL.VIDEO 可选 仅字节跳动有效
        //      * @param callback 分享成功回调参数 = true, 分享失败回调参数 = false,
        //      * @param shortCall 时间过短时回调 ,err 是具体错误信息，目前只在头条分享录屏时用到
        //      */
    }


















}