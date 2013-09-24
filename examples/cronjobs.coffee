# this file will live at app.root/config/initializers

module.exports = (compound)->
  
  compound.cron.daemonize_route 'namespace',
    route: 'api#cron_test'
    cronTime: '* * * * * *' # every second
    params: # params to pass the route
      test: true
    start: true # you want to automatically initiate this CronJob

  # for CronJobs besides routes
  task = ->
      # Runs every weekday (Monday through Friday)
      # at 11:30:00 AM. It does not run on Saturday
      # or Sunday.
      console.log "I am namespace2"
      
  compound.cron.job 'namespace2',
    cronTime: '00 30 11 * * 1-5'
    onTick: task
    start: false
    timeZone: "America/Los_Angeles"

  compound.cron.start 'namespace2'  # manually start the cron job
  compound.cron.stop 'namespace2'   # manually stop the cron job
