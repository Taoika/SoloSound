@Component
export struct UserInfo { // 用户信息
  build() {
    Row() {
      Image($r('app.media.avatar'))
        .height(50)
        .width(50)
        .borderRadius(25)
        .margin(15)
      Column() {
        Text('TaoikaTaoikaTaoikaTaoikaTaoikaTaoikaTaoika') // 用户名
          .width(100)
          .fontSize(18)
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
        Text('TaoikaBiuBiuBiuTaoikaBiuBiuBiuTaoikaBiuBiuBiuTaoikaBiuBiuBiuTaoikaBiuBiuBiu') // 个签
          .width(200)
          .fontSize(10)
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
      }
      .width('100%')
      .height(50)
      .padding({left: 12})
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
    .border({
      width: { bottom: 1 },
      color: { bottom: 'rgba(0, 0, 0, 0.1)'}
    })
    .justifyContent(FlexAlign.Center)
  }
}