Co-Cron
====
* Basic module to manage CronJobs for your Compound.js Application
* Based on the excellent npm [cron](https://npmjs.org/package/cron) module
* Check it out for more documentation on Node.js cron implementation

Usage
-------------
```
npm install co-cron
```
* add 'co-cron' to your autoloaders
* Use the config/initializers/initialize.[js/coffee] to configure Cronjobs on start of an application
* You can manually create CronJobs or route automation at any time via the methods

Methods
--------------

**Cron_Wrapper#daemonize_route(namespace, options)**

  ```coffeescript
  compound.cron.daemonize_route 'test',
    route: 'api#test'
    params:
      example: true
    cronTime: '* * * * * *' # every second
    start: false
  ```

**Cron_Wrapper#job(namespace, options)**

A convience wrapper for cron's base CronJob creation method

**Cron_Wrapper#remove(namespace)**

Stops & removes a job stored on a namespace from the Cron_Wrapper.jobs object

**Cron_Wrapper#start(namespace)**

Starts a job stored on the namespace in the Cron_Wrapper.jobs object

**Cron_Wrapper#stop(namespace)**

Stops a job stored on the namespace in the Cron_Wrapper.jobs object
  

* checkout examples/
