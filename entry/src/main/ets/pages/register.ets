import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Register {
  login:boolean = true
  @State visible:boolean = false
  @State username: string = ''
  @State passwd: string = ''
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
        Image($r('app.media.ic_public_contacts'))
          .height('3%')
          .margin({left:'3%'})
        TextInput({placeholder:'请输入手机号',text:this.username})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .onChange((s:string)=>{
            this.username = s
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
          .type(this.visible?InputType.Normal:InputType.Password)
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
        TextInput({placeholder:"请再次输入密码",text:this.passwd})
          .height('6%')
          .width('90%')
          .backgroundColor(Color.White)
          .type(this.visible?InputType.Normal:InputType.Password)
          .onChange((s:string)=>{
            this.passwd = s
          })
      }
      .width('80%')
      .margin({top:'5%'})
      .justifyContent(FlexAlign.SpaceAround)
      .backgroundColor(Color.White)
      .border({radius:15})

      Button('注册')
        .width('50%')
        .margin({top:'10%'})
        .onClick(()=>{
            router.replaceUrl({url:'pages/home'})
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}