export class User{
  userNames: string;
  phone: string;
  avatarUrl : string;
  token: string;

  constructor(userNames: string = 'Narrao', phone: string = '', avatarUrl: string='', token: string='') {
    this.userNames = userNames;
    this.phone = phone;
    this.avatarUrl = avatarUrl;
    this.token = token;
  }
}

export class PlantData{
  name:string;
  description:string;
  imageUrl:string;
  temperature:number;
  humidity:number;
  luminance:number;
  history: History[];

  constructor(name: string, description: string, imageUrl: string, temperature: number, humidity: number, luminance: number, history: History[]) {
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.temperature = temperature;
    this.humidity = humidity;
    this.luminance = luminance;
    this.history = history;
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