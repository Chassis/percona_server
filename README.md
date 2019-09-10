# A Percona Server extension for Chassis
The Percona Server extension automatically sets up your Chassis instance to to use [Percona Server](https://www.percona.com/software/mysql-database/percona-server).

## Activation
Ensure you have a Chassis instance set up locally already.

```
# In your Chassis dir:
git clone --recursive https://github.com/Chassis/percona_server.git extensions/percona_server
```

Then you'll need to reprovision
```
cd ..
vagrant provision
```

Alternatively you can add the extension to one of your yaml config files. e.g.
```
# Extensions
#
# Install a list of extensions automatically
extensions:
    - chassis/percona_server
```

Then you'll need to reprovision

```
cd ..
vagrant provision
```

Percona Server has now been installed inside your Chassis box.
