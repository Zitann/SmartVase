let storage = new LocalStorage()
@Entry(storage)
@Component

struct WidgetCard {
  /*
   * The title.
   */
  @LocalStorageProp('name') name: string = '兰花';
  @LocalStorageProp('temperature') temperature: number=0;
  @LocalStorageProp('humidity') humidity: number = 0;
  @LocalStorageProp('luminance') luminance: number = 0;
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
      this.item();
    }
  }

  @Builder
  item() {
    Column() {
      Text(`${this.name}`)
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
        Column() {
          Text(`${this.temperature ?? "null"}` + " °")
            .fontSize(20)
            .width('20%')
            .textAlign(TextAlign.Center)
          Row() {
            Text('温度')
              .fontColor(Color.Gray)
              .fontSize(17)
            Image($r('app.media.ic_temperature'))
              .width(12)
              .height(12)
          }
          .width('45%')
          .justifyContent(FlexAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Column() {
          Column() {
            Text(`${this.humidity ?? "null"}`)
              .fontSize(14)
              .width('20%')
              .textAlign(TextAlign.Center)
            Row() {
              Text('湿度')
                .fontColor(Color.Gray)
                .fontSize(12)
              Image($r('app.media.ic_humidity'))
                .width(12)
                .height(12)
            }
            //.width('50%')
            // .margin({
            //   bottom: '5%'
            // })
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)


          Column() {
            Text(`${this.luminance ?? "null"}`)
              .fontSize(14)
              .width('100%')
              .textAlign(TextAlign.Center)
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
    .gesture(
      SwipeGesture({ direction: SwipeDirection.Vertical })
        .onAction((event: GestureEvent|undefined) => {
          if(event){
            postCardAction(this, {
              'action': 'message',
              'params': {
                'msgTest': 'messageEvent'
              }
            });
            console.info('滑动')
          }
        })
    )
  }
};


