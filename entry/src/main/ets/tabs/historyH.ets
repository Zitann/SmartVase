import { McLineChart, Options } from '@mcui/mccharts'
import { History } from '../common/Data';

@Component
export struct historyH {
  @Link  histories: History[]

  @State historyData:number[] = this.histories.slice(-7).map(entry => entry.humidity);
  @State Humidity: Options = new Options({
    xAxis:{ //设置X轴的相关样式与功能
      data:['周一','周二','周三','周四','周五','周六','周日']
    },
    yAxis:{ //设置Y轴的相关样式与功能
      name:'湿度',
    },
    series : [
      {
        name:'湿度',
        data: this.histories.slice(-7).map(entry => entry.humidity),
      }
    ],
    legend:{
      show:false
    }
  })

  onUpdate(){
    this.Humidity.setVal({
      series:[
        {
          name:'湿度',
          data:this.histories.slice(-7).map(entry => entry.humidity)
        }
      ]
    })
  }

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
            this.Humidity.setVal({
              series:[
                {
                  name:'湿度',
                  data:this.histories.slice(-7).map(entry => entry.humidity)
                }
              ]
            })
            console.log('plant humidity ',this.histories.slice(-7).map(entry => entry.humidity))
          })
      }
      .width('100%')
      McLineChart({ options: this.Humidity })
    }.width('100%').height(200).backgroundColor('#FFFFFF').borderRadius(10)
  }
}