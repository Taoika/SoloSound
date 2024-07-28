import { Song } from '../model/SongClass'
import { getNextIndex, shuffleArray } from '../utils/getIndex'
import { media } from '@kit.MediaKit';
import { switchMusic } from '../utils/avPlayer'

// 毫秒转换为xx:xx格式的时间
const timeChange = (Milliseconds: number): string => {
  const seconds = Milliseconds / 1000
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = Math.round(seconds % 60);

  return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
}

@Preview
@Component
export struct MiniPlayer {
  @Consume songList: Song[];
  @Consume playingIndex: number;
  @Consume isRandom: boolean;
  @Consume avPlayer: media.AVPlayer | null;
  @Consume isPlay: boolean;
  @Consume playingList: number[];
  @Consume song: Song;
  @Consume duration: number;
  @Consume seekDoneTime: number;

  build() {
    Column() { // 播放控制 + 进度条
      Column() { // 进度条
        Progress({ value: this.seekDoneTime, total: this.duration, type: ProgressType.Linear })
          .height(1.5)
          .color('rgba(0, 0, 0, 0.7)')
          .margin({bottom: 10})
          .onClick(() => {

          })
        Row() {
          Text(timeChange(this.seekDoneTime))
            .fontSize(12)
          Text(timeChange(this.duration))
            .fontSize(12)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('78%')
      Row() {
        Row() {
          if(this.isRandom) { // 乱序播放
            Button() {
              Image($r('app.media.random'))
            }
            .width(20)
            .height(20)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.isRandom = false
              const now = this.playingList[this.playingIndex] // 实际歌单索引
              this.playingList = new Array(this.songList.length).fill(0).map((item: number, index) => index) // 顺序
              this.playingIndex = now
            })
          }
          else { // 顺序播放
            Button() {
              Image($r('app.media.order'))
            }
            .width(20)
            .height(20)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.isRandom = true
              const now = this.playingList[this.playingIndex] // 实际歌单索引
              this.playingList = shuffleArray(this.playingList)
              this.playingIndex = this.playingList.findIndex((item: number) => item === now)
            })
          }
          Button() { // 上一首
            Image($r('app.media.prev'))
          }
          .width(30)
          .height(30)
          .margin({left: 30})
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            const len = this.songList.length
            this.playingIndex = (this.playingIndex + len - 1) % len
            switchMusic(this.avPlayer!, this.songList[this.playingList[this.playingIndex]].url)
            this.isPlay = true
            this.song = this.songList[this.playingList[this.playingIndex]]
          })
          if(this.isPlay) {
            Button() { // 暂停
              Image($r('app.media.pause'))
                .width(58)
                .height(58)
            }
            .width(60)
            .height(60)
            .margin({left: 30, right: 30})
            .backgroundColor(Color.Transparent)
            .onClick(async () => {
              this.isPlay = false
              this.avPlayer?.pause()
            })
          } else {
            Button() { // 播放
              Image($r('app.media.play'))
                .width(50)
                .height(50)
            }
            .width(60)
            .height(60)
            .margin({left: 30, right: 30})
            .backgroundColor(Color.Transparent)
            .onClick(async () => {
              this.isPlay = true
              this.avPlayer?.play()
            })
          }
          Button() { // 下一首
            Image($r('app.media.prev'))
              .rotate({ x: 0, y: 1, z: 0, angle: 180 })
          }
          .width(30)
          .height(30)
          .margin({right: 30})
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.playingIndex = getNextIndex(this.songList.length, this.playingIndex)
            switchMusic(this.avPlayer!, this.songList[this.playingList[this.playingIndex]].url)
            this.isPlay = true
            this.song = this.songList[this.playingList[this.playingIndex]]
          })
          Button() { // 播放列表
            Image($r('app.media.list'))
          }
          .width(20)
          .height(20)
          .backgroundColor(Color.Transparent)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding({top: 40})
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}