import { McLineChart, Options } from '@mcui/mccharts'
import { History } from '../common/Data';

@Component
export struct historyI {
  @Link  histories:History[]
  @State historyData:number[] = this.histories.slice(-7).map(entry => entry.luminance)

  @State Luminance: Options = new Options({
    xAxis:{ //设置X轴的相关样式与功能
      data:['周一','周二','周三','周四','周五','周六','周日']
    },
    yAxis:{ //设置Y轴的相关样式与功能
      name:'光照强度',
    },
    series : [
      {
        name:'光照强度',
        data: this.histories.slice(-7).map(entry => entry.luminance),
      }
    ],
    legend:{
      show:false
    }
  })

  onUpdate(){
    this.Luminance.setVal({
      series:[
        {
          name:'光照强度',
          data: this.histories.slice(-7).map(entry => entry.luminance),
        }
      ]
    })
  }

  build(){
    Column() {
      Row() {
        Text('光照')
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
            this.Luminance.setVal({
              series:[
                {
                  name:'光照强度',
                  data: this.histories.slice(-7).map(entry => entry.luminance),
                }
              ]
            })
            console.log('plant luminance ',this.histories.slice(-7).map(entry => entry.luminance))
          })
      }
      .width('100%')
      McLineChart({ options: this.Luminance })
    }.width('100%').height(200).backgroundColor('#FFFFFF').borderRadius(10)
  }
}