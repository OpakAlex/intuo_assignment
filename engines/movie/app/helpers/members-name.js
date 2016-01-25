import Ember from 'ember';

export default Ember.Helper.helper(function(params) {
  let items = params[0] || [];
  let names = items.toArray().map((item) => item.get('name'));
  return names.join(", "); 
});
