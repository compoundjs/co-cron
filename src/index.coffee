Wrapper = require './classes/cron_wrapper'
  
exports.init = (compound)->
  compound.cron = new Wrapper compound
  compound.emit 'cron', compound.cron
