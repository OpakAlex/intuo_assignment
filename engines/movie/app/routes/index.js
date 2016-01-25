import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  store: Ember.inject.service('store'),
  queryParams: {
    sort: {
      refreshModel: true
    },
    page: {
      refreshModel: true
    }, 

    title: {
      refreshModel: true
    }, 
    member: {
      refreshModel: true
    } 
  },

  model(params){
    let data = {
      sort: `rating ${params.sort || 'asc'}`,
      page: params.page || 1,
      title: params.title,
      member: params.member
    };
    return this.store.query('movie', data); 
  }

});
