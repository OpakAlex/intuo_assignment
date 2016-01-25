import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  rating: DS.attr('number'),
  members: DS.hasMany('member', {async: false}),
  directors: DS.hasMany('director', {async: false})
});
