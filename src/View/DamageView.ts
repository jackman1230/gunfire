import WXFUI_damageView from "../fui/Game/WXFUI_damageView";

export default class DamageView {
    public view: WXFUI_damageView;
    constructor() { }

    createView(damage: number, s: Laya.Sprite): void {
        this.view = fairygui.UIPackage.createObject("Game", "damageView") as WXFUI_damageView;
        this.view.m_num.text = " - " + damage * 5;
        this.view.m_ani.play(Laya.Handler.create(this, this.dispose));
        s.addChild(this.view.displayObject);
    }

    private dispose(): void {
        if (this.view.parent) {
            this.view.parent.removeChild(this.view);
        }
        Laya.Pool.recover("damageView", this);
    }
}