import { UserInfo } from '../view/UserInfo'
import { Player } from '../view/Player'
import { MiniPlayer } from '../view/MiniPlayer'
import { PlayList } from '../view/PlayList'

@Entry
@Component
struct Index {

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

