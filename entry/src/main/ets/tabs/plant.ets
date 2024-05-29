import Title from '../common/Title'
import router from '@ohos.router';
import { PlantData } from '../common/Data';
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';

@Component
export default struct Plant{
  @Link plants:PlantData[]
  token:string = ''
  httpRequest:http.HttpRequest = http.createHttp();

  build(){
    Column(){
      Title({title:'植物列表'})
      List({space:10}){
        ForEach(this.plants,(plant:PlantData, index?:number)=>{
          ListItem(){
            this.item(plant)
          }.swipeAction({ end:this.itemEnd.bind(this,index), edgeEffect: SwipeEdgeEffect.Spring})
        })
      }
      .width('90%')
      .height('80%')
      .backgroundColor(Color.White)
      .border({radius:15})
      .margin({top:20})
      .padding(10)


      Image($r('app.media.ic_public_list_add_light'))
        .width(64)
        .height(64)
        .position({
          x: '70%', y: '80%'
        })
        .onClick(() => {
          // todo 点击按钮，跳转至新增页面
          router.pushUrl({
            url: 'pages/addPlant',
            params: {token:this.token}
          })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }

  //TODO: 以下为布局函数，根据实际需求修改
  // 每一项创建的布局
  @Builder item(plant:PlantData){
    Row(){
      Text(plant.name)
        .fontColor(Color.White)
        .width('30%')
        .margin({
          right:'5%'
        })
      Text(plant.description)
        .maxLines(2)
        .fontColor(Color.White)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .width('70%')
    }
    .backgroundImage(plant.imageUrl == "default.jpg"? $r('app.media.flower') : plant.imageUrl)
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .padding('5%')
    .height(100)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(12)
  }

  // 滑动删除和编辑的布局
  @Builder itemEnd(index:number) {
    Row () {
      Button() {
        Image($r("app.media.ic_public_edit_filled"))
          .width('70%')
          .fillColor(Color.White)
      }
        .width(40)
        .height(40)
        .margin(4)
        .onClick(()=>{
          console.info('Click Icon')
          router.pushUrl({url:'pages/information',params:{id:this.plants[index].id,token:this.token}})
        })
      Button(){
        Image($r("app.media.ic_public_delete_filled"))
          .width('70%')
          .fillColor(Color.White)
      }
        .width(40)
        .height(40)
        .margin(4)
      .backgroundColor(Color.Red)
        .onClick(()=>{
          console.info(index.toString())
          this.httpRequest.request(`http://123.60.145.37:5000/plant/info?id=${this.plants[index].id}`,{
            method:http.RequestMethod.DELETE,
            header: {
              "Authorization": `Bearer ${this.token}`
            }
          },(err,data)=>{
            if(err){
              promptAction.showToast({ message: '网络错误' })
              promptAction.showToast({ message: err.message })
              return
            }else {
              let dataObj = JSON.parse(data.result as string)
              console.info(dataObj)
              if(dataObj.code == 'SUCCESS'){
                promptAction.showToast({ message: '删除成功' })
              }else {
                promptAction.showToast({ message: '删除失败' })
              }
            }
          })
          this.plants.splice(index,1)
        })
    }.padding(4).justifyContent(FlexAlign.SpaceEvenly)
  }
}