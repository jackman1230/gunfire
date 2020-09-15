import PopUpView from "../PopUpView";
import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import WXFUI_freeView from "../../fui/Game/WXFUI_freeView";
import WXFUI_noVideoTips from "../../fui/Game/WXFUI_noVideoTips";
import { VideoData, VideoType, VideoInfo } from "../../Data/VideoData";
import WXFUI_showVideoView from "../../fui/Game/WXFUI_showVideoView";


export default class ShowVideoView extends PopUpView {

    public view: WXFUI_showVideoView;

    private videoData: VideoData;
    private itemData: any;
    private successFun: Function;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_showVideoView.createInstance();


    }
    public showView(s, c): void {
        super.showView(s, c);

    }

    public updateView(): void {
        this.view.m_queding.onClick(this, this.continueHandle);
        this.view.m_gou.selected = true;
    }


    private continueHandle(): void {
        if (this.view.m_gou.selected) {
            var video: VideoData = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_BOX, VideoInfo.VIDEOINFO_BOX);
            MooSnowSDK.showVideo(null, video, this.watchVideoSuccess.bind(this), this.watchVideoError.bind(this));
        } else {
            GameManager.instance.suspendGame();
            ViewManager.instance.hidePopUpView(this, false);
        }
    }

    private watchVideoSuccess(): void {
        ViewManager.instance.hidePopUpView(this, false);
        ViewManager.instance.clickChestView.clickSuccess();
    }

    private watchVideoError(): void {
        ViewManager.instance.hidePopUpView(this, false);
        ViewManager.instance.clickChestView.showVideoError();
    }

    public hideAllView(): void {
        super.hideAllView();
        this.view.m_queding.offClick(this, this.continueHandle);
    }

}