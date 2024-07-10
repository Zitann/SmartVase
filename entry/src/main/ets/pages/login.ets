import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import http from '@ohos.net.http';
import {User} from '../common/Data';
import dataPreferences from '@ohos.data.preferences';

@Entry
@Component
struct Login{
  login:boolean = true
  @State phone: string = '123'
  @State passwd: string = 'admin'
  httpRequest:http.HttpRequest = http.createHttp();
  build(){
    Column(){
      Image($r('app.media.icon'))
        .width('25%')
        .margin({top:'45%'})
      Text('登录')
        .fontWeight(FontWeight.Bold)
        .fontSize('30vp')
        .margin({top:'10%'})
      Row(){
        Image($r('app.media.ic_public_phone'))
          .height('3%')
          .margin({left:'3%'})
        TextInput({placeholder:'请输入手机号',text:this.phone})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .type(InputType.PhoneNumber)
          .onChange((s:string)=>{
            this.phone = s
          })
      }
      .margin({top:'10%'})
      .width('80%')
      .justifyContent(FlexAlign.SpaceAround)
          .backgroundColor(Color.White)
      .border({radius:15})

      Row(){
        Image($r('app.media.ic_public_lock'))
          .height('3%')
          .margin({left:'3%'})
        TextInput({placeholder:"请输入密码",text:this.passwd})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .type(InputType.Password)
          .onChange((s:string)=>{
            this.passwd = s
          })
      }
      .width('80%')
      .margin({top:'5%'})
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor(Color.White)
      .border({radius:15})
      Row(){
        Row(){
            Button('注册')
              .backgroundColor('#F1F3F4')
              .fontColor('#409EFF')
              .onClick(()=>{
                router.pushUrl({url:'pages/register'})
              })
          }
        Text('忘记密码？')
          .fontColor('#409EFF')
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('80%')
      .margin({top:'5%'})
      Button('登录')
        .width('50%')
        .height(40)
        .margin({top:'10%'})
        .onClick(()=>{
          if(this.phone == '' || this.passwd == '') {
            promptAction.showToast({ message: '账号或密码为空' })
            return
          }
          this.httpRequest.request('http://123.60.145.37:5000/user/login',{
            method:http.RequestMethod.POST,
            extraData:{
              phone:this.phone.toString(),
              password:this.passwd.toString()
            }
          },(err, data) => {
            if(err) {
              promptAction.showToast({ message: '网络错误' })
              promptAction.showToast({ message: err.message })
              return
            }
            let dataObj = JSON.parse(data.result as string)
            if(dataObj.code == 'SUCCESS') {
              console.log('plant login success')
              let user = new User(dataObj.data.user.username,dataObj.data.user.phone,dataObj.data.user.avatar,dataObj.data.token)
              console.log(JSON.stringify(user))
              dataPreferences.getPreferences(globalThis.context,'SmartVase').then((preferences)=>{
                preferences.put('user',JSON.stringify(user)).then(()=>{
                  preferences.flush().then(()=>{
                    console.log('plant preferences flush success')
                    router.replaceUrl({url:'pages/home',params:user})
                  })
                })
              })
            }
            else {
              promptAction.showToast({ message: '账号或密码错误' })
              this.passwd = ''
            }
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}