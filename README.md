Description
===========
Installs Duo Unix 2-factor authentication. Currently tested (barely) on Debian 7.0 x32, Ubuntu 12.04 x32 Server, Ubuntu 12.10 x32 Server

Where available this cookbook installs from Duo Security's pre built apt repository on Ubuntu/Debian. Otherwise it will build from source.

Using the OpenSSH cookbook to manage ssh configuration means that only the sshd attributes defined in this cookbook or elsewhere will will end up in sshd_config. This can cause unexpected behaviour.

This cookbook uses Test Kitchen to run ServerSpec tests.

Requirements
============

## Cookbooks

* Opscode [OpenSSH](https://github.com/opscode-cookbooks/openssh) cookbook

## Platform:

* Debian/Ubuntu

Attributes
==========
See the [Duo Unix documentation](https://www.duosecurity.com/docs/duounix) for details on required attributes, and see `attributes/default.rb` for set defaults.

Minimum requirements for this recipe are:

* `node['duo_unix']['conf']['integration_key']` - Your Duo Unix integration key
* `node['duo_unix']['conf']['secret_key']` - Your Duo Unix integration secret key
* `node['duo_unix']['conf']['api_hostname']` - Your Duo Unix integration api hostname

To force the recipe to build from source set:

* `node['duo_unix']['from_source'] = true`

To set up pam_duo set:
* node['duo_unix']['conf']['pam_enable'] = true`
If you wish to disable login_duo you must also set:
* node['duo_unix']['conf']['login_duo_enable'] = false`

PAM Note
--------
Because you might not want to use Duo Security PAN with ssh and because testing
PAM configurations is complex this cookbook does not attempt to modify your
system PAM settings or enable PAM in sshd_config. 

For PAM authentication to function fully you should configure PAM and sshd in 
your wrapper cookbook.

Refer to the [PAM configuration](https://www.duosecurity.com/docs/duounix#pam-configuration) Duo Security Guide.
Typically you will need add pam_duo to the relevant PAM configuration file like:
`auth required pam_duo.so`

To enable sshd to use PAM you can override the openssh cookbook variables.
Set the following in your wrapper cookbook:
* node.override['openssh']['server']['challenge_response_authentication'] = 'yes'
* node.override['openssh']['server']['use_pam'] = 'yes'
* node.override['openssh']['server']['use_dns'] = 'no'

Usage
=====

Complete the 'first steps' as described in the [Duo Unix documentation](https://www.duosecurity.com/docs/duounix). 

	{    "run_list":[
		"recipe[duo_unix]"
       ],
     "duo_unix": {
     	"conf" :{
     	"integration_key" : "YOUR_INTEGRATION_KEY",
     	"secret_key" : "YOUR_SECRET_KEY",
     	"api_hostname" : "YOUR_API_HOSTNAME"
    	 }
 		}
	 }

License and Author
==================

- Author:: Hung Truong (<hung@hung-truong.com>)

Copyright:: 2013 Hung Truong

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
