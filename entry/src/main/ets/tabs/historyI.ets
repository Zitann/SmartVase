import { McLineChart, Options } from '@mcui/mccharts'
@Component
export struct historyI {
  @Link plant :{name:string,description:string,imageUrl:string,temperature:number,humidity:number,luminance:number,history:{time:string,temperature:number,humidity:number,luminance:number}[]}

  @State historyData:number[] = this.plant.history.slice(-7).map(entry => entry.luminance);
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