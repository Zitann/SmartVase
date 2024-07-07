import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import Want from '@ohos.app.ability.Want';
import formProvider from '@ohos.app.form.formProvider';
import http from '@ohos.net.http';

class User{
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

export default class EntryFormAbility extends FormExtensionAbility {
  httpRequest = http.createHttp();
  phone = '123'
  passwd = 'admin'
  plantList = []
  user = new User()
    onAddForm(want: Want) {
      let formId = want.parameters[formInfo.FormParam.IDENTITY_KEY] as string
      const run = async () => {
        console.log('jzt1 start')
        await this.login()
        console.log('jzt2 '+JSON.stringify(this.user))
        await this.getPlantList()
        console.log('jzt3 '+JSON.stringify(this.plantList))
      }
      run()
      setTimeout(() => {
        console.log('jzt 5s later',JSON.stringify(this.plantList))
        let formData = {
          plant: this.plantList
        }
        let formInfo = formBindingData.createFormBindingData(formData)
        formProvider.updateForm(formId,formInfo).then(res=>{
          console.log('jzt ','更新成功');
        }).catch(err=>{
          console.log('jzt ','更新失败');
        });
      }, 2000)
      return null
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
    const run = async () => {
      console.log('jzt1 start')
      await this.login()
      console.log('jzt2 '+JSON.stringify(this.user))
      await this.getPlantList()
      console.log('jzt3 '+JSON.stringify(this.plantList))
    }
    run()
    setTimeout(() => {
      console.log('jzt 5s later',JSON.stringify(this.plantList))
      let formData = {
        plantList: this.plantList
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId,formInfo).then(res=>{
        console.log('jzt ','更新成功');
      }).catch(err=>{
        console.log('jzt ','更新失败');
      });
    }, 2000)
  }

  onChangeFormVisibility(newStatus: Record<string, number>) {
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId, message) {
    // Called when a specified message event defined by the form provider is triggered.
    const run = async () => {
      console.log('jzt1 start')
      await this.login()
      console.log('jzt2 '+JSON.stringify(this.user))
      await this.getPlantList()
      console.log('jzt3 '+JSON.stringify(this.plantList))
    }
    run()
    setTimeout(() => {
      console.log('jzt 5s later',JSON.stringify(this.plantList))
      let formData = {
        plantList: this.plantList
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId,formInfo).then(res=>{
        console.log('jzt ','更新成功');
      }).catch(err=>{
        console.log('jzt ','更新失败');
      });
    }, 2000)
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }

  async login() {
    console.log('jzt login')
    const res = await this.httpRequest.request('http://123.60.145.37:5000/user/login', {
      method: http.RequestMethod.POST,
      extraData: {
        phone: this.phone.toString(),
        password: this.passwd.toString()
      }
    })
    console.log('jzt '+typeof res)
    const { responseCode, result } = res;
    if(responseCode !== 200) {
      return;
    } else {
      let dataObj = JSON.parse(result as string)
      if(dataObj.code == 'SUCCESS') {
        console.log('jzt success');
        console.log('jzt '+JSON.stringify(dataObj.data));
        let user = new User(dataObj.data.user.username, dataObj.data.user.phone, dataObj.data.user.avatar, dataObj.data.token);
        console.log('jzt '+JSON.stringify(user));
        this.user = user;
      }
    }
  }

  async getPlantList(){
    const res = await this.httpRequest.request("http://123.60.145.37:5000/plant/list",{
      method:http.RequestMethod.GET,
      header: {
        "Authorization": `Bearer ${this.user.token}`
      }
    })

    const { responseCode, result } = res;
    if(responseCode !== 200) {
      return;
    } else {
      let dataObj = JSON.parse(result as string)
      if(dataObj.code == 'SUCCESS') {
        this.plantList = []
        for(let plant of dataObj.data){
          this.plantList.push(new PlantData(plant.id,plant.name,plant.description,plant.image,plant.temperature,plant.humidity,plant.luminance))
        }
        console.info(JSON.stringify(this.plantList))
      }
    }
  }


};