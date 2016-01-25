import Ember from 'ember';
import config from 'movie/config/environment';

export default Ember.Controller.extend({
  inProcess: false,

  session: Ember.inject.service('session'),

  ajax(){
    let defer = new Ember.RSVP.defer();
    let data = this.getProperties('email', 'password', 'password_confirmation', 'name'); 
    if(!data.email){
      defer.resolve();
      return defer.promise;
    }
    Ember.$.ajax({
      url: `${config.adapterUrl}/api/v1/users/create`,
      type: 'POST',
      data: JSON.stringify({user: data}),
      contentType: 'application/json; charset=utf-8',
      dataType: 'json',
      success: defer.resolve,
      error: defer.reject
    });
    return defer.promise;
  },
  actions: {
    create(){
      this.set('errors', []);
      this.set('inProcess', true);
      this.ajax().then((data) => {
        this.get('session').authenticate('authenticator:devise', data);
        this.set('inProcess', false);
      }, (data) => {
        this.set('inProcess', false);
        this.set('errors', data.responseJSON.errors)
      });
      return false;
    }
  }
});
