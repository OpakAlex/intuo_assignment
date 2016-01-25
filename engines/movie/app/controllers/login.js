import Ember from 'ember';

export default Ember.Controller.extend({
  inProcess: false,

  session: Ember.inject.service('session'),

  withDefault: function() {
    let credentials = this.getProperties('identification', 'password');
    return this.get('session').authenticate('authenticator:devise', credentials)
    .catch((reason) => {
      this.set('errors', reason.errors);
    });
  },
  actions: {
    authenticate(){
      this.set('inProcess', true);
      this.withDefault().finally(() => {
        this.set('inProcess', false);
      });
      return false;
    }
  }
});
