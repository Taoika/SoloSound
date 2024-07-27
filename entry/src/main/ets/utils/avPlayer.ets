import { common } from '@kit.AbilityKit';
import { media } from '@kit.MediaKit';

export const getSrc = async (src: string) => { // 获取播放路径
  let context = getContext() as common.UIAbilityContext;
  let fileDescriptor = await context.resourceManager.getRawFd(src);
  let avFileDescriptor: media.AVFileDescriptor =
    { fd: fileDescriptor.fd, offset: fileDescriptor.offset, length: fileDescriptor.length };
  return avFileDescriptor
}

export const setSrc = async (avPlayer: media.AVPlayer, src: string) => { // 设置播放路径
  const avFileDescriptor = await getSrc(src)
  avPlayer!.fdSrc = avFileDescriptor; // initialized
}

export const switchMusic = async (avPlayer: media.AVPlayer, src: string) => { // 切换歌曲
  await avPlayer?.reset()
  await setSrc(avPlayer, src)
}