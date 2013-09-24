(function() {
  var Wrapper;

  Wrapper = require('./classes/cron_wrapper');

  exports.init = function(compound) {
    compound.cron = new Wrapper(compound);
    return compound.emit('cron', compound.cron);
  };

}).call(this);
