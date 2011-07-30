# Showcase #
Showcase is a simple Portfolio/Resume application for your professional web presence.
Present your resume and projects in a nice and easy way on the web.
The application is based on Sinatra and uses YAML files as data store.

Copyright © 2011, Nik Wolfgramm

## Features ##
- support for resume, contact details and project-portfolio
- multi language support
- easy configuration over YAML files for data storage
- edit your resume using markdown
- page caching in production

## Installation ##
### clone the showcase git project ###

`git clone git://github.com/niwo/showcase.git`

### install the dependencies with bundler ###

`cd showcase`

`bundle install`

### copy the sample config file ###
`cp config.example.yml config.yml`

### let's start the show ###

`ruby application.rb`

## Fill in data ##

### Personal ###
Edit the file __data/personal.yml__

### Resume ###
Edit the file __data/resumes.yml__ and add a markdown file for the resume in your language(s), i.e. __data/resume.en.md__

### Projects ###
Edit the file __data/projects.yml__

### Pictures ###
Add your personal picture under __public/pictures/personal/__ and projects pictures under __public/pictures/projects/__
