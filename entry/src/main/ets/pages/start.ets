import router from '@ohos.router';
import dataPreferences from '@ohos.data.preferences';
import { User } from '../common/Data';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Start {
  appName: string = '云瓶'
  inf: string = 'Smart Vase'

  onPageShow(){
    this.initConstants()
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

  // 初始化全局常量
  initConstants() {
    globalThis.userName = 'Narrao'
    globalThis.phone = '15924086862'
    globalThis.avatarUrl = "$r('app.media.ic_user_portrait')"
    globalThis.token = '123456'
    globalThis.plants = [
      {
        name:"牡丹花",
        description:"牡丹花是一种被广泛栽培的花卉，是中国的传统名花之一。",
        imageUrl:"$r('app.media.icon')",
        temperature:25,humidity:50,luminance:1000,
        history:[
          {time:'2021-08-01',temperature:25,humidity:50,luminance:1000},
          {time:'2021-08-02',temperature:26,humidity:51,luminance:1001},
          {time:'2021-08-03',temperature:27,humidity:52,luminance:1002},
          {time:'2021-08-04',temperature:28,humidity:53,luminance:1003},
          {time:'2021-08-05',temperature:29,humidity:54,luminance:1004},
          {time:'2021-08-06',temperature:30,humidity:55,luminance:1005},
          {time:'2021-08-07',temperature:31,humidity:56,luminance:1006},
          {time:'2021-08-08',temperature:32,humidity:57,luminance:1007},
          {time:'2021-08-09',temperature:33,humidity:58,luminance:1008},
          {time:'2021-08-10',temperature:34,humidity:59,luminance:1009},
          {time:'2021-08-11',temperature:35,humidity:60,luminance:1010},
          {time:'2021-08-12',temperature:36,humidity:61,luminance:1011},
          {time:'2021-08-13',temperature:37,humidity:62,luminance:1012},
          {time:'2021-08-14',temperature:38,humidity:63,luminance:1013},
          {time:'2021-08-15',temperature:39,humidity:64,luminance:1014},
          {time:'2021-08-16',temperature:40,humidity:65,luminance:1015},
          {time:'2021-08-17',temperature:41,humidity:66,luminance:1016},
          {time:'2021-08-18',temperature:42,humidity:67,luminance:1017},
          {time:'2021-08-19',temperature:43,humidity:68,luminance:1018},
          {time:'2021-08-20',temperature:44,humidity:69,luminance:1019}
        ]
      },
      {
        name:"仙人掌",
        description:"仙人掌是多肉植物的一种，属于仙人掌科，是一种多肉植物，原产于美洲。",
        imageUrl:"$r('app.media.icon')",
        temperature:25,humidity:50,luminance:1000,
        history:[
          {time:'2021-08-01',temperature:25,humidity:50,luminance:1000},
          {time:'2021-08-02',temperature:26,humidity:51,luminance:1001},
          {time:'2021-08-03',temperature:27,humidity:52,luminance:1002},
          {time:'2021-08-04',temperature:28,humidity:53,luminance:1003},
          {time:'2021-08-05',temperature:29,humidity:54,luminance:1004},
          {time:'2021-08-06',temperature:30,humidity:55,luminance:1005},
          {time:'2021-08-07',temperature:31,humidity:56,luminance:1006},
          {time:'2021-08-08',temperature:32,humidity:57,luminance:1007},
          {time:'2021-08-09',temperature:33,humidity:58,luminance:1008},
          {time:'2021-08-10',temperature:34,humidity:59,luminance:1009},
          {time:'2021-08-11',temperature:35,humidity:60,luminance:1010},
          {time:'2021-08-12',temperature:36,humidity:61,luminance:1011},
          {time:'2021-08-13',temperature:37,humidity:62,luminance:1012},
          {time:'2021-08-14',temperature:38,humidity:63,luminance:1013},
          {time:'2021-08-15',temperature:39,humidity:64,luminance:1014},
          {time:'2021-08-16',temperature:40,humidity:65,luminance:1015},
          {time:'2021-08-17',temperature:41,humidity:66,luminance:1016},
          {time:'2021-08-18',temperature:42,humidity:67,luminance:1017},
          {time:'2021-08-19',temperature:43,humidity:68,luminance:1018},
          {time:'2021-08-20',temperature:44,humidity:69,luminance:1019}
        ]
      }
    ]
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