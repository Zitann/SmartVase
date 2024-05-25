import Title from '../common/Title'
import router from '@ohos.router'

@CustomDialog
struct Dialog {
  controller: CustomDialogController
  item: string
  @Link val: string
  confirm
  temp:string
  build() {
    Column() {
      Text('修改'+this.item).fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({text:this.val})
        .width('80%')
        .onChange((value)=>{
          this.temp = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            this.val = this.temp
            this.controller.close()
            this.confirm(this.item,this.val)
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}


@Entry
@Component
export default struct Account{
  @State userName: string = 'Narrao'
  @State phone: string = '15924086862'
  userName_dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      item:'用户名',
      val:$userName,
      confirm:this.onAccept
    }),
    alignment: DialogAlignment.Center,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
  })
  phone_dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      item:'手机号',
      val:$phone,
      confirm:this.onAccept
    }),
    alignment: DialogAlignment.Center,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
  })

  onAccept(item:string,val:string) {
    console.info('Callback when the second button is clicked')
    switch (item) {
      case '用户名':
        globalThis.userName = val
        break;
      case '手机号':
        globalThis.phone = val
        break;
      default:
        break;
    }
  }
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
              .fillColor(Color.Gray)
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
            Text(this.userName)
              .fontColor(Color.Gray)
            Image($r('app.media.ic_public_arrow_right'))
              .width('7%')
              .fillColor(Color.Gray)
          }
        }
        .width('100%')
        // .backgroundColor(Color.Red)
        .padding({ left:'5%',top:'5%',bottom:'5%' })
        .justifyContent(FlexAlign.SpaceBetween)
        .onClick(() => {
          this.userName_dialogController.open()
          console.info('jzt1'+globalThis.name)
        })
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
            Text(this.phone)
              .fontColor(Color.Gray)
            Image($r('app.media.ic_public_arrow_right'))
              .width('7%')
              .fillColor(Color.Gray)
          }
        }
        .width('100%')
        // .backgroundColor(Color.Red)
        .padding({ left:'5%',top:'5%',bottom:'5%' })
        .justifyContent(FlexAlign.SpaceBetween)
        .onClick(() => {
          this.phone_dialogController.open()
          console.info('jzt1'+globalThis.name)
        })
      }
      .justifyContent(FlexAlign.Start)
      .backgroundColor(Color.White)
      .width('90%')
      .margin({top:'5%'})
      .border({radius:15})
      Button('退出登录')
        .width('50%')
        .margin({ top: '80%' })
        .backgroundColor(Color.Red)
        .onClick(() => {
          router.replaceUrl({ url: 'pages/login'})
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }
}
