import router from '@ohos.router';
import Title from '../common/Title'
import picker from '@ohos.file.picker';
import promptAction from '@ohos.promptAction';
import { historyT } from '../tabs/historyT';
import { historyH } from '../tabs/historyH';
import {historyI} from  '../tabs/historyI';
import BLE from '../common/BLE'
import wifi from '@ohos.wifi';
import { PlantData } from '../common/Data';
import http from '@ohos.net.http';

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
struct Information{
  @State ssid: string = ''
  @State password: string = ''
  @State mac: string = ''
  context = getContext(this)
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
  @State edit:boolean = false
  @State plant :PlantData = new PlantData()
  token = ''
  timeId = 0

  getPlant(index:number){
    this.httpRequest.request("http://10.134.48.122:2013/plant/list",{
      method:http.RequestMethod.GET,
      header: {
        "Authorization": `Bearer ${this.token}`
      }
    },(err,data)=>{
      if(err){
        promptAction.showToast({ message: '网络错误' })
        promptAction.showToast({ message: err.message })
        return
      }else{
        let dataObj = JSON.parse(data.result as string)
        if(dataObj.code == 'SUCCESS') {
          this.plant = new PlantData(dataObj.data[index].name,dataObj.data[index].description,dataObj.data[index].image,dataObj.data[index].temperature,dataObj.data[index].humidity,dataObj.data[index].luminance)
        }else{
          promptAction.showToast({ message: '获取植物 '+dataObj.message })
        }
      }
    })
  }

  onPageShow(): void {
    let data = router.getParams() as {index:number,token:string}
    this.token = data.token
    let index = data.index
    this.getPlant(index)
    this.timeId=setInterval(()=>{
      this.getPlant(index)
      console.log(JSON.stringify(this.plant))
    },1000)
    console.log(JSON.stringify(this.plant))
    this.ble.Check()
  }

  onPageHide(): void {
    clearInterval(this.timeId)
  }
  // 选择图片
  getPhotoImg() {
    let photoPicker = new picker.PhotoViewPicker();
    photoPicker.select({
      MIMEType:picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber:1
    },(err,data)=>{
      if (err) {
        console.info("photoPicker:"+err.message)
        return
      }
      this.plant.imageUrl = data.photoUris[0]
      data.isOriginalPhoto
    })
  }

  build(){
      Column() {
        Title({ title: '植物信息' })
        Column() {
          if(this.edit)
          {
            TextInput({text: this.plant.name})
              .fontSize(20)
              .fontColor(Color.Black)
              .backgroundColor(Color.White)
              .onChange((text) => {
                this.plant.name = text
              })
            TextInput({text: this.plant.description})
              .fontSize(15)
              .fontColor(Color.Black)
              .backgroundColor(Color.White)
              .margin({ top: '3%' })
              .onChange((text) => {
                this.plant.description = text
              })
          }else{
            Text(this.plant.name)
              .fontSize(20)
              .fontColor(Color.White)
            Text(this.plant.description)
              .fontSize(15)
              .fontColor("#E1E3E5")
              .margin({ top: '3%' })
          }
        }
        .width('90%')
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })
        .backgroundImage($r('app.media.flower'))
        .backgroundImageSize(ImageSize.Cover)

        Column() {
          Text('操作')
            .width('100%')
            .fontWeight(FontWeight.Bold)
          Row() {
            if (this.edit) {
              Button('保存')
                .fontSize(15)
                .width(80)
                .height(30)
                .margin({ top: '3%',left:'15%' })
                .onClick(() => {
                  this.edit = false
                })
            } else {
              Button('编辑')
                .fontSize(15)
                .width(80)
                .height(30)
                .margin({ top: '3%',left:'15%' })
                .onClick(() => {
                  this.edit = true
                })
            }
            Blank()
            Button('图片+')
              .fontSize(15)
              .width(80)
              .height(30)
              .margin({ top: '3%',right:'15%' })

          }
          .width('100%')
          .height('5%')

          Row() {
              Button('设备')
                .fontSize(15)
                .width(80)
                .height(30)
                .margin({ top: '3%',left:'15%' })
                .onClick(() => {
                  this.ble.GotoScanner(this.context)
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
        }
        .width('90%')
        .backgroundColor(Color.White)
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })
        .alignItems(HorizontalAlign.End)

        Column(){
          Text('当前数据')
            .width('100%')
            .fontWeight(FontWeight.Bold)

          Row(){
            Column() {
              Text(`${this.plant.temperature??"null"}`+" °")
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('温度')
                  .fontColor(Color.Gray)
                  .fontSize(17)
                Image($r('app.media.ic_temperature'))
                  .width(20)
                  .height(20)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
            }
            .alignItems(HorizontalAlign.Start)
            Column() {
              Text(`${this.plant.humidity??"null"}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('湿度')
                  .fontColor(Color.Gray)
                  .fontSize(17)
                Image($r('app.media.ic_humidity'))
                  .width(20)
                  .height(20)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
            }
            .alignItems(HorizontalAlign.Start)
            Column() {
              Text(`${this.plant.luminance??"null"}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('光照')
                  .fontColor(Color.Gray)
                  .fontSize(17)
                Image($r('app.media.ic_controlcenter_brightness_plus'))
                  .width(20)
                  .height(20)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            top:'7%'
          })
        }
        .width('90%')
        .backgroundColor(Color.White)
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })
        .alignItems(HorizontalAlign.End)

        Column() {
          Text('历史数据')
            .width('100%')
            .fontWeight(FontWeight.Bold)

          // Swiper(){
          //   historyT({histories:globalThis.histories})
          //   historyH({histories:globalThis.histories})
          //   historyI({histories:globalThis.histories})
          // }

          //history({ plant: $plant })
        }.width('90%')
        .backgroundColor(Color.White)
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
      .justifyContent(FlexAlign.Start)
  }
}