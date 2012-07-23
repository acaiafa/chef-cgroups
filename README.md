Description
===========

This cookbook provide to install and configuring the utility Cgroups

Requirements
============

OS : Red Hat Enterprise Linux Server release 6.2 (Santiago)

Attributes
==========

#array of controllers
default['cgroups']['controllers'] = [ "memory" , "cpu"  ]

#the name of cgroup
default['cgroups']['group_name'] =  "foobar"

default['cgroups']['parameters'] = [              "memory.limit_in_bytes = 256M",
                                                  "memory.memsw.limit_in_bytes = 256M"
 												]

default['cgroups']['task-uid'] =  "root"
default['cgroups']['task-gid'] =  "root"
default['cgroups']['admin-uid'] = "root"
default['cgroups']['admin-gid'] = "root"
default['cgroups']['users'] = [ "root" ]

#the process controlled by cgroups
default['cgroups']['command'] = "/opt/myprogram/bin/mycommand"

#put a name of service if you want rester a specific service after the configuration
default['cgroups']['service'] = "VRTSralus.init"


Usage
=====



