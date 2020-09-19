import { GameData } from "../Data/GameData";

export class SoundManager {
    private static _instance: SoundManager;
    public isOpenSound: boolean = true;
    public bgm: Laya.SoundChannel;
    public bgmName: string = "";

    public static get instance(): SoundManager {
        if (this._instance == null) {
            this._instance = new SoundManager();
            Laya.SoundManager.useAudioMusic = false;
        }
        return this._instance;
    }

    // public addVisibleEvent(): void {
    //     // Laya.stage.on(Laya.Event.FOCUS_CHANGE, this, this.playLastBgm)
    //     if (Laya.Browser.onWeiXin) {
    //         window["wx"].onShow(function () {
    //             if (SoundManager.instance.bgm && SoundManager.instance.isOpenSound)
    //                 SoundManager.instance.bgm.play();
    //         })
    //     }
    // }

    private playLastBgm(): void {
        if (Laya.stage.isFocused) {
            if (this.bgmName) {
                if (this.isOpenSound) {
                    Laya.SoundManager.soundMuted = false;
                    Laya.SoundManager.musicMuted = false;
                    this.bgm = Laya.SoundManager.playMusic(this.bgmName);
                }
            }
        } else {
            console.log("Laya.stage.isFocused", Laya.stage.isFocused);
        }
    }


    public playSound(n: string) {
        if (!this.isOpenSound) return;
        var s: string = GameData.SOUND_FONT + n + ".mp3";
        // if (Laya.Browser.onWeiXin) {
        //     var audio: any = wx.createInnerAudioContext();
        //     audio.src = s;
        //     audio.play();
        //     audio.obeyMuteSwitch = true; //遵循系统静音开关
        // } else {
        Laya.SoundManager.playSound(s);
        // }
    }
    public playBGM(name: string): void {
        var s: string = "sound/" + name + ".mp3";
        this.bgmName = name;
        // var sound: Laya.SoundChannel = 
        Laya.SoundManager.playMusic(s);
    }

    public stopBGM(): void {
        Laya.SoundManager.stopMusic();
    }


    public offSound(): void {
        this.isOpenSound = false;
        Laya.SoundManager.soundMuted = true;
        Laya.SoundManager.musicMuted = true;

    }

    public openSound(): void {
        this.isOpenSound = true;
        Laya.SoundManager.soundMuted = false;
        Laya.SoundManager.musicMuted = false;

    }


}