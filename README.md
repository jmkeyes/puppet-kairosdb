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

## Todo

  * Nothing to note yet.
