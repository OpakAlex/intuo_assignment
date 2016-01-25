import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    nextPage(){
      if (this.get('model.length') > 0){
        this.incrementProperty('page'); 
      }
    },

    prevPage(){
      if (this.get('page') > 1){
        this.decrementProperty('page');
      }
    }
  }
});
