import bluetoothManager from '@ohos.bluetoothManager';
import promptAction from '@ohos.promptAction';

export default class BLE{
  device:any;
  Check(){
    let state = null
    try {
      state = bluetoothManager.getState();
    } catch (err) {
      console.error("plant ble getState errCode:" + err.code + ",errMessage:" + err.message);
    }
    if (state != bluetoothManager.BluetoothState.STATE_ON) {
      try {
        bluetoothManager.enableBluetooth();
      } catch (err) {
        console.error("plant ble enableBluetooth errCode:" + err.code + ",errMessage:" + err.message);
      }
    }
  }

  GotoScanner(context:any){
    let want = {
      "deviceId":'',
      "bundleName": "com.huawei.scanner",
    }
    context.startAbility(want)
  }

  GetPairedDevices(){
    let deviceIDs = []
    let devices = {}
    try {
      deviceIDs = bluetoothManager.BLE.getConnectedBLEDevices();
    } catch (err) {
      console.error("plant ble getPairedDevice errCode:" + err.code + ",errMessage:" + err.message);
    }
    try{
      for(let deviceID of deviceIDs){
        devices[deviceID] = bluetoothManager.getRemoteDeviceName(deviceID);
      }
    }catch (err) {
    }
    return devices as JSON
  }
  Connect(deviceId:string){
    try {
      this.device = bluetoothManager.BLE.createGattClientDevice(deviceId);
      this.device.connect();
      promptAction.showToast({message:"连接成功"})
    } catch (err) {
      promptAction.showToast({message:"连接失败"})
      console.error("plant ble connect errCode:" + err.code + ",errMessage:" + err.message);
    }
  }

  SendData(strData:string,n:number) {
    // let characteristic = {serviceUuid: 'EFCDAB90-7856-3412-EFCD-AB9078563412',
    //   characteristicUuid: '0000FF01-0000-1000-8000-00805F9B34FB',
    // 将string转为二进制值
    this.device.getServices().then(result => {
      console.info("plant ble getServices successfully:" + JSON.stringify(result[2]));
      let buffer = new ArrayBuffer(strData.length);
      let dataView = new Uint8Array(buffer);
      for (let i = 0; i < strData.length; i++) {
        dataView[i] = strData.charCodeAt(i);
      }
      let characteristic = {
        serviceUuid: 'EFCDAB90-7856-3412-EFCD-AB9078563412',
        characteristicUuid: `0000FF0${n}-0000-1000-8000-00805F9B34FB`,
        characteristicValue: buffer,
        descriptors: []
      };
      try {
        console.info('plant ble characteristic: ' + JSON.stringify(characteristic.characteristicValue));
        this.device.writeCharacteristicValue(characteristic);
      } catch (err) {
        promptAction.showToast({
          message: "发送失败"
        })
        console.error("plant ble sendData errCode:" + err.code + ",errMessage:" + err.message);
      }
    });
  }
}