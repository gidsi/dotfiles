ssh_client
==========

Install and configures ssh

Requirements
------------

* archlinux

Role Variables
--------------

* ssh_client_config_folder (optional, default: '~/.ssh')
    * path to the ssh config folder

Dependencies
------------

none

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: ssh_client }

License
-------

BSD

Author Information
------------------

github.com/gidsi
