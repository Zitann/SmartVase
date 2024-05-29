import { McLineChart, Options } from '@mcui/mccharts'
import { History } from '../common/Data';

@Component
export struct historyI {
  @Link histories:History[]

  @State historyData:number[] = this.histories.slice(-7).map(entry => entry.luminance);
  @State Luminance: Options = new Options({
    xAxis:{ //设置X轴的相关样式与功能
      data:['周一','周二','周三','周四','周五','周六','周日']
    },
    yAxis:{ //设置Y轴的相关样式与功能
      name:'温度'
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
      Text('光照')
        .fontSize(15)
        .fontColor(Color.Gray)
      McLineChart({ options: this.Luminance })
    }.width('100%').height(200).backgroundColor('#FFFFFF').borderRadius(10)
  }
}