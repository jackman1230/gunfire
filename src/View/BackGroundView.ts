
import WXFUI_BackGround from "../fui/Game/WXFUI_BackGround";

export class BackGroundView {

    public view: WXFUI_BackGround;

    private bg: fairygui.GLoader;

    constructor() { }

    public initView() {
        this.view = fairygui.UIPackage.createObject("Game", "BackGround") as WXFUI_BackGround;
        this.bg = this.view.getChildAt(0) as fairygui.GLoader;
        this.bg.url = "res/map_1.jpg";
        

    };


}