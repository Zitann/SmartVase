import { McLineChart, Options } from '@mcui/mccharts'
import { History } from '../common/Data';

@Component
export struct historyH {
  @Link histories: History[]

  @State historyData:number[] = this.histories.slice(-7).map(entry => entry.humidity);
  @State Humidity: Options = new Options({
    xAxis:{ //设置X轴的相关样式与功能
      data:['周一','周二','周三','周四','周五','周六','周日']
    },
    yAxis:{ //设置Y轴的相关样式与功能
      name:''
    },
    series : [
      {
        data: this.historyData,
      }
    ],
    legend:{
      show:false
    }
  })

  build(){
    Column() {
      Row() {
        Text('湿度')
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
            this.Humidity.series = [
              {
                // @ts-ignore
                data: this.histories.map(history => history.humidity)
              }
            ];
            console.log('refresh')
          })
      }
      .width('100%')
      CustomLayout({Humidity:this.Humidity,histories:this.histories}) {
        McLineChart({ options: this.Humidity })
      }
    }.width('100%').height(200).backgroundColor('#FFFFFF').borderRadius(10)
  }
}
@Component
struct CustomLayout {
  @BuilderParam builder: () => {};
  @Link Humidity: Options
  @Link histories:History[]
  onLayout(children: Array<LayoutChild>, constraint: ConstraintSizeOptions) {
    this.Humidity.series = [
      {
        // @ts-ignore
        data: this.histories.map(history => history.humidity)
      }
    ];
    console.log('refresh')
  }

  build() {
    this.builder()
  }
}