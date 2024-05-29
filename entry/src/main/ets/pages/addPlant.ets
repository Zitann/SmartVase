import BLE from '../common/BLE'
import wifi from '@ohos.wifi';
import Title from '../common/Title'
import http from '@ohos.net.http';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@CustomDialog
struct Dialog {
  controller: CustomDialogController
  // 双向绑定传值
  @Link ssid: string
  @Link password: string
  ble: BLE
  // 弹窗控制器，控制打开/关闭，必须传入，且名称必须为：controller

  // 弹窗中的按钮事件
  cancel: () => void
  confirm: () => void

  // 弹窗中的内容描述
  build() {
    Column() {
      Text("请输入WIFI密码")
        .fontSize(20).margin({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
        .width("100%")
      TextInput({
        placeholder: 'SSID',
        text: this.ssid
      })
        .width('80%')
        .onChange((value: string) => {
          this.ssid = value
        })
      TextInput({
        placeholder: 'Password',
        text: this.password
      })
        .width('80%')
        .onChange((value: string) => {
          this.password = value
        })
        .margin({top: 10, bottom: 10})
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black).width('25%')
        Button('确定')
          .onClick(() => {
            this.ble.SendData(this.ssid+','+this.password)
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Red).width('25%')
      }.margin({ bottom: 10 })
    }
  }
}

@CustomDialog
struct Dialog2 {
  controller: CustomDialogController
  @Link val: string
  confirm: (val:string)=>void
  ble: BLE
  build() {
    Column() {
      Text('请输入MAC地址').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({text:this.val})
        .width('80%')
        .onChange((value)=>{
          this.val = value
        })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('确认')
          .onClick(() => {
            console.log('jzt '+this.val.replace("MAC ", ""))
            this.ble.Connect(this.val.replace("MAC ", ""))
            this.controller.close()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

@Entry
@Component
struct AddPlant{
  @State ssid: string = ''
  @State password: string = ''
  @State mac: string = ''
  @State name: string = ''
  @State description: string = ''
  token: string = ''
  plantId: string = ''
  ble = new BLE()
  httpRequest:http.HttpRequest = http.createHttp();

  dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      ssid: $ssid,
      password: $password,
      ble: this.ble
    }),
    alignment: DialogAlignment.Center,
  })
  dialogController2: CustomDialogController = new CustomDialogController({
    builder: Dialog2({
      val: $mac,
      ble: this.ble
    }),
    alignment: DialogAlignment.Center,
  })

  guid() {
    return 'xxxxxxxx-xxxx'.replace(/[xy]/g, function (c) {
      var r = Math.random() * 16 | 0,
        v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }

  addPlant(){
    this.httpRequest.request("http://123.60.145.37:5000/plant/info",{
      method:http.RequestMethod.POST,
      header:{
        'Content-Type':'application/json',
        "Authorization": `Bearer ${this.token}`
      },
      extraData:{
        'name':this.name,
        'description':this.description,
        'image':'default.jpg',
        'id':this.plantId
      }
    },(err,data)=>{
      if(err){
        promptAction.showToast({ message: '网络错误' })
        promptAction.showToast({ message: err.message })
        return
      }else{
        let dataObj = JSON.parse(data.result as string)
        if(dataObj.code == 'SUCCESS') {
          promptAction.showToast({ message: '添加成功' })
          router.back()
        }else{
          promptAction.showToast({ message: '添加失败' })
        }
      }
    })
  }

  onPageShow(): void {
    this.ble.Check()
    let params = router.getParams() as { token: string }
    this.token = params.token
    this.plantId = this.guid()
  }

  build() {
    Column(){
      Title({ title: '添加植物' })
      Column() {
        TextInput({ text: this.name,placeholder: '请输入植物名称' })
          .fontSize(20)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .onChange((text) => {
            this.name = text
          })
        TextInput({ text: this.description,placeholder: '请输入植物描述' })
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .margin({ top: '3%' })
          .onChange((text) => {
            this.description = text
          })
        Row() {
          Button('设备')
            .fontSize(15)
            .width(80)
            .height(30)
            .margin({ top: '3%',left:'15%' })
            .onClick(() => {
              this.ble.GotoScanner(globalThis.context)
              // // this.ble.Connect("EC:64:C9:86:51:EA")
              this.dialogController2.open()
            })
          Blank()
          Button('配网')
            .fontSize(15)
            .width(80)
            .height(30)
            .margin({ top: '3%',right:'15%' })
            .onClick(() => {
              wifi.getLinkedInfo().then((info) => {
                this.ssid = info['ssid'].replace('"', '').replace('"', '')
                this.dialogController.open()
              })
            })
        }
        .width('100%')
        .height('5%')
        .margin({ top: '20%' })
        Button('添加')
          .fontSize(20)
          .width('75%')
          .height(30)
          .margin({ top: '15%' })
          .onClick(() => {
            this.addPlant()
            this.ble.SendData(this.plantId)
          })
      }
      .width('90%')
      .margin({ top: '5%' })
      .padding('5%')
      .height('35%')
      .border({ radius: 15 })
      .backgroundImage($r('app.media.flower'))
      .backgroundImageSize(ImageSize.Cover)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }
}