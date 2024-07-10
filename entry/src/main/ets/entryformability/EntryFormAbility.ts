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
        console.log('vase card start')
        await this.login()
        await this.getPlantList()
      }
      run()
      setTimeout(() => {
        let formData = {
          plant: this.plantList
        }
        let formInfo = formBindingData.createFormBindingData(formData)
        formProvider.updateForm(formId,formInfo).then(res=>{
          console.log('vase card ','更新成功');
        }).catch(err=>{
          console.log('vase card ','更新失败');
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
      console.log('vase card start')
      await this.login()
      await this.getPlantList()
    }
    run()
    setTimeout(() => {
      let formData = {
        plantList: this.plantList
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId,formInfo).then(res=>{
        console.log('vase card ','更新成功');
      }).catch(err=>{
        console.log('vase card ','更新失败');
      });
    }, 2000)
  }

  onChangeFormVisibility(newStatus: Record<string, number>) {
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId, message) {
    // Called when a specified message event defined by the form provider is triggered.
    const run = async () => {
      console.log('vase card start')
      await this.login()
      await this.getPlantList()
    }
    run()
    setTimeout(() => {
      let formData = {
        plantList: this.plantList
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId,formInfo).then(res=>{
        console.log('vase card ','更新成功');
      }).catch(err=>{
        console.log('vase card ','更新失败');
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
    console.log('vase card login')
    const res = await this.httpRequest.request('http://123.60.145.37:5000/user/login', {
      method: http.RequestMethod.POST,
      extraData: {
        phone: this.phone.toString(),
        password: this.passwd.toString()
      }
    })
    const { responseCode, result } = res;
    if(responseCode !== 200) {
      return;
    } else {
      let dataObj = JSON.parse(result as string)
      if(dataObj.code == 'SUCCESS') {
        console.log('vase card success');
        console.log('vase card '+JSON.stringify(dataObj.data));
        let user = new User(dataObj.data.user.username, dataObj.data.user.phone, dataObj.data.user.avatar, dataObj.data.token);
        console.log('vase card user '+JSON.stringify(user));
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
        console.info('plant card plantList '+JSON.stringify(this.plantList));
      }
    }
  }


};