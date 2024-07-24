import router from '@ohos.router';
import dataPreferences from '@ohos.data.preferences';
import { User } from '../common/Data';

@Entry
@Component
struct Start {
  appName: string = '云瓶'
  inf: string = 'Smart Vase'

  onPageShow(){
    try{
      dataPreferences.getPreferences(globalThis.context,'SmartVase').then((preferences) => {
        preferences.has('user').then((value) => {
          if(value == false){
            setTimeout(() => {
              router.replaceUrl({ url: 'pages/login' })
            }, 1000)
          }else{
            preferences.get('user',null).then((value) => {
              let user = JSON.parse(value as string) as User
              console.info('user:',JSON.stringify(user))
              setTimeout(() => {
                router.replaceUrl({ url: 'pages/home' ,params:user})
              }, 1000)
            })
          }
        })
      })
    }catch (e) {
      console.error('getPreferences error:', e)
    }
  }

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width('25%')
        .margin({top:'45%'})
      Column() {
        Text(this.appName)
          .fontSize('40vp')
          .fontWeight(FontWeight.Bold)
        Text(this.inf)
          .fontColor(Color.Gray)
      }
      .margin({ bottom: '25%' })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#F1F3F5")
  }
}