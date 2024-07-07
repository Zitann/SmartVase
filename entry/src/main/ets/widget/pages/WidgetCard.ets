let storage = new LocalStorage()
export class PlantData{
  id:string ='';
  name:string='';
  description:string='';
  imageUrl:string='';
  temperature:number=0;
  humidity:number=0;
  luminance:number=0;

  constructor(id:string='',name: string='', description: string='', imageUrl: string='', temperature: number=0, humidity: number=0, luminance: number=0) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.temperature = temperature;
    this.humidity = humidity;
    this.luminance = luminance;
  }
}
@Entry(storage)
@Component

struct WidgetCard {
  /*
   * The title.
   */
  @LocalStorageProp('plantList') plantList:PlantData[]=[{"id":"123456","name":"月季","description":"这是一朵月这是一朵月季","imageUrl":"default.jpg","temperature":28,"humidity":72,"luminance":4354},{"id":"123457","name":"仙人","description":"这是一株仙人","imageUrl":"default.jpg","temperature":29,"humidity":67,"luminance":1695}]
  @State index:number = 0;
  readonly ACTION_TYPE: string = 'router';
  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  /*
   * The width percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';


  build() {
    Row() {
      Column() {
        Text(`${this.plantList[this.index].name}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({
            top: '5%',
            bottom: '2%',
            left: '5%',
            right: '5%'
          })
        Row() {
          Image($r('app.media.plant_card'))
            .width('50%')
            .onClick(() => {
              this.index = (this.index+1)%this.plantList.length;
              postCardAction(this, {
                action: 'message',
                params: {
                  'msgTest': 'messageEvent'
                }
              });
            })
          Column() {
            Column() {
              Row() {
                Text(`${this.plantList[this.index].humidity ?? "null"}`)
                  .fontSize(14)
                  .textAlign(TextAlign.Center)
                Text(' %')
                  .fontColor(Color.Gray)
                  .fontSize(8)
              }
              Row() {
                Text('湿度')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_humidity'))
                  .width(12)
                  .height(12)
              }
              .justifyContent(FlexAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)


            Column() {
              Row() {
                Text(`${this.plantList[this.index].luminance ?? "null"}`)
                  .fontSize(14)
                  .textAlign(TextAlign.Center)
                Text(' Lux')
                  .fontColor(Color.Gray)
                  .fontSize(8)
              }
              Row() {
                Text('光照')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_controlcenter_brightness_plus'))
                  .width(12)
                  .height(12)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
            }
            .margin({ top: '5%' })
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)

            Column() {
              Row() {
                Text(`${this.plantList[this.index].temperature ?? "null"}`)
                  .fontSize(14)
                  .textAlign(TextAlign.Center)
                Text(' ℃')
                  .fontColor(Color.Gray)
                  .fontSize(8)
              }
              Row() {
                Text('温度')
                  .fontColor(Color.Gray)
                  .fontSize(12)
                Image($r('app.media.ic_temperature'))
                  .width(12)
                  .height(12)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
            }
            .margin({ top: '5%' })
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
          }
          .width('50%')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({
          top: '7%'
        })
      }

      .backgroundColor(Color.White)
      .width('100%')
      .height('100%')
      .margin({ top: '5%' })
      .padding('5%')
      .border({ radius: 15 })
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        postCardAction(this, {
          action: this.ACTION_TYPE,
          abilityName: this.ABILITY_NAME,
          params: {
            'targetPage': 'pages/plant'
          }
        });
        console.info('点击')
      })
    }
  }
};


