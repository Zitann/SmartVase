import router from '@ohos.router';
import Title from '../common/Title'
import picker from '@ohos.file.picker';
import promptAction from '@ohos.promptAction';
import { historyT } from '../tabs/historyT';
import { historyH } from '../tabs/historyH';
import {historyI} from  '../tabs/historyI';
import BLE from '../common/BLE'
import wifi from '@ohos.wifi';

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
  @State plant :{name:string,description:string,imageUrl:string,temperature:number,humidity:number,luminance:number,history:{time:string,temperature:number,humidity:number,luminance:number}[]}=
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
    }
  index: number

  onPageShow(): void {
    this.ble.Check()
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
              Text(`${this.plant.temperature}`+" °")
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
              Text(`${this.plant.humidity}`)
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
              Text(`${this.plant.luminance}`)
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

          Swiper(){
            historyT({plant:$plant})
            historyH({plant:$plant})
            historyI({plant:$plant})
          }

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