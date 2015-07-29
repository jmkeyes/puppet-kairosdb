# Puppet KairosDB Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/jmkeyes/kairosdb.svg)](https://forge.puppetlabs.com/jmkeyes/kairosdb)
[![Build Status](https://travis-ci.org/jmkeyes/puppet-kairosdb.svg?branch=master)](https://travis-ci.org/jmkeyes/puppet-kairosdb)

#### Table of Contents

 1. [Overview](#overview)
 2. [Description](#description)
 3. [Todo](#todo)

## Overview

This is a Puppet Module to deploy and manage a KairosDB server.

## Description

To use this module, use either an include-like or resource-like declaration:

    # An include-like declaration for Hiera integration.
    include ::kairosdb

    # A resource-like declaration for manual overrides.
    class { '::kairosdb': }

This module is will also work with Puppet 4.x.

## Configuration

All configuration can be handled either through Hiera or by arguments to the `kairosdb` class.

## Examples

A stock KairosDB 0.9.4-6 without modifications (defaults):

    class { '::kairosdb':
      version => '0.9.4-6',
    }

The same thing, but explicitly using a slow development datastore:

    class { '::kairosdb':
      version => '0.9.4-6',
    }

    class { '::kairosdb::datastore::h2': }

Use an alternative datastore (Cassandra):

    class { '::kairosdb':
      version => '0.9.4-6',
    }

    class { '::kairosdb::datastore::cassandra':
      hosts => [
        '1.1.1.1:9160',
        '1.1.1.2:9160',
      ],
    }

Use a remote KairosDB as a datastore (like a forwarder):

    class { '::kairosdb':
      version => '0.9.4-6',
    }

    class { '::kairosdb::datastore::remote':
      remote_url => 'http://10.92.1.41:8080',
    }

## Todo

  * Nothing to note yet.
