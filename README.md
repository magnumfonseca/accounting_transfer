# Accounting Transfer

This project is an accounting system where each client has an account and can make transfers to other clients accounts. The client can also ask the current balance of his account. Consider that this bank only handles one type of currency that is brazilian Real (BRL).
This system works unda a API system, but also has an interface to make trades. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* postgres '9.6'
* ruby '2.3.4'
* rails '~> 5.1.3'

### Installing

Configure config/database.yml with your postgres settings and execute:
```
$ bin/setup
```
And then run to populate the database: 
```
$ rails db:seed
```

## Running tests

* APIs and requests were tested with rspec
```
  rspec spec
```
