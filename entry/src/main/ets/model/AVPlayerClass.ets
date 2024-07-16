import { media } from '@kit.MediaKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class AVPlayer {
  // 注册avplayer回调函数
  setAVPlayerCallback(avPlayer: media.AVPlayer) {
    // error回调监听函数,当avPlayer在操作过程中出现错误时调用 reset接口触发重置流程
    avPlayer.on('error', (err: BusinessError) => {
      console.error(`激活avPlayer失败, 失败码为 ${err.code}, 报错信息如下 ${err.message}`);
      console.info("开始重置")
      avPlayer.reset(); // 调用reset重置资源，触发idle状态
    })
    // 状态机变化回调函数
    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          console.info('idle 状态触发');
          avPlayer.release(); // 调用release接口销毁实例对象
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('initialized 状态触发');
          avPlayer.prepare();
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('prepared 状态触发');
          avPlayer.play(); // 调用播放接口开始播放
          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('playing 状态触发');
          avPlayer.pause(); // 调用暂停接口暂停播放
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('paused 状态触发');
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('completed 状态触发');
          avPlayer.stop(); //调用播放结束接口
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('stopped 状态触发');
          avPlayer.reset(); // 调用reset接口初始化avplayer状态
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

  // 以下demo为使用资源管理接口获取打包在HAP内的媒体资源文件并通过fdSrc属性进行播放示例
  async avPlayerFdSrc() {
    // 创建avPlayer实例对象
    console.info("创建AVPlayer")
    let avPlayer: media.AVPlayer = await media.createAVPlayer();
    // 创建状态机变化回调函数
    this.setAVPlayerCallback(avPlayer);
    // 通过UIAbilityContext的resourceManager成员的getRawFd接口获取媒体资源播放地址
    // 返回类型为{fd,offset,length},fd为HAP包fd地址，offset为媒体资源偏移量，length为播放长度
    let context = getContext(this) as common.UIAbilityContext;
    console.info("获取音频文件资源")
    let fileDescriptor = await context.resourceManager.getRawFd('aSong.m4a');
    let avFileDescriptor: media.AVFileDescriptor =
      { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
    // 为fdSrc赋值触发initialized状态机上报
    avPlayer.fdSrc = avFileDescriptor;
  }
}