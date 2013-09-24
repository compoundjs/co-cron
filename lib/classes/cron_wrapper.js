(function() {
  var ControllerBridge, CronJob, Cron_Wrapper, fn;

  CronJob = require('cron').CronJob;

  ControllerBridge = require('compound/lib/controller-bridge');

  fn = function() {};

  module.exports = Cron_Wrapper = (function() {

    function Cron_Wrapper(compound) {
      this.jobs = {};
      this.compound = compound;
      this.bridge = new ControllerBridge(compound);
    }

    Cron_Wrapper.prototype.daemonize_route = function(namespace, options) {
      var task,
        _this = this;
      task = function() {
        var action, ctl;
        ctl = options.route.split('#')[0];
        action = options.route.split('#')[0];
        return _this.bridge.loadController(ctl).perform(action, {
          method: "cron",
          url: "/" + action,
          params: options.params ? options.params : void 0
        }, {}, fn);
      };
      try {
        return this.jobs[namespace] = new CronJob({
          cronTime: options.cronTime,
          onTick: task,
          start: options.start ? options.start : void 0,
          timeZone: options.timeZone ? options.timeZone : void 0
        });
      } catch (err) {
        return console.log("Cron pattern for " + namespace + " is invalid");
      }
    };

    Cron_Wrapper.prototype.job = function(namespace, options) {
      try {
        return this.jobs[namespace] = new CronJob(options);
      } catch (err) {
        return console.log("Cron pattern for " + namespace + " is invalid");
      }
    };

    Cron_Wrapper.prototype.remove = function(namespace) {
      this.jobs[namespace].stop();
      return delete this.jobs[namespace];
    };

    Cron_Wrapper.prototype.stop = function(namespace) {
      return this.jobs[namespace].stop();
    };

    Cron_Wrapper.prototype.start = function(namespace) {
      return this.jobs[namespace].start();
    };

    return Cron_Wrapper;

  })();

}).call(this);
