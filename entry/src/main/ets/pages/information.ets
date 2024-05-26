import router from '@ohos.router';
import Title from '../common/Title'
import picker from '@ohos.file.picker';
import promptAction from '@ohos.promptAction';
import { historyT } from '../tabs/historyT';
import { historyH } from '../tabs/historyH';
import {historyI} from  '../tabs/historyI';
@Entry
@Component
struct Information{
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
              .onChange((text) => {
                this.plant.name = text
              })
            TextInput({text: this.plant.description})
              .fontSize(15)
              .fontColor(Color.Gray)
              .margin({ top: '3%' })
              .onChange((text) => {
                this.plant.description = text
              })
          }else{
            Text(this.plant.name)
              .fontSize(20)
            Text(this.plant.description)
              .fontSize(15)
              .fontColor(Color.Gray)
              .margin({ top: '3%' })
          }
        }
        .width('90%')
        .backgroundColor(Color.White)
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })

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
                  this.edit = true
                })
            Blank()
            Button('配网')
              .fontSize(15)
              .width(80)
              .height(30)
              .margin({ top: '3%',right:'15%' })

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
              Row() {
                Text('温度')
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
              Text(`${this.plant.temperature}`+" °")
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)

            }
            .alignItems(HorizontalAlign.Start)
            Column() {
              Row() {
                Text('湿度')
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
              Text(`${this.plant.humidity}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)

            }
            .alignItems(HorizontalAlign.Start)
            Column() {
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
              Text(`${this.plant.luminance}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)

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