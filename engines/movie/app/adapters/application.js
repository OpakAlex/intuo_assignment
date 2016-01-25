import ActiveModelAdapter from 'active-model-adapter';
import ENV from '../config/environment';

import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

export default ActiveModelAdapter.extend(DataAdapterMixin, {
  authorizer: 'authorizer:devise',
  namespace: 'api/v1',
  host: ENV.adapterUrl
});
