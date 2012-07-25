Description
===========

This cookbook provides to install and configuring the utility Cgroups

Requirements
============

OS : Red Hat Enterprise Linux Server release 6.2 (Santiago)

Attributes
==========

* default['cgroups']['controllers'] = [ "memory" , "cpu"  ]
* default['cgroups']['group_name'] =  "foobar"
* default['cgroups']['parameters'] = [              "memory.limit_in_bytes = 256M",
                                                  "memory.memsw.limit_in_bytes = 256M" ]
* default['cgroups']['task-uid'] =  "root"
* default['cgroups']['task-gid'] =  "root"
* default['cgroups']['admin-uid'] = "root"
* default['cgroups']['admin-gid'] = "root"
* default['cgroups']['users'] = [ "root" ]
* default['cgroups']['command'] = "/opt/myprogram/bin/mycommand"
* default['cgroups']['service'] = "fooService"


Template
==========

* cgconfig.conf.erb  

the configuration file /etc/cgconfig.conf

* cgrules.conf.erb

the configuration file /etc/cgrules.conf

At moment this cookbook has some limitations.

1. is not possible configure more groups
2. is not possible configure  for users some different controllers..  but work in progress.

Usage
=====

1. after launch cgroups recipe check ` cat /cgroup/memory/myfoogroup/tasks ` you should see the PIDs of your target processes
2. after a change in /etc/cgconfig.conf or  /etc/cgrules.conf the recipe restarts a specify service (only if that service exists)



