
export class MooSnowSDK {


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
    public static videoPoint(type: number, lv: number): void {

        moosnow.http.videoPoint(type + "", "原地复活", lv + "")
    }
    /**
    * 获取广告
    */
    public static getAD(r): void {
        moosnow.ad.getAd((r) => {
            console.log('广告数据 ', r)
        })
    }

    /**
     * 显示平台的banner广告
     * @param remoteOn 是否被后台开关控制 默认 true，误触的地方传 true  普通的地方传 false
     * @param callback 点击回调
     * @param position banner的位置，默认底部
     * @param style 自定义样式
     */
    public static showBanner(): void {
        moosnow.platform.showBanner(true, (isOpend) => {
            //目前仅支持微信平台
            console.log('用户是否点击了banner ', isOpend)
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
     */
    public static showVideo(): void {
        moosnow.platform.showVideo(res => {
            switch (res) {
                case moosnow.VIDEO_STATUS.NOTEND:
                    console.log('视频未观看完成 ')
                    break;
                case moosnow.VIDEO_STATUS.ERR:
                    console.log('获取视频错误 ')
                    break;
                case moosnow.VIDEO_STATUS.END:
                    console.log('观看视频结束 ')
                default:
                    break;
            }
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
            misTouchPosNum = res;		//位移次数间隔
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
            misTouchNum = res;		//误点次数间隔
        })
    }
    /**
     * 微信平台 其他打点
     * @param str 
     */
    public static setPoint(str: string): void {
        moosnow.http.point(str);
    }


















}