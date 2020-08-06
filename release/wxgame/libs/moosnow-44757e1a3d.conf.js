window.moosnowConfig = {
    debug: 'wx',
    /**
     * 微信平台
     */
    wx: {
        bannerId: "adunit-a04414d0d178d99b",   //请填写你自己的APP banner id
        videoId: "adunit-1580a16d75ff22ec",    //请填写你自己的APP video id
        interId: "", //请填写你自己的APP inter id   
        nativeId: "",
        moosnowAppId: "wx545523eb56235413",
        version: "1.1.0"
    },
    oppo: {
        bannerId: "168776",
        videoId: "168781",
        interId: "168777",
        nativeId: ["168779", "168780"],
        moosnowAppId: "30251588",
        version: "1.1.0",
        url: "https://liteplay-1253992229.cos.ap-guangzhou.myqcloud.com/config/tp_hzyx_config_wx.json",
    },
    qq: {
        bannerId: "393fd2c197f4fdda1f9729ef36737890",
        videoId: "009f6251b101f9eeb54fb202d537e6d6",
        interId: "",
        boxId: "32b9a79d89010c17850ba54da9dab60f", //qq游戏特有的广告
        nativeId: ["", ""],
        moosnowAppId: "1110381022",
        version: "1.1.0",
        url: "https://liteplay-1253992229.cos.ap-guangzhou.myqcloud.com/config/tp_zzxhcar_config.json",//游戏的配置json，如果用到了getMistouchNum,后台必须配置mistouchNum字段
    },
    bd: {
        bannerId: "168776",
        videoId: "168781",
        interId: "168777",
        nativeId: ["168779", "168780"],
        moosnowAppId: "30251588",
        version: "1.1.0",
        url: "https://liteplay-1253992229.cos.ap-guangzhou.myqcloud.com/config/tp_zzxhcar_config.json",//游戏的配置json，如果用到了getMistouchNum,后台必须配置mistouchNum字段
    },
    byte: {
        bannerId: "168776",
        videoId: "168781",
        interId: "168777",
        nativeId: ["168779", "168780"],
        moosnowAppId: "30251588",
        version: "1.1.0",
        url: "https://liteplay-1253992229.cos.ap-guangzhou.myqcloud.com/config/tp_zzxhcar_config.json",//游戏的配置json，如果用到了getMistouchNum,后台必须配置mistouchNum字段
    }
}