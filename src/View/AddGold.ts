import WXFUI_addGold from "../fui/Game/WXFUI_addGold";
import { GoodsType } from "../Data/GameData";
import { GameManager } from "../Manager/GameManager";

export default class AddGold {
    public view: WXFUI_addGold;
    constructor() { }

    createView(goodsType: number, num: number, s: Laya.Sprite, isBox: boolean = false): void {
        this.view = fairygui.UIPackage.createObject("Game", "addGold") as WXFUI_addGold;
        this.view.m_icon.url = "";
        var n: number = num;
        if (isBox) {
            this.view.m_icon.url = "ui://Game/goods_" + goodsType;
            if (goodsType == GoodsType.GoodsType_MED) {
                n = 1;
            } else if (goodsType == GoodsType.GoodsType_MAC) {
                n = GameManager.instance.roleInfo.addMacNum;
            } else if (goodsType == GoodsType.GoodsType_RIF) {
                n = GameManager.instance.roleInfo.addRifNum;
            } else if (goodsType == GoodsType.GoodsType_GRE) {
                n = GameManager.instance.roleInfo.addBombNum;
            }
        }
        this.view.m_num.text = " + " + n;
        this.view.m_ani.play(Laya.Handler.create(this, this.dispose));
        s.addChild(this.view.displayObject);
    }

    private dispose(): void {
        if (this.view.parent) {
            this.view.parent.removeChild(this.view);
        }
        Laya.Pool.recover("addGold", this);
    }
}