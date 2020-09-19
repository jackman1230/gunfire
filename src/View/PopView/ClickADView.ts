// import PopUpView from "../PopUpView";
// import { SoundManager } from "../../Manager/SoundManager";
// import { EventManager } from "../../Manager/EventManager";
// import GameEvent from "../../Control/GameEvent";
// import { GoodsType } from "../../Data/GameData";
// import { GameManager } from "../../Manager/GameManager";
// import { ViewManager } from "../../Manager/ViewManager";
// import { MooSnowSDK } from "../../Manager/MooSnowSDK";
// import WXFUI_ClickADView from "../../fui/Game/WXFUI_ClickADView";



// export default class ClickADView extends PopUpView {

//     public view: WXFUI_ClickADView;

//     private timeOut: number = 0;
//     private clickTimeOut: number = 0;
//     private clickNum: number = 1;
//     private randomNum: number = 7;
//     private _isShow: boolean = false;

//     private viewType: number = 1;//1在进入游戏前，>1在游戏结算前

//     constructor() { super() }

//     createView(): void {
//         this.view = WXFUI_ClickADView.createInstance();
//     }

//     public updateView(type: number): void {
//         this.view.m_btn.onClick(this, this.clickBtn);
//         this.view.m_bar.value = 0;
//         this.view.m_finger.visible = true;
//         this.view.m_reward.visible = false;
//         this._isShow = false;
//         this.clickNum = 1;
//         this.view.m_hand.url = "ui://Game/hand" + Math.floor(this.clickNum);
//         this.randomNum = this.getBannerValue();

//         this.viewType = type;
//         moosnow.platform.hideAppBox();
//         MooSnowSDK.hideBanner();
//     }

//     public showReward(): void {
//         this.view.m_reward.visible = true;
//         this.view.m_reward.m_btn.onClick(this, this.hideRewardView);
//         GameManager.instance.buyGre += 10;
//     }

//     private addTimeOut(): void {
//         this.view.m_finger.visible = false;
//         clearInterval(this.timeOut);
//         this.timeOut = setInterval(() => {
//             this.decValue();
//         }, 200);

//     }

//     private clickBtn(): void {
//         SoundManager.instance.playSound("btn_click");
//         var v: number = this.getRandomValue();
//         this.view.m_bar.value += v;
//         this.addTimeOut();
//         this.clickNum++;
//         if (this.clickNum >= 6)
//             this.clickNum = 6;
//         this.view.m_hand.url = "ui://Game/hand" + Math.floor(this.clickNum);
//         if (this.view.m_bar.value >= 100) {
//             this.view.m_bar.value = 100;
//         }

//         if (this._isShow) return;
//         if (this.clickNum >= this.randomNum) {
//             if (this.viewType == 1) {
//                 console.log("showBanner--");
//                 MooSnowSDK.showBanner(true);
//             } else {
//                 console.log("showQQADBox--");
//                 MooSnowSDK.showQQADBox(true);
//             }
//             this._isShow = true;
//             clearInterval(this.timeOut);
//             clearTimeout(this.clickTimeOut);
//             this.clickTimeOut = setTimeout(() => {
//                 this.clickSuccess();
//             }, 3000);
//         }

//     }

//     private decValue(): void {
//         this.view.m_bar.value -= 5;
//         this.clickNum -= 0.2;
//         if (this.clickNum < 1) this.clickNum = 1;
//         this.view.m_hand.url = "ui://Game/hand" + Math.floor(this.clickNum);
//         if (this.view.m_bar.value <= 0)
//             this.view.m_bar.value = 0;
//         // this.view.m_bar.m_title.text = this.view.m_bar.value + "%";
//     }

//     public clickSuccess(): void {
//         this._isShow = true;
//         clearInterval(this.timeOut);
//         clearTimeout(this.clickTimeOut);
//         this.view.m_btn.offClick(this, this.clickBtn);
//         ViewManager.instance.hidePopUpView(ViewManager.instance.clickAdView);
//         if (this.viewType == 1) {
//             MooSnowSDK.hideBanner();
//             GameManager.instance.enterGame();
//         } else {
//             MooSnowSDK.hideQQADBox();
//         }
//     }

//     public hideAllView(): void {
//         super.hideAllView();
//         clearInterval(this.timeOut);
//         clearTimeout(this.clickTimeOut);
//         this.view.m_btn.offClick(this, this.clickBtn);
//     }

//     private hideRewardView(): void {
//         this.view.m_reward.m_btn.offClick(this, this.hideRewardView);
//     }

//     private getRandomValue(): number {
//         return Math.ceil(Math.random() * 5) + 15;
//     }

//     private getBannerValue(): number {
//         return Math.ceil(Math.random() * 2) + 2;
//     }


// }