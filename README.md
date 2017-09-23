# httpd

A demo Chef cookbook that sets up Apache httpd on a CentOS machine.

The cookbook includes three recipes:
- `recipe[httpd::default]` &mdash; installs and starts only the core `httpd` stuff. No HTTPS will be available.
- `recipe[httpd::ssl]` &mdash; meant to be used after the `default` recipe. Installs `mod_ssl`, places a certificate from a data bag item and a private key from a Chef Vault item. By default it retrieves the certficate from an item named `#{node.name}` (server hostname) inside the `certificates` data bag. It fetches the private key from a Chef Vault item named `#{node.name}` (server hostname) from the data bag `private_keys`.
- `recipe[httpd::remove]` &mdash; ensures that everything created by `default` and `ssl` recipes are removed.

## Test Kitchen / InSpec tests

There are three Test Kitchen scenarios tested with InSpec:
- __default__: `default` recipe (without HTTPS)
- __https__: `default` + `ssl` recipes
- __remove__: provisions the __https__ scenario and uninstalls everything afterwards

See it run:

```
$ chef exec kitchen test default
```

```
$ chef exec kitchen test https
```

```
$ chef exec kitchen test remove
```

## ChefSpec tests

```
$ chef exec rspec
```
