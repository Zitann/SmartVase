import Plant from '../tabs/plant'
import Account from '../tabs/account'
import { User,PlantData } from '../common/Data'
import router from '@ohos.router';
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Home{
  // 当前活动页面
  @State currentIndex: number = 0
  @State user: User = new User()
  @State plantList: PlantData[] = []
  httpRequest:http.HttpRequest = http.createHttp();
  // 控制器
  private controller: TabsController = new TabsController()

  getPlantList(){
    this.httpRequest.request("http://123.60.145.37:5000/plant/list",{
      method:http.RequestMethod.GET,
      header: {
        "Authorization": `Bearer ${this.user.token}`
      }
    },(err,data)=>{
      if(err){
        promptAction.showToast({ message: '网络错误' })
        promptAction.showToast({ message: err.message })
        return
      }else{
        let dataObj = JSON.parse(data.result as string)
        if(dataObj.code == 'SUCCESS') {
          this.plantList = []
          for(let plant of dataObj.data){
            this.plantList.push(new PlantData(plant.id,plant.name,plant.description,plant.image,plant.temperature,plant.humidity,plant.luminance))
          }
          console.info('plant '+ JSON.stringify(this.plantList))
        }else{
          promptAction.showToast({ message: '获取植物 '+dataObj.message })
        }
      }
    })
  }

  onPageShow(): void {
    this.user = router.getParams() as User
    this.getPlantList()
  }
  // 两个页面在tabs文件夹中
  build(){
    Column(){
      Tabs({barPosition:BarPosition.End, controller: this.controller}){
        TabContent(){
          Plant({plants:this.plantList,token:this.user.token})
        }
        .tabBar(this.TabBuilder(0,'植物',$r('app.media.plant')))
        TabContent(){
          Account({user:this.user})
        }
        .tabBar(this.TabBuilder(1,'我的',$r('app.media.ic_user_portrait')))
      }
      .onChange((index) => {
        this.currentIndex = index
      })
    }
    .backgroundColor('#F1F3F5')
  }
  // 自定义导航栏
  @Builder TabBuilder(index: number, name: string,img:Resource) {
    Column() {
      Image(img)
        .size({ width: 25, height: 25 })
        .fillColor(this.currentIndex === index ? '#0A59F7' : Color.Gray)
      Text(name)
        .fontColor(this.currentIndex === index ? '#0A59F7' : Color.Gray)
        .fontSize(15)
        .margin({top:3})
    }
    .width('100%')
    .padding({top:5})
    .border({width:{top:1},color:"#e3e3e3"})
    .onClick(() => {
      this.currentIndex = index;
      this.controller.changeIndex(this.currentIndex);
    })
  }
}