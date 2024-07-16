export class Song { // 歌曲类
  title: string = '';
  singer: string = '';
  album: string = '';
  coverUrl: string = ''
  url: string = ''
  constructor(title: string, singer: string, album: string, coverUrl: string, url: string) {
    this.title = title
    this.singer = singer
    this.album = album
    this.coverUrl = coverUrl
    this.url = url
  }
}