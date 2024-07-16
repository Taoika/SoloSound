import { Song } from '../model/SongClass'

import { media } from '@kit.MediaKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct PlayList {
  @State songList: Song[] = [
    new Song('一个旅人一个旅人一个旅人一个旅人一个旅人一个旅人', '陈奕迅陈奕迅陈奕迅陈奕迅陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.cover', 'app.aSong'),
  ]
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.songList, (item: Song, index: number) => {
            SongItem({ song: item, index: index + 1})
          }, (item: Song, index: number) => `${index}`)
        }
        .width('100%')
        .padding(15)
        .alignItems(HorizontalAlign.Start)
      }
      .padding({bottom: 40})
      .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向
      .scrollBar(BarState.On) // 滚动条常驻显示
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度
      .edgeEffect(EdgeEffect.Spring) // 滚动到边沿后回弹
    }
    .height('100%')
    .padding({bottom: 40, top: 5})
  }
}

@Component
struct SongItem  {
  @Prop song: Song;
  @Prop index: number;

  build() {
    Row() {
      Text(`${this.index}`)
        .margin({left: 25, right: 40})
        .fontSize(20)
      Column() {
        Text(this.song.title)
          .fontSize(18)
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .width('50%')
        Text(this.song.singer)
          .fontSize(15)
          .fontColor('rgba(0, 0, 0, 0.5)')
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .width('50%')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .margin({bottom: 15})
  }
}