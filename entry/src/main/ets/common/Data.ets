export class User{
  userName: string='';
  phone: string='';
  avatarUrl : string='';
  token: string='';

  constructor(userName: string = '', phone: string = '', avatarUrl: string='', token: string='') {
    this.userName = userName;
    this.phone = phone;
    this.avatarUrl = avatarUrl;
    this.token = token;
  }
}

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

export class History{
  time: string;
  temperature: number;
  humidity: number;
  luminance: number;

  constructor(time: string, temperature: number, humidity: number, luminance: number) {
    this.time = time;
    this.temperature = temperature;
    this.humidity = humidity;
    this.luminance = luminance;
  }
}