import Title from '../common/Title'
import router from '@ohos.router'
import dataPreferences from '@ohos.data.preferences';
import { User } from '../common/Data';

@Component
export default struct Account{
  @Link user: User

  build(){
    Column(){
      Title({title:'个人中心'})
      Row()
      {
        Text('头像')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
         Row(){
            Image($r('app.media.ic_user_portrait'))
              .width('15%')
            Image($r('app.media.ic_public_arrow_right'))
              .width('7%')
              .fillColor(Color.White)
         }
      }
      .width('90%')
      .backgroundColor(Color.White)
      .padding({ left:'5%',top:'3%',bottom:'3%' })
      .margin({top:'5%'})
      .border({radius:15})
      .justifyContent(FlexAlign.SpaceBetween)
      Column(){
        Row()
        {
          Text('用户名')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Row(){
            Text(this.user.userName??"undefined")
              .fontColor(Color.Gray)
            Image($r('app.media.ic_public_arrow_right'))
              .width('7%')
              .fillColor(Color.White)
          }
        }
        .width('100%')
        // .backgroundColor(Color.Red)
        .padding({ left:'5%',top:'5%',bottom:'5%' })
        .justifyContent(FlexAlign.SpaceBetween)

        Row()
          .width('90%')
          .height(1)
          .backgroundColor('#F1F3F5')
        Row()
        {
          Text('手机号')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Row(){
            Text(this.user.phone)
              .fontColor(Color.Gray)
            Image($r('app.media.ic_public_arrow_right'))
              .width('7%')
              .fillColor(Color.White)
          }
        }
        .width('100%')
        // .backgroundColor(Color.Red)
        .padding({ left:'5%',top:'5%',bottom:'5%' })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .justifyContent(FlexAlign.Start)
      .backgroundColor(Color.White)
      .width('90%')
      .margin({top:'5%'})
      .border({radius:15})
      Button('退出登录')
        .width('50%')
        .height(40)
        .margin({ top: '80%' })
        .backgroundColor(Color.Red)
        .onClick(() => {
          dataPreferences.getPreferences(globalThis.context,'SmartVase').then((preferences) => {
            preferences.clear().then((result) => {
              console.info('清除成功')
              preferences.flush().then((result) => {
                console.info('flush成功')
                router.replaceUrl({ url: 'pages/login'})
              }).catch((error) => {
                console.info('flush失败')
              })
            }).catch((error) => {
              console.info('清除失败')
            })
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }
}
