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
        bannerId: "fae95316eaa78846d6595d396043b28a",
        videoId: "d673792964532ca5db9d99430cb89e4a",
        interId: "",
        boxId: "24371edd20095ac33d149b28e407c474", //qq游戏特有的广告
        nativeId: ["", ""],
        moosnowAppId: "1110956792",
        version: "1.1.0",
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