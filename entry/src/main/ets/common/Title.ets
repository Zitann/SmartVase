@Component
export default struct Title{
  @Prop title:string
  build(){
    Row(){
      Text(this.title)
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .margin({ top: '15%',left:'5%'})
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}