import { media } from '@kit.MediaKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class AVPlayer {
  setAVPlayerCallback(avPlayer: media.AVPlayer) {
    avPlayer.on('error', (err: BusinessError) => {
      console.error(`激活avPlayer失败, 失败码为 ${err.code}, 报错信息如下 ${err.message}`);
      console.info("开始重置")
      avPlayer.reset(); // 调用reset重置资源，触发idle状态
    })
    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle':
          console.info('idle 状态触发');
          avPlayer.release();
          break;
        case 'initialized':
          console.info('initialized 状态触发');
          avPlayer.prepare();
          break;
        case 'prepared':
          console.info('prepared 状态触发');
          avPlayer.play();
          break;
        case 'playing':
          console.info('playing 状态触发');
          break;
        case 'paused':
          console.info('paused 状态触发');
          break;
        case 'completed':
          console.info('completed 状态触发');
          avPlayer.stop();
          break;
        case 'stopped':
          console.info('stopped 状态触发');
          avPlayer.reset();
          break;
        case 'released':
          console.info('released 状态触发');
          break;
        default:
          console.info('未知 状态触发');
          break;
      }
    })
  }

  async avPlayerFdSrc() {
    let avPlayer: media.AVPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(avPlayer);
    let context = getContext(this) as common.UIAbilityContext;
    let fileDescriptor = await context.resourceManager.getRawFd('aSong.m4a');
    let avFileDescriptor: media.AVFileDescriptor =
      { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
    avPlayer.fdSrc = avFileDescriptor;
  }
}

@Component
export struct MiniPlayer {
  private avPlayer: AVPlayer = new AVPlayer()
  build() {
    Column() { // 播放控制 + 进度条
      Column() { // 进度条

      }
      .width('78%')
      .border({
        width: {top: 1},
      })
      Row() {
        Row() {
          Button() { // 顺序播放
            Image($r('app.media.order'))
          }
          .width(20)
          .height(20)
          .backgroundColor(Color.Transparent)
          Button() { // 上一首
            Image($r('app.media.prev'))
          }
          .width(30)
          .height(30)
          .margin({left: 30})
          .backgroundColor(Color.Transparent)
          Button() { // 播放/暂停
            Image($r('app.media.play'))
          }
          .width(50)
          .height(50)
          .margin({left: 30, right: 30})
          .backgroundColor(Color.Transparent)
          .onClick(async () => {
            this.avPlayer.avPlayerFdSrc()
          })
          Button() { // 下一首
            Image($r('app.media.prev'))
              .rotate({ x: 0, y: 1, z: 0, angle: 180 })
          }
          .width(30)
          .height(30)
          .margin({right: 30})
          .backgroundColor(Color.Transparent)
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