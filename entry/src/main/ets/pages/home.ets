import Plant from '../tabs/plant'
import Account from '../tabs/account'
import { User } from '../common/Data'
import router from '@ohos.router';
import dataPreferences from '@ohos.data.preferences';

@Entry
@Component
struct Home{
  // 当前活动页面
  @State currentIndex: number = 0
  @State user: User = null
  // 控制器
  private controller: TabsController = new TabsController()

  onPageShow(): void {
    this.user = router.getParams() as User
  }
  // 两个页面在tabs文件夹中
  build(){
    Column(){
      Tabs({barPosition:BarPosition.End, controller: this.controller}){
        TabContent(){
          Plant()
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