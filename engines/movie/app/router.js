import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('login');
  this.route('register');
  this.route('edit', {path: '/movies/:id/edit'});
  this.route('new', {path: '/movies/new'})
});

export default Router;
