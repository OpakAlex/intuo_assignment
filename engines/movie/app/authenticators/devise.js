import Devise from 'ember-simple-auth/authenticators/devise';
import Ember from 'ember';
const { RSVP, isEmpty, run, get } = Ember;
import ENV from '../config/environment';

export default Devise.extend({
  serverTokenEndpoint: `${ENV.adapterUrl}/api/v1/users/sign_in`,
  
  authenticate(_data) {
    let identification = _data.identification;
    let password = _data.password;
    return new RSVP.Promise((resolve, reject) => {
      if (_data.token){
        return resolve(_data);  
      }
      const { resourceName, identificationAttributeName } = this.getProperties('resourceName', 'identificationAttributeName');
      const data         = {};
      data[resourceName] = { password };
      data[resourceName][identificationAttributeName] = identification;

      this.makeRequest(data).then(function(response) {
        run(null, resolve, response);
      }, function(xhr) {
        run(null, reject, xhr.responseJSON || xhr.responseText);
      });
    });
  }
});
