# Facturation

Simple tool to generate pdf invoice with yaml, moustache and markdown

## Install

    gem install moustache
    gem install yaml-lint
    gem install rake
    [Pandoc - Installing](http://pandoc.org/installing.html)

## Usage
    # generate an invoice
    vim data/client-2016-05.yaml
    rake generate


## Roadmap
- add argument to generate a specific invoice
- generate invoice for every yaml
- generate yaml from default with company infomation
- Calculate total
- Calculate due date
- generate yearly report in csv md and pdf
- generate template directory
- use the mustache librairy instead of the gem cli
- add configuration file
- Doc readme, ghpages, mdwiki
- remove dependencie from pandoc
- add gem file
- add i18n add english template and option to choose language
- add cucumer feature
- refactor cli interface from rake to gli
- package as a gem


