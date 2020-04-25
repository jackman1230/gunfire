export class BackGroundView {

    private view: fui.Game.FUI_BackGround;

    constructor() { }

    public initView() {
        this.view = fairygui.UIPackage.createObject("Game", "BackGround") as fui.Game.FUI_BackGround;
    };


}