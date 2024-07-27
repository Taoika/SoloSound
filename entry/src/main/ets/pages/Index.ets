import { UserInfo } from '../view/UserInfo'
import { MiniPlayer } from '../view/MiniPlayer'
import { PlayList } from '../view/PlayList'
import { Song } from '../model/SongClass'
import { media } from '@kit.MediaKit';
import { Player } from '../view/Player'
import { BusinessError } from '@kit.BasicServicesKit';
import { switchMusic, setSrc } from '../utils/avPlayer'
import { getNextIndex } from '../utils/getIndex'

@Entry
@Component
struct Index {
  @Provide isRandom: boolean = false;
  @Provide songList: Song[] = [ // 歌单数组
    new Song('一个旅人', '陈奕迅', 'H3M', 'app.media.aCover', 'aSong.m4a'),
    new Song('秒針を噛む', 'ずっと真夜中でいいのに。', '秒針を噛む', 'app.media.bCover', 'bSong.m4a'),
    new Song('ハートビート・フロムユー', 'ゆいこんぬ', 'ハートビート・フロムユー', 'app.media.cCover', 'cSong.m4a'),
    new Song('Tom And Jerry', 'Banda Sinfonica Nacional De Ucrania', 'Musica Universal Vol 2', 'app.media.dCover', 'dSong.m4a'),
    new Song('不法侵入', 'ずっと真夜中でいいのに。', '不法侵入', 'app.media.eCover', 'eSong.m4a'),
    new Song('无论你多怪异我还是会喜欢你', '周子琰', '刺客伍六七 动画歌曲OST', 'app.media.fCover', 'fSong.m4a'),
    new Song('君はロックを聴かない', '爱缪', '君はロックを聴かない', 'app.media.gCover', 'gSong.m4a'),
    new Song('なにが悪い', '結束バンド', 'なにが悪い', 'app.media.hCover', 'hSong.m4a'),
    new Song('山楂树の恋', '程佳佳', '山楂树の恋', 'app.media.iCover', 'iSong.m4a'),
  ]
  @Provide playingIndex: number = 0; // 播放索引
  @Provide playingList: number[] = new Array(this.songList.length).fill(0).map((item: number, index) => index) // 播放顺序数组
  @Provide avPlayer: media.AVPlayer | null = null;
  @Provide isPlay: boolean = false
  @Provide song: Song = this.songList[this.playingList[this.playingIndex]]
  private isInit: Boolean= true;

  // build()执行完成后
  async onDidBuild() {
    this.avPlayer = await media.createAVPlayer()
    this.avPlayer.on('error', (err: BusinessError) => { // 监听错误
      console.error(`激活avPlayer失败, 失败码为 ${err.code}, 报错信息如下 ${err.message}`);
      console.info("开始重置")
      this.avPlayer!.reset(); // 调用reset重置资源，触发idle状态
    })
    this.avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => { // 监听状态
      switch (state) {
        case 'idle':
          console.info('idle 状态触发');
          break;
        case 'initialized':
          console.info('initialized 状态触发');
          this.avPlayer!.prepare();
          break;
        case 'prepared':
          console.info('prepared 状态触发');
          if(!this.isInit) {
            this.avPlayer!.play()
          }
          this.isInit = false
          break;
        case 'playing':
          console.info('playing 状态触发');
          break;
        case 'paused':
          console.info('paused 状态触发');
          break;
        case 'completed':
          console.info('completed 状态触发');
          this.playingIndex = getNextIndex(this.songList.length, this.playingIndex)
          switchMusic(this.avPlayer!, this.songList[this.playingList[this.playingIndex]].url)
          this.song = this.songList[this.playingList[this.playingIndex]]
          break;
        case 'stopped':
          console.info('stopped 状态触发');
          this.avPlayer!.reset();
          break;
        case 'released':
          console.info('released 状态触发');
          break;
        default:
          console.info('未知 状态触发');
          break;
      }
    })
    setSrc(this.avPlayer, this.songList[this.playingIndex].url)
  }

  build() {
    Navigation() {
      Column() {
        Grid() {
          GridItem() {
            UserInfo() // 用户资料
          }
          GridItem() {
            PlayList() // 歌曲列表
          }
          GridItem() {
            NavRouter() {
              MiniPlayer() // 导航点
              NavDestination() { // 子组件
                Player()
              }
            }
          }
        }
        .height('100%')
        .width('100%')
        .padding({top: 50})
        .rowsTemplate('0.5fr 2.5fr 1fr')
        .backgroundImage($r('app.media.avatar'))
        .backgroundImageSize(ImageSize.Cover)
      }
    }
    .height('100%')
    .width('100%')
    .hideToolBar(true)
    .hideTitleBar(true)
  }
}

