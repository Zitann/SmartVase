import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import http from '@ohos.net.http';
import { User } from '../common/Data';
import dataPreferences from '@ohos.data.preferences';

@Entry
@Component
struct Register {
  @State username: string = ''
  @State phone: string = ''
  @State passwd: string = ''
  @State passwd2: string = ''
  httpRequest:http.HttpRequest = http.createHttp();
  build(){
    Column(){
      Image($r('app.media.icon'))
        .width('25%')
        .margin({top:'45%'})
      Text('注册')
        .fontWeight(FontWeight.Bold)
        .fontSize('30vp')
        .margin({top:'10%'})
      Row(){
        Image($r('app.media.ic_public_contacts'))
          .height('3%')
          .margin({left:'3%'})
        TextInput({placeholder:'请输入用户名',text:this.username})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .onChange((s:string)=>{
            this.username = s
          })
      }
      .margin({top:'10%'})
      .width('80%')
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor(Color.White)
      .border({radius:15})
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
      .margin({top:'5%'})
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
        Image($r('app.media.ic_public_lock'))
          .height('3%')
          .margin({left:'3%'})
        TextInput({placeholder:"请再次输入密码",text:this.passwd2})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .type(InputType.Password)
          .onChange((s:string)=>{
            this.passwd2 = s
          })
      }
      .width('80%')
      .margin({top:'5%'})
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor(Color.White)
      .border({radius:15})

      Button('注册')
        .width('50%')
        .height(40)
        .margin({top:'10%'})
        .onClick(()=>{
            if(this.username == '' || this.phone == '' || this.passwd == '' || this.passwd2 == ''){
              promptAction.showToast({ message:'请填写完整信息' })
              return
            }else if(this.passwd != this.passwd2){
              promptAction.showToast({ message:'两次密码不一致' })
              return
            }else {
              this.httpRequest.request('http://123.60.145.37:5000/user/register',{
                method:http.RequestMethod.POST,
                extraData:{
                  username:this.username.toString(),
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
                  promptAction.showToast({ message:'注册成功' })
                  let user = new User(dataObj.data.user.username,dataObj.data.user.phone,dataObj.data.user.avatar,dataObj.data.token)
                  console.log(JSON.stringify(user))
                  dataPreferences.getPreferences(globalThis.context,'SmartVase').then((preferences)=>{
                    preferences.put('user',JSON.stringify(user)).then(()=>{
                      preferences.flush().then(()=>{
                        console.log('jzt flush success')
                        router.replaceUrl({url:'pages/home',params:user})
                      })
                    })
                  })
                }
                else {
                  promptAction.showToast({ message: '注册失败' })
                }
              })
            }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}