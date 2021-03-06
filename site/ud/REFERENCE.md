# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`ud::cert`](#udcert): Obtain LetsEncrypt certificate
* [`ud::container::host`](#udcontainerhost): Configure host to be capable of running containers via `podman`
* [`ud::mysql::server`](#udmysqlserver): Configure MySQL server
* [`ud::package::base`](#udpackagebase): Base functionality for `ud::package`
* [`ud::php::server`](#udphpserver): Configure a PHP application server
* [`ud::postgresql::server`](#udpostgresqlserver): Configure PostgreSQL server
* [`ud::profile::apache`](#udprofileapache): Configure the Apache web server
* [`ud::profile::base`](#udprofilebase): Common base profile applied to all machines
* [`ud::profile::puppet::master`](#udprofilepuppetmaster): Configure Puppet master
* [`ud::profile::suitecrm`](#udprofilesuitecrm): Configure a default standalone SuiteCRM instance
* [`ud::role::puppet::master`](#udrolepuppetmaster): Puppet master role
* [`ud::suitecrm::server`](#udsuitecrmserver): Configure a SuiteCRM server
* [`ud::user::base`](#uduserbase): Base functionality for `ud::user`

**Defined types**

* [`ud::config`](#udconfig): Apply values to configuration files using Augeas
* [`ud::config::lookup`](#udconfiglookup): Apply values to configuration files using Augeas and a lookup hash
* [`ud::container`](#udcontainer): Configure a `podman` container to run as a `systemd` service
* [`ud::database`](#uddatabase): Configure database
* [`ud::groupmember`](#udgroupmember): Manage group membership
* [`ud::mysql::database`](#udmysqldatabase): Configure MySQL database
* [`ud::mysql::localuser`](#udmysqllocaluser): Configure MySQL for operating system local users
* [`ud::mysql::server::database`](#udmysqlserverdatabase): Configure MySQL database on database server
* [`ud::mysql::server::peerauth`](#udmysqlserverpeerauth): Configure MySQL peer authentication
* [`ud::mysql::server::user`](#udmysqlserveruser): Configure MySQL user on database server
* [`ud::mysql::user`](#udmysqluser): Configure MySQL user
* [`ud::package`](#udpackage): Install a package
* [`ud::postgresql::database`](#udpostgresqldatabase): Configure PostgreSQL database
* [`ud::postgresql::localuser`](#udpostgresqllocaluser): Configure PostgreSQL for operating system local users
* [`ud::postgresql::server::database`](#udpostgresqlserverdatabase): Configure PostgreSQL database on database server
* [`ud::postgresql::server::default_grant`](#udpostgresqlserverdefault_grant): Set PostgreSQL default privileges
* [`ud::postgresql::server::peerauth`](#udpostgresqlserverpeerauth): Configure PostgreSQL peer authentication
* [`ud::postgresql::server::user`](#udpostgresqlserveruser): Configure PostgreSQL user on database server
* [`ud::postgresql::user`](#udpostgresqluser): Configure PostgreSQL user
* [`ud::suitecrm`](#udsuitecrm): Configure a standalone SuiteCRM instance
* [`ud::user`](#uduser): Create a local user

**Functions**

* [`ud::database::password`](#uddatabasepassword): Construct a database password
* [`ud::hashlookup`](#udhashlookup): Look up a (possibly empty) hash in Hiera

## Classes

### ud::cert

This is intended to be included automatically by manifests that
define the mechanism used for certificate renewal, such as
[`ud::profile::apache`](#udprofileapache).  You should not need to
use this resource class directly.

#### Parameters

The following parameters are available in the `ud::cert` class.

##### `aliases`

Data type: `Array[String]`

Fully qualified DNS names to be included within the certificate

Default value: []

##### `deploy_hook_commands`

Data type: `Array[String]`

Commands to be run after a certificate deployment

Default value: []

##### `webroot`

Data type: `Optional[String]`

Web root directory (for when using the webroot plugin)

Default value: `undef`

##### `group`

Data type: `String`

Group granted access to the certificate's private key

Default value: 'certkeys'

##### `mode`

Data type: `String`

Access mode (e.g. '0640') for the certificate's private key

Default value: '0640'

### ud::container::host

This is intended to be included automatically by manifests that
require the ability to run containers such as
[`ud::container`](#udcontainer).  You should not need to use this
resource class directly.

### ud::mysql::server

Configure MySQL server

### ud::package::base

This is included automatically by [`ud::package`](#udpackage).  You should
not need to use this class directly.

### ud::php::server

Configure a PHP application server

#### Parameters

The following parameters are available in the `ud::php::server` class.

##### `version`

Data type: `String`

PHP version

Default value: '7.4'

### ud::postgresql::server

Configure PostgreSQL server

### ud::profile::apache

This is intended to be invoked automatically by
[`ud::profile::base`](#udprofilebase) based on the YAML dictionary
[`ud::web`](WEB.md).  You should not need to use this resource class
directly.

#### Parameters

The following parameters are available in the `ud::profile::apache` class.

##### `aliases`

Data type: `Array[String]`

Fully qualified DNS names to be added to the TLS certificate.

Default value: []

##### `docroot`

Data type: `Optional[String]`

Document root for static files.

Default value: `undef`

##### `app_path`

Data type: `Optional[String]`

Relative URL path for a web application configured via a drop-in
Apache configuration file.

Default value: `undef`

##### `app_port`

Data type: `Optional[Integer]`

Port number for a web application configured to run as a service
listening for HTTP connections to `localhost` on a non-standard
port.

Default value: `undef`

##### `vhost`

Data type: `Hash`

Additional virtual host configuration parameters passed through
directly to the `apache::vhost` Puppet class.

Default value: {}

### ud::profile::base

This profile is applied automatically to all machines.  It is used
to give effect to various automagical YAML parameters such as
[`ud::users`](USERS.md) and [`ud::packages`](PACKAGES.md).

### ud::profile::puppet::master

See the [design document](PUPPET.md) for detailed information.

#### Parameters

The following parameters are available in the `ud::profile::puppet::master` class.

##### `repo`

Data type: `Optional[String]`

Local Puppet repository name

Default value: $facts['puppet_repo']

### ud::profile::suitecrm

Configure a default standalone SuiteCRM instance

### ud::role::puppet::master

Puppet master role

### ud::suitecrm::server

This is intended to be invoked automatically by
[`ud::suitecrm`](#udsuitecrm).  You should not need to use this
class directly.

### ud::user::base

This is included automatically by [`ud::user`](#uduser).  You should
not need to use this class directly.

## Defined types

### ud::config

Take a hash mapping Augeas-style paths to configuration values
(e.g. `'/etc/ssh/sshd_config/PasswordAuthentication' => 'no'`), and
use Augeas to apply each value to each path in a single operation.

The [`ud::lenses`](LENSES.md) YAML dictionary may be used to define
Augeas lenses to be applied for non-standard filename patterns.  For
example:

```yaml
ud::lenses:
  ini:
    - /etc/myyapp.ini
  json:
    - /etc/myapp/*.json
```

#### Examples

##### Disable SSH password authentication

```puppet
ud::config { "sshpw":
  '/etc/ssh/sshd_config/PasswordAuthentication' => 'no',
  '/etc/ssh/sshd_config/ChallengeResponseAuthentication' => 'no',
}
```

#### Parameters

The following parameters are available in the `ud::config` defined type.

##### `values`

Data type: `Hash`

Hash mapping Augeas-style paths to configuration values

### ud::config::lookup

Take a hash mapping Augeas style paths to lookup keys
(e.g. `'/etc/myapp.ini/db/password' => 'password'`) and a second
hash mapping lookup keys to values (e.g. `'password' =>
'supersecret'`), and use Augeas to apply the looked-up value to each
path in a single operation.

This allows a manifest to construct a hash of configuration values
(such as database connection parameters) and apply these
configuration values to arbitrary custom file formats.

As with [`ud::config`](#udconfig), the [`ud::lenses`](LENSES.md)
YAML dictionary may be used to define Augeas lenses to be applied
for non-standard filename patterns.

#### Examples

##### Database passwords

```puppet
ud::config::lookup { "database passwords":
  paths => {
    '/etc/myapp.ini/db/user' => 'username',
    '/etc/myapp.ini/db/password' => 'password',
  },
  values => {
    'username' => 'dbuser',
    'password' => 'supersecret',
  },
}
```

#### Parameters

The following parameters are available in the `ud::config::lookup` defined type.

##### `paths`

Data type: `Hash`

Hash mapping Augeas-style paths to lookup keys

Default value: {}

##### `values`

Data type: `Hash`

Hash mapping lookup keys to configuration values

Default value: {}

### ud::container

This is intended to be invoked automatically by
[`ud::profile::base`](#udprofilebase) based on the YAML dictionary
[`ud::containers`](CONTAINERS.md).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::container` defined type.

##### `image`

Data type: `String`

Container image name

Default value: $name

##### `command`

Data type: `String`

Container startup command

Default value: ''

##### `description`

Data type: `Optional[String]`

`systemd` service description

Default value: "${name} container"

##### `ports`

Data type: `Array[Variant[Integer, String]]`

List of exposed port mappings

Default value: []

##### `environment`

Data type: `Hash`

Dictionary of environment variables

Default value: {}

##### `volumes`

Data type: `Hash`

Dictionary of volumes

Default value: {}

##### `cert`

Data type: `Boolean`

Allow container to access host TLS certificate

Default value: `false`

##### `wrappers`

Data type: `Hash`

Dictionary of host commands to map to container commands

Default value: {}

### ud::database

Configure a database with three users: an owner (with full access),
a writer (with the ability to change data), and a reader (with the
ability only to read existing data).

#### Parameters

The following parameters are available in the `ud::database` defined type.

##### `name`

Database name

##### `type`

Data type: `Enum['postgresql', 'mariadb', 'mysql']`

Database type

Default value: 'postgresql'

##### `server`

Data type: `String`

Database server

Default value: $::fqdn

##### `owner_name`

Data type: `String`

Database owner user name

Default value: $name

##### `owner`

Data type: `Hash`

Configuration file paths in which to save owner connection information

Default value: {}

##### `writer_name`

Data type: `String`

Database writer user name

Default value: "${name}_writer"

##### `writer`

Data type: `Hash`

Configuration file paths in which to save writer connection information

Default value: {}

##### `reader_name`

Data type: `String`

Database reader user name

Default value: "${name}_reader"

##### `reader`

Data type: `Hash`

Configuration file paths in which to save reader connection information

Default value: {}

### ud::groupmember

Puppet's resource model for group memberships is, quite simply,
moronic.  It provides no sensible way to express the concept "user A
(which is not managed by Puppet) should be a member of group B
(which is not managed by this manifest)".

Provide this shell script monstrosity as a workaround.

#### Parameters

The following parameters are available in the `ud::groupmember` defined type.

##### `user`

Data type: `String`

User name

##### `group`

Data type: `String`

Group name

### ud::mysql::database

This is intended to be invoked automatically by
[`ud::database`](#uddatabase).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::mysql::database` defined type.

##### `name`

Database name

##### `server`

Data type: `String`

Database server FQDN

Default value: $::fqdn

##### `owner`

Data type: `String`

Database owner user name

Default value: $name

##### `owner_configs`

Data type: `Hash`

Configuration file paths in which to save owner connection information

Default value: {}

##### `writer`

Data type: `String`

Database writer user name

Default value: "${name}_writer"

##### `writer_configs`

Data type: `Hash`

Configuration file paths in which to save writer connection information

Default value: {}

##### `reader`

Data type: `String`

Database reader user name

Default value: "${name}_reader"

##### `reader_configs`

Data type: `Hash`

Configuration file paths in which to save reader connection information

Default value: {}

### ud::mysql::localuser

This is intended to be invoked automatically by
[`ud::mysql::user`](#udmysqluser).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::mysql::localuser` defined type.

##### `name`

Operating system local user name

##### `sudo`

Data type: `Boolean`

User is privileged

##### `home`

Data type: `String`

User home directory

### ud::mysql::server::database

This is intended to be invoked automatically by
[`ud::mysql::database`](#udmysqldatabase).  You should not need to
use this defined type directly.

#### Parameters

The following parameters are available in the `ud::mysql::server::database` defined type.

##### `name`

Database name

### ud::mysql::server::peerauth

Configure MySQL to permit passwordless peer authentication for an
operating system local user, with full access to a specified list of
databases.

#### Parameters

The following parameters are available in the `ud::mysql::server::peerauth` defined type.

##### `name`

Operating system local user name

##### `databases`

Data type: `Array[String]`

List of databases

Default value: []

### ud::mysql::server::user

This is intended to be invoked automatically by
[`ud::mysql::user`](#udmysqluser).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::mysql::server::user` defined type.

##### `name`

User name

##### `database`

Data type: `String`

Database name

##### `password`

Data type: `String`

User password

##### `privileges`

Data type: `Array[String]`

Privileges to be granted by default on new objects

Default value: ['ALL']

### ud::mysql::user

This is intended to be invoked automatically by
[`ud::mysql::database`](#udmysqldatabase).  You should not need to
use this defined type directly.

#### Parameters

The following parameters are available in the `ud::mysql::user` defined type.

##### `name`

User name

##### `database`

Data type: `String`

Database name

##### `server`

Data type: `String`

Database server FQDN

Default value: $::fqdn

##### `privileges`

Data type: `Optional[Array[String]]`

Privileges to be granted by default on new objects

Default value: `undef`

##### `configs`

Data type: `Hash`

Configuration file paths in which to save connection information

Default value: {}

### ud::package

This is intended to be invoked automatically by
[`ud::profile::base`](#udprofilebase) based on the YAML array
[`ud::packages`](PACKAGES.md).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::package` defined type.

##### `name`

Package name

##### `ensure`

Data type: `String`

Desired state ('present' or 'absent')

Default value: 'present'

### ud::postgresql::database

This is intended to be invoked automatically by
[`ud::database`](#uddatabase).  You should not need to use this
defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::database` defined type.

##### `name`

Database name

##### `server`

Data type: `String`

Database server FQDN

Default value: $::fqdn

##### `owner`

Data type: `String`

Database owner user name

Default value: $name

##### `owner_configs`

Data type: `Hash`

Configuration file paths in which to save owner connection information

Default value: {}

##### `writer`

Data type: `String`

Database writer user name

Default value: "${name}_writer"

##### `writer_configs`

Data type: `Hash`

Configuration file paths in which to save writer connection information

Default value: {}

##### `reader`

Data type: `String`

Database reader user name

Default value: "${name}_reader"

##### `reader_configs`

Data type: `Hash`

Configuration file paths in which to save reader connection information

Default value: {}

### ud::postgresql::localuser

This is intended to be invoked automatically by
[`ud::postgresql::user`](#udpostgresqluser).  You should not need to
use this defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::localuser` defined type.

##### `name`

Operating system local user name

##### `sudo`

Data type: `Boolean`

User is privileged

##### `home`

Data type: `String`

User home directory

### ud::postgresql::server::database

This is intended to be invoked automatically by
[`ud::postgresql::database`](#udpostgresqldatabase).  You should not
need to use this defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::server::database` defined type.

##### `name`

Database name

##### `owner`

Data type: `String`

Database owner user name

Default value: $name

### ud::postgresql::server::default_grant

The PostgreSQL Puppet module does not provide any way to handle
default permissions for as-yet-uncreated objects.

This is intended to be invoked automatically by
[`ud::postgresql::user`](#udpostgresqluser).  You should not need to
use this defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::server::default_grant` defined type.

##### `name`

Descriptive grant name

##### `database`

Data type: `String`

Database name

##### `owner`

Data type: `String`

Database owner name

##### `role`

Data type: `String`

Role for which to set default permissions

##### `privileges`

Data type: `Array[Enum[
    'SELECT',
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'REFERENCES',
    'TRIGGER',
    'CREATE',
    'CONNECT',
    'TEMPORARY',
    'EXECUTE',
    'USAGE'
  ]]`

List of privileges

Default value: []

##### `objtype`

Data type: `Enum[
    'TABLES',
    'SEQUENCES',
    'FUNCTIONS',
    'TYPES',
    'SCHEMAS'
  ]`

Object type

Default value: 'TABLES'

### ud::postgresql::server::peerauth

Configure PostgreSQL to permit passwordless peer authentication for
an operating system local user as a list of database users.

#### Parameters

The following parameters are available in the `ud::postgresql::server::peerauth` defined type.

##### `name`

Operating system local user name

##### `dbusers`

Data type: `Array[String]`

List of database users

Default value: []

##### `map`

Data type: `String`

Ident map name

Default value: 'ud'

### ud::postgresql::server::user

This is intended to be invoked automatically by
[`ud::postgresql::user`](#udpostgresqluser).  You should not need to
use this defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::server::user` defined type.

##### `name`

User name

##### `database`

Data type: `String`

Database name

##### `password`

Data type: `String`

User password

##### `owner`

Data type: `String`

Database owner user name

Default value: $name

##### `privileges`

Data type: `Optional[Array[String]]`

Privileges to be granted by default on new objects

Default value: `undef`

### ud::postgresql::user

This is intended to be invoked automatically by
[`ud::postgresql::database`](#udpostgresqldatabase).  You should not
need to use this defined type directly.

#### Parameters

The following parameters are available in the `ud::postgresql::user` defined type.

##### `name`

User name

##### `database`

Data type: `String`

Database name

##### `server`

Data type: `String`

Database server FQDN

Default value: $::fqdn

##### `owner`

Data type: `String`

Database owner user name

Default value: $name

##### `privileges`

Data type: `Optional[Array[String]]`

Privileges to be granted by default on new objects

Default value: `undef`

##### `configs`

Data type: `Hash`

Configuration file paths in which to save connection information

Default value: {}

### ud::suitecrm

Configure a standalone SuiteCRM instance

#### Parameters

The following parameters are available in the `ud::suitecrm` defined type.

##### `name`

Instance name

### ud::user

This is intended to be invoked automatically by
[`ud::profile::base`](#udprofilebase) based on the YAML dictionary
[`ud::users`](USERS.md).  You should not need to use this defined
type directly.

#### Parameters

The following parameters are available in the `ud::user` defined type.

##### `name`

User name

##### `ensure`

Data type: `String`

Desired state ('present' or 'absent')

Default value: 'present'

##### `sudo`

Data type: `Boolean`

User should be able to execute commands as root

Default value: `true`

##### `keys`

Data type: `Array[String]`

Optional list of SSH authorized keys

Default value: []

##### `groups`

Data type: `Array[String]`

Optional list of supplementary groups

Default value: []

## Functions

### ud::database::password

Type: Puppet Language

Construct a database password

#### `ud::database::password(String $database, String $user = $database, String $server = $::fqdn)`

The ud::database::password function.

Returns: `String` Password

##### `database`

Data type: `String`

Database name

##### `user`

Data type: `String`

User name

##### `server`

Data type: `String`

Database server FQDN

### ud::hashlookup

Type: Puppet Language

Look up a (possibly empty) hash in Hiera

#### `ud::hashlookup(String $key, Optional[Hash] $default = undef)`

The ud::hashlookup function.

Returns: `Optional[Hash]` Hash value

##### `key`

Data type: `String`

Lookup key

##### `default`

Data type: `Optional[Hash]`

Default value if not found

