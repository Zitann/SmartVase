import router from '@ohos.router';
import Title from '../common/Title'
import picker from '@ohos.file.picker';
import promptAction from '@ohos.promptAction';
import { historyT } from '../tabs/historyT';
import { historyH } from '../tabs/historyH';
import {historyI} from  '../tabs/historyI';
import { History, PlantData } from '../common/Data';
import http from '@ohos.net.http';
import UIAbility from '@ohos.app.ability.UIAbility';
@Entry
@Component
struct Information{
  @State name: string = ''
  @State description: string = ''
  httpRequest:http.HttpRequest = http.createHttp();
  @State edit:boolean = false
  @State plant :PlantData = new PlantData()
  @State histories:History[] = []

  token = ''
  plantId=''
  timeId = 0
  getPlant(){
    this.httpRequest.request(`http://123.60.145.37:5000/plant/info?id=${this.plantId}`,{
      method:http.RequestMethod.GET,
      header: {
        "Content-Type": "application/json",
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
          // console.log(JSON.stringify(dataObj.data))
          this.plant = new PlantData(dataObj.data.id,dataObj.data.name,dataObj.data.description,dataObj.data.image,dataObj.data.temperature,dataObj.data.humidity,dataObj.data.luminance)
          if(this.name == ''){
            this.name = this.plant.name
          }
          if(this.description == ''){
            this.description = this.plant.description
          }
        }else{
          promptAction.showToast({ message: '获取植物 '+dataObj.message })
        }
      }
    })
  }

  getHistory(){
    this.httpRequest.request(`http://123.60.145.37:5000/history/data?id=${this.plantId}`,{
      method:http.RequestMethod.GET,
      header: {
        "Content-Type": "application/json",
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
          // console.log(JSON.stringify(dataObj.data))
          this.histories = []
          for(let history of dataObj.data){
            this.histories.push(new History(history.time,history.temperature,history.humidity,history.luminance))
          }
          if(this.histories.length == 0){
            return
          }
          this.plant.temperature = this.histories[this.histories.length-1].temperature
          this.plant.humidity = this.histories[this.histories.length-1].humidity
          this.plant.luminance = this.histories[this.histories.length-1].luminance
          console.log('history'+JSON.stringify(this.histories))
        }else{
          promptAction.showToast({ message: '获取植物 '+dataObj.message })
        }
      }
    })
  }

  savePlant() {
    this.httpRequest.request(`http://123.60.145.37:5000/plant/info`,{
      method:http.RequestMethod.PUT,
      header: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${this.token}`
      },
      extraData:{
        "id":this.plantId,
        "name":this.name,
        "description":this.description,
      }
    },(err,data)=>{
      if(err){
        promptAction.showToast({ message: '网络错误' })
        promptAction.showToast({ message: err.message })
        return
      }else{
        let dataObj = JSON.parse(data.result as string)
        if(dataObj.code == 'SUCCESS') {
          // console.log(JSON.stringify(dataObj.data))
          this.plant = new PlantData(dataObj.data.id,dataObj.data.name,dataObj.data.description,dataObj.data.image,dataObj.data.temperature,dataObj.data.humidity,dataObj.data.luminance)
          if(this.name == ''){
            this.name = this.plant.name
          }
          if(this.description == ''){
            this.description = this.plant.description
          }
        }else{
          promptAction.showToast({ message: '获取植物 '+dataObj.message })
        }
      }
    })
  }

  onPageShow(): void {
    let data = router.getParams() as {id:string,token:string}
    this.token = data.token
    this.plantId = data.id
    this.getPlant()
    this.getHistory()
    this.timeId=setInterval(()=>{
      this.getHistory()
    },60000)
    console.log(JSON.stringify(this.plant))
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
            TextInput({text: this.name})
              .fontSize(20)
              .fontColor(Color.Black)
              .backgroundColor(Color.White)
              .onChange((text) => {
                this.name = text
              })
            TextInput({text: this.description})
              .fontSize(15)
              .fontColor(Color.Black)
              .backgroundColor(Color.White)
              .margin({ top: '3%' })
              .onChange((text) => {
                this.description = text
              })
          }else{
            Text(this.name)
              .fontSize(20)
              .fontColor(Color.White)
            Text(this.description)
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
                  this.savePlant()
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
        }
        .width('90%')
        .backgroundColor(Color.White)
        .margin({ top: '5%' })
        .padding('5%')
        .border({ radius: 15 })
        .alignItems(HorizontalAlign.End)

        Column(){
          Row() {
            Text('当前数据')
              .fontWeight(FontWeight.Bold)
            Image($r('app.media.ic_public_refresh'))
              .width(20)
              .height(20)
              .margin({ left: '5%' })
              .onClick(() => {
                this.getHistory()
              })
          }
          Row(){
            Column() {
              Text(`${this.plant.temperature??"null"}`+" °")
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('温度')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_temperature'))
                  .width(12)
                  .height(12)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
              .justifyContent(FlexAlign.Center)
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            Column() {
              Text(`${this.plant.humidity??"null"}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('湿度')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_humidity'))
                  .width(12)
                  .height(12)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
              .justifyContent(FlexAlign.Center)
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            Column() {
              Text(`${this.plant.luminance??"null"}`)
                .fontSize(25)
                .width('20%')
                .textAlign(TextAlign.Center)
              Row() {
                Text('光照')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_controlcenter_brightness_plus'))
                  .width(12)
                  .height(12)
              }
              .width('20%')
              .margin({
                bottom:'5%'
              })
              .justifyContent(FlexAlign.Center)
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
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
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('历史数据')
            .width('100%')
            .fontWeight(FontWeight.Bold)
            .onClick(()=>{
              console.log(this.histories.map(entry => entry.temperature).toString())
              console.log(this.histories.map(entry => entry.humidity).toString())
              console.log(this.histories.map(entry => entry.luminance).toString())
            })

          Swiper() {
            historyT({ histories: this.histories})
            historyH({ histories: this.histories })
            historyI({ histories: this.histories })
          }
          //test({ histories: this.histories})


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

