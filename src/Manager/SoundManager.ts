import { GameData } from "../Data/GameData";

export class SoundManager {
    private static _instance: SoundManager;
    private isOpenSound: boolean = true;

    public static get instance(): SoundManager {
        if (this._instance == null) {
            this._instance = new SoundManager();
            Laya.SoundManager.useAudioMusic = false;
        }
        return this._instance;
    }
    public playSound(n: string) {
        var s: string = GameData.SOUND_FONT + n + ".mp3";
        Laya.SoundManager.playSound(s);
    }
    public playBGM(): void {
        Laya.SoundManager.playMusic("res/sound/bgm.mp3");
    }

    public offSound(): void {
        this.isOpenSound = !this.isOpenSound;
        if (this.isOpenSound) {
            Laya.SoundManager.setMusicVolume(1);
            Laya.SoundManager.setSoundVolume(1);
        } else {
            Laya.SoundManager.setMusicVolume(0);
            Laya.SoundManager.setSoundVolume(0);
        }
    }
}