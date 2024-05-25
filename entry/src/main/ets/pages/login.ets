import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Login{
  login:boolean = true
  @State visible:boolean = false
  @State username: string = ''
  @State passwd: string = ''
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
        Row(){
            Button('注册')
              .backgroundColor('#F1F3F4')
              .fontColor('#409EFF')
              .onClick(()=>{
                router.replaceUrl({url:'pages/register'})
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
        .margin({top:'10%'})
        .onClick(()=>{
          router.replaceUrl({url:'pages/home'})
          if(this.username == 'admin'&&this.passwd == 'admin') {
            router.replaceUrl({url:'pages/home'})
          }
          else {
            this.passwd = ''
            promptAction.showToast({ message: '账号或密码错误' })
          }
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}