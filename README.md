# ansible-ARO

```
*******************************************************************
* 							                                      *
*  This project is provided as-is, and is not an official or      *
*  Supported Red Hat project. We will happily accept issues and   *
*  Pull Requests and provide basic OSS level community support    *
*******************************************************************
```

This project contains a set of modules for working with ARO as well as some example playbooks.

Will create/delete ARO clusters but if you know how to work ansible inventories, it can do multiple clusters.

It has been tested on Linux.  MacOS users will hopefully work, but Ansible support for Windows is not great.

## Log in to Azure

Use the `az` cli to log in to Azure and get a local set of tokens that ansible will use.

```bash
az login
```

## Deploy a Cluster with ansible in a virtualenv

### Prepare Ansible

Create python virtualenv:

```bash
make virtualenv
```

### Deploy a cluster

```bash
make create
```

### Delete a cluster

```bash
make delete
```

## Fix pull secret and operatorhub with ansible in a virtualenv

### Create python virtualenv:

```bash
make virtualenv
```

### Fix Pull Secret and populate operatorhub

```bash
make pull-secret
```
