import { MiniPlayer } from './MiniPlayer'
import { Song } from '../model/SongClass'

@Preview
@Component
export struct Player {
  @Consume song: Song;

  build() {
    Grid() {
      GridItem() { // 专辑封面
        Image($r(this.song.coverUrl))
          .width('80%')
          .borderRadius(10)
      }
      .width('100%')
      .height('100%')
      GridItem() { // 歌名 + 歌手 + 专辑
        Column() {
          Text(this.song.title)
            .fontSize(30)
            .fontWeight(700)
            .margin({bottom: 20})
            .width('100%')
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis})
          Text(this.song.singer)
            .fontSize(20)
            .width('100%')
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis})
          Text(this.song.album)
            .width('100%')
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis})
        }
        .width('80%')
      }
      .width('100%')
      .height('100%')
      GridItem() { // 迷你播放器
        MiniPlayer()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .rowsTemplate('2fr 1fr 1fr')
  }
}