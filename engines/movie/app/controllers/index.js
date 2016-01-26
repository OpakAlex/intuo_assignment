import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service('session'),
  queryParams: ['sort', 'page', 'title', 'member'],
  sort: 'asc',
  page: 1,
  title: null,
  member: null,
  isDescSort: Ember.computed.equal('sort', 'desc'),
  isAscSort: Ember.computed.equal('sort', 'asc'),
  filteredTitle: '',
  filteredMember: '',

  actions: {
    search(){
      this.setProperties({title: this.get('filteredTitle'), member: this.get('filteredMember')});
      return false;
    }
  } 
});
