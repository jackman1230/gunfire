import { GameData } from "../Data/GameData";

export class SoundManager {
    private static _instance: SoundManager;
    private isOpenSound: boolean = true;
    private bgm: Laya.SoundChannel;

    public static get instance(): SoundManager {
        if (this._instance == null) {
            this._instance = new SoundManager();
            Laya.SoundManager.useAudioMusic = false;
        }
        return this._instance;
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
        var s: string = "res/sound/" + name + ".mp3";
        this.bgm = Laya.SoundManager.playMusic(s);
    }

    public stopBGM(): void {
        Laya.SoundManager.stopMusic();

    }

    public offSound(): void {
        this.isOpenSound = !this.isOpenSound;
        if (this.isOpenSound) {
            // Laya.SoundManager.setMusicVolume(1);
            // Laya.SoundManager.setSoundVolume(1);
            Laya.SoundManager.soundMuted = false;
            Laya.SoundManager.musicMuted = false;
        } else {
            Laya.SoundManager.musicMuted = true;
            Laya.SoundManager.soundMuted = true;
            // Laya.SoundManager.setMusicVolume(0);
            // Laya.SoundManager.setSoundVolume(0);
            // this.bgm.volume = 0.5;
        }
    }
}