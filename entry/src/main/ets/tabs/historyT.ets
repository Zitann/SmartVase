import { McLineChart, Options } from '@mcui/mccharts'
import { History } from '../common/Data';

@Component
export struct historyT {
 @Link histories:History[]
 @State historyData:number[] = this.histories.map(history => history.temperature);
  //@Link Data:Number[]
  @State Data:String[]=[]
  @State Temperature: Options = new Options({
    xAxis:{ //设置X轴的相关样式与功能
      data:['周一','周二','周三','周四','周五','周六','周日']
    },
    yAxis:{ //设置Y轴的相关样式与功能
      name:''
    },
    series : [
      {
        data: this.Data
      }
      ],
    legend:{
      show:false
    }
  })


build(){

  Column() {
    Row() {
      Text('温度')
        .fontSize(20)
        .fontColor(Color.Gray)
        .textAlign(TextAlign.End)
        .width('50%')
      Image($r('app.media.ic_public_refresh'))
        .margin({
          left:'5%'
        })
        .width(20)
        .height(20)
        .onClick(()=>{
          this.Temperature.series = [
            {
              // @ts-ignore
              data: this.histories.map(history => history.temperature)
            }
          ];
          console.log('refresh')
        })
    }
    .width('100%')
    CustomLayout({Temperature:this.Temperature,histories:this.histories}) {
      McLineChart({ options: this.Temperature })
    }
  }.width('100%').height(200).backgroundColor('#FFFFFF').borderRadius(10)
}


}
@Component
struct CustomLayout {
  @BuilderParam builder: () => {};
@Link Temperature: Options
 @Link histories:History[]
  onLayout(children: Array<LayoutChild>, constraint: ConstraintSizeOptions) {
    this.Temperature.series = [
      {
        // @ts-ignore
        data: this.histories.map(history => history.temperature)
      }
    ];
    console.log('refresh')
  }

  build() {
    this.builder()
  }
}