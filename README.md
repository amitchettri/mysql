mysql
===========================

This cookbook will install and configure MYSQL server

Supported OS
------------
1. CENTOS7

Requirements
------------
- Chef 12+

Attributes
----------
The following attributes are used for installation and configuration of mysql server

default['mysql']['rpm_package'] = 'mysql57-community-release-el7-9.noarch.rpm'
default['mysql']['port'] = 3300

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>rpm_package</tt></td>
    <td>String</td>
    <td><tt>RPM Package to configure repo</tt></td>
  </tr>
  <tr>
    <td><tt>port</tt></td>
    <td>Integer</td>
    <td><tt>Port number on which mysql service should run</tt></td>
  </tr>
</table>

Recipes
----------
This section describes the recipes in the cookbook.

**default**

default.rb recipe will do following steps
1. Configure repos for mysql installation. 
2. Install the mysql package
3. Configure the port number on which mysql should run
4. Start and enable the mysqld service

Usage
-----

Just include `mysql` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mysql]"
  ]
}
```

Testing
---------

##cookstyle 
Use cookstyle for lint testing

```
$ cd cookbooks/mysql

$ cookstyle .

Inspecting 7 files
.......

7 files inspected, no offenses detected

```

##Test Kitchen
Use test kitchen for integration testing using aws driver

```
kitchen test
```

Results:
```
  MySQL Configuration
     ✔  mysqld.port is expected to cmp == 3300
  Service mysqld
     ✔  is expected to be installed
     ✔  is expected to be enabled
     ✔  is expected to be running

Test Summary: 4 successful, 0 failures, 0 skipped

```

License and Authors
-------------------
Authors: Rakesh Korukonda

email: rakesh.korukonda@hpe.com

