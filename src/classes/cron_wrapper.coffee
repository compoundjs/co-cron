{CronJob} = require 'cron'
ControllerBridge = require('compound/lib/controller-bridge')
fn = ->

module.exports = class Cron_Wrapper
  constructor: (compound)->
    @jobs = {}
    @compound = compound
    @bridge = new ControllerBridge(compound)

  daemonize_route: (namespace, options)->
    # find out which controller to invoke and which action to perform on that controller
    task = =>
      ctl = options.route.split('#')[0]
      action = options.route.split('#')[0]

      @bridge.loadController(ctl).perform action,
          method: "cron"
          url: "/#{action}"
          params: options.params if options.params
        , {}, fn

    try
      @jobs[namespace] = new CronJob
        cronTime: options.cronTime
        onTick: task
        start: options.start if options.start
        timeZone: options.timeZone if options.timeZone
    catch err
      console.log "Cron pattern for #{namespace} is invalid"
    
  job: (namespace, options)->
    try
      @jobs[namespace] = new CronJob options
    catch err
      console.log "Cron pattern for #{namespace} is invalid"
    
  remove: (namespace)-> 
    @jobs[namespace].stop()
    delete @jobs[namespace] 
  stop: (namespace)-> @jobs[namespace].stop()
  start: (namespace)-> @jobs[namespace].start()
