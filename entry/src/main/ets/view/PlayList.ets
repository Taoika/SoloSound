import { Song } from '../model/SongClass'
import { switchMusic } from '../utils/avPlayer'
import { media } from '@kit.MediaKit';

@Component
export struct PlayList {
  @Consume songList: Song[];
  @Consume playingIndex: number;
  @Consume playingList: number[];
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.songList, (item: Song, index: number) => {
            SongItem({ nowSong: item, index: index + 1})
          }, (item: Song, index: number) => `${index}`)
        }
        .width('100%')
        .padding(15)
        .alignItems(HorizontalAlign.Start)
      }
      .padding({bottom: 40})
      .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(5) // 滚动条宽度
      .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
    }
    .height('100%')
    .padding({bottom: 40, top: 5})
  }
}

@Component
struct SongItem  {
  @Prop nowSong: Song;
  @Prop index: number; // 在歌单列表中的顺序
  @Consume playingIndex: number;
  @Consume playingList: number[];
  @Consume avPlayer: media.AVPlayer | null;
  @Consume songList: Song[];
  @Consume isPlay: boolean;
  @Consume song: Song;

  build() {
    Row() {
      Text(`${this.index}`)
        .margin({left: 25, right: 40})
        .fontSize(20)
      Column() {
        Text(this.nowSong.title)
          .fontSize(18)
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .width('50%')
        Text(this.nowSong.singer)
          .fontSize(15)
          .fontColor('rgba(0, 0, 0, 0.5)')
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .width('50%')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .margin({bottom: 10})
    .padding({top: 5, bottom: 5})
    .borderRadius(10)
    .backgroundColor(`rgba(0, 0, 0, ${this.index === this.playingList[this.playingIndex] + 1 ? 0.1 : 0})`) // 选中歌曲颜色变化
    .onClick(async () => {
      const now = this.index - 1
      this.playingIndex = this.playingList.findIndex((item: number) => item === now) // 此歌曲在播放列表的位置
      await switchMusic(this.avPlayer!, this.songList[now].url)
      this.avPlayer?.play()
      this.isPlay = true;
      this.song = this.nowSong = this.songList[this.playingList[this.playingIndex]]
    })
  }
}