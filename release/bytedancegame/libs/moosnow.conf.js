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
        bannerId: "24ed1lm552051196jd",
        videoId: "24o39cpglob96bf1aa",
        interId: "168777",
        nativeId: ["168779", "168780"],
        moosnowAppId: "tt82d6f46b1ded0f70",
        version: "1.1.0",
    },
    vivo: {
        bannerId: "8574385fdbbc4ac9ad21d63ca2f6d34f",
        videoId: "4587d538ceca43f4a9b4708a2265880a",
        interId: "168777",
        nativeId: ["d734a0de426e4f0db0447aa596e7cb75"],
        moosnowAppId: "100009190",
        version: "1.0.0",
    }
}