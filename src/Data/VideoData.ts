export class VideoData {
    public type: number = 0;//为什么观看视频
    public info: string = "";//观看视频获得奖励描述
    constructor() {
    }


}

export class VideoInfo {
    public static VIDEOINFO_ITEM: string = "看视频获得物资";
    public static VIDEOINFO_LIFE: string = "看视频原地复活";
    public static VIDEOINFO_DOUBLE_COIN: string = "看视频获得双倍金币";
    public static VIDEOINFO_BOX: string = "看视频获得宝箱奖励";
    public static VIDEOINFO_GOODS: string = "金币不够,看视频获得道具";
}

export class VideoType {
    public static VIDEOTYPE_ITEM: number = 1;
    public static VIDEOTYPE_LIFE: number = 2;
    public static VIDEOTYPE_DOUBLE_COIN: number = 3;
    public static VIDEOTYPE_BOX: number = 4;
    public static VIDEOTYPE_GOODS: number = 5;

}