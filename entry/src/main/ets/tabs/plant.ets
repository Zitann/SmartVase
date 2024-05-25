import Title from '../common/Title'
import router from '@ohos.router';

@Entry
@Component
export default struct Plant{
  @State plants :{name:string,description:string,imageUrl:string,temperature:number,humidity:number,luminance:number,history:{time:string,temperature:number,humidity:number,luminance:number}[]}[]= [
    {
      name:"牡丹花",
      description:"牡丹花是一种被广泛栽培的花卉，是中国的传统名花之一。",
      imageUrl:"$r('app.media.icon')",
      temperature:25,humidity:50,luminance:1000,
      history:[
        {time:'2021-08-01',temperature:25,humidity:50,luminance:1000},
        {time:'2021-08-02',temperature:26,humidity:51,luminance:1001},
        {time:'2021-08-03',temperature:27,humidity:52,luminance:1002},
        {time:'2021-08-04',temperature:28,humidity:53,luminance:1003},
        {time:'2021-08-05',temperature:29,humidity:54,luminance:1004},
        {time:'2021-08-06',temperature:30,humidity:55,luminance:1005},
        {time:'2021-08-07',temperature:31,humidity:56,luminance:1006},
        {time:'2021-08-08',temperature:32,humidity:57,luminance:1007},
        {time:'2021-08-09',temperature:33,humidity:58,luminance:1008},
        {time:'2021-08-10',temperature:34,humidity:59,luminance:1009},
        {time:'2021-08-11',temperature:35,humidity:60,luminance:1010},
        {time:'2021-08-12',temperature:36,humidity:61,luminance:1011},
        {time:'2021-08-13',temperature:37,humidity:62,luminance:1012},
        {time:'2021-08-14',temperature:38,humidity:63,luminance:1013},
        {time:'2021-08-15',temperature:39,humidity:64,luminance:1014},
        {time:'2021-08-16',temperature:40,humidity:65,luminance:1015},
        {time:'2021-08-17',temperature:41,humidity:66,luminance:1016},
        {time:'2021-08-18',temperature:42,humidity:67,luminance:1017},
        {time:'2021-08-19',temperature:43,humidity:68,luminance:1018},
        {time:'2021-08-20',temperature:44,humidity:69,luminance:1019}
      ]
    },
    {
      name:"仙人掌",
      description:"仙人掌是多肉植物的一种，属于仙人掌科，是一种多肉植物，原产于美洲。",
      imageUrl:"$r('app.media.icon')",
      temperature:25,humidity:50,luminance:1000,
      history:[
        {time:'2021-08-01',temperature:25,humidity:50,luminance:1000},
        {time:'2021-08-02',temperature:26,humidity:51,luminance:1001},
        {time:'2021-08-03',temperature:27,humidity:52,luminance:1002},
        {time:'2021-08-04',temperature:28,humidity:53,luminance:1003},
        {time:'2021-08-05',temperature:29,humidity:54,luminance:1004},
        {time:'2021-08-06',temperature:30,humidity:55,luminance:1005},
        {time:'2021-08-07',temperature:31,humidity:56,luminance:1006},
        {time:'2021-08-08',temperature:32,humidity:57,luminance:1007},
        {time:'2021-08-09',temperature:33,humidity:58,luminance:1008},
        {time:'2021-08-10',temperature:34,humidity:59,luminance:1009},
        {time:'2021-08-11',temperature:35,humidity:60,luminance:1010},
        {time:'2021-08-12',temperature:36,humidity:61,luminance:1011},
        {time:'2021-08-13',temperature:37,humidity:62,luminance:1012},
        {time:'2021-08-14',temperature:38,humidity:63,luminance:1013},
        {time:'2021-08-15',temperature:39,humidity:64,luminance:1014},
        {time:'2021-08-16',temperature:40,humidity:65,luminance:1015},
        {time:'2021-08-17',temperature:41,humidity:66,luminance:1016},
        {time:'2021-08-18',temperature:42,humidity:67,luminance:1017},
        {time:'2021-08-19',temperature:43,humidity:68,luminance:1018},
        {time:'2021-08-20',temperature:44,humidity:69,luminance:1019}
      ]
    }
  ]

  build(){
    Column(){
      Title({title:'植物列表'})
      List({space:0}){
        ForEach(this.plants,(plant:any, index?:number)=>{
          ListItem(){
            this.item(plant)
          }.swipeAction({ end:this.itemEnd.bind(this,index), edgeEffect: SwipeEdgeEffect.Spring})
        })
      }
      .width('90%')
      .height('80%')
      .backgroundColor(Color.White)
      .border({radius:15})
      .margin({top:20})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Start)
  }

  //TODO: 以下为布局函数，根据实际需求修改
  // 每一项创建的布局
  @Builder item(patient:{name:string,description:string,imageUrl:string,temperature:number,humidity:number,luminance:number,history:{time:string,temperature:number,humidity:number,luminance:number}[]}){
    Row(){
      Text(patient.name)
        .width('17%')
      Text(patient.description)
    }
    .width('100%')
    .padding('5%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 滑动删除和编辑的布局
  @Builder itemEnd(index:number) {
    Row () {
      Button() {
        Image($r("app.media.ic_public_edit_filled"))
          .width('70%')
          .fillColor(Color.White)
      }
        .width(40)
        .height(40)
        .margin(4)
        .onClick(()=>{
          console.info('Click Icon')
          router.pushUrl({url:'pages/information',params:{index:index,patient:this.plants[index]}})
        })
      Button(){
        Image($r("app.media.ic_public_delete_filled"))
          .width('70%')
          .fillColor(Color.White)
      }
        .width(40)
        .height(40)
        .margin(4)
      .backgroundColor(Color.Red)
        .onClick(()=>{
          console.info(index.toString())
          this.plants.splice(index,1)
        })
    }.padding(4).justifyContent(FlexAlign.SpaceEvenly)
  }
}