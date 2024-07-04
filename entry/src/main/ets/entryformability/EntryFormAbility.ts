import formInfo from '@ohos.app.form.formInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import Want from '@ohos.app.ability.Want';
import formProvider from '@ohos.app.form.formProvider';
import request from '@ohos.request';
import fs from '@ohos.file.fs';
export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
     let formData={
      'name':'梨花',
      'temperature':10,
      'humidity':10,
      'luminance':10
    };
    return formBindingData.createFormBindingData(formData)
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
    let formData = {
      'name':'玫瑰',
      'temperature':10,
      'humidity':10,
      'luminance':10
    };
    let formInfo = formBindingData.createFormBindingData(formData)
    formProvider.updateForm(formId, formInfo).then((data) => {
      console.info('FormAbility updateForm success.' + JSON.stringify(data));
    }).catch((error) => {
      console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
    })
  }

  onChangeFormVisibility(newStatus: Record<string, number>) {
    // Called when the form provider receives form events from the system.
  }

  onFormEvent(formId, message) {
    // Called when a specified message event defined by the form provider is triggered.
    // Called when a specified message event defined by the form provider is triggered.
    console.info(`FormAbility onEvent, formId = ${formId}, message: ${JSON.stringify(message)}`);
    let formData = {
      'name':'荷花',
      'temperature':10,
      'humidity':10,
      'luminance':10
    };
    let formInfo = formBindingData.createFormBindingData(formData)
    formProvider.updateForm(formId, formInfo).then((data) => {
      console.info('FormAbility updateForm success.' + JSON.stringify(data));
    }).catch((error) => {
      console.error('FormAbility updateForm failed: ' + JSON.stringify(error));
    })
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }




};