[![Build Status](https://travis-ci.org/empowerhack/DrawMyLife-Service.svg?branch=master)](https://travis-ci.org/empowerhack/DrawMyLife-Service)

# Draw My Life API / Admin

**Draw My Life** is an open source, volunteer-led initiative in partnership with [Terre Des Hommes](terredeshommes.org), born at an [EmpowerHack](empowerhack.com) hackathon for refugee women and girls in 2016. The initiative consists of multiple, separate and inter-related projects aiming to improve mental health support for refugee children.

**This repository holds an API and administration system built with the [Ruby on Rails](http://rubyonrails.org/) framework for storing images and data collected by field workers during art therapy sessions.**

***Related pending projects include:***

* An advocacy tool that makes use of data collected here
* Extension of this API to integrate with the [Humanitarian Data Exchange (HDX)](https://data.humdata.org) using [HXL standards](hxlstandard.org)

To get an overview of the journey so far, you can view [these slides](https://slides.com/krissygoround/drawmylife). You can also chat to the team over at our [public channel in EmpowerHack's Slack](https://empowerhackteam.slack.com/messages/project_drawmylife/).


## Project Status/Timeline

**2016**

* **April**: ~~Initial Prototype of API / admin + mockups of advocacy tool~~
* **August**: Pilot the API / admin system



## Development Setup

- [Install Prerequisites](#install-prerequisites)
	- [About the Command Line](#about-the-command-line)
	- [Homebrew package manager](#homebrew-package-manager)
	- [Git version control](#git-version-control)
	- [Ruby](#ruby-v231)
	- [Postgres](#postgres)
	- [ImageMagick](#imagemagick)
- [Get Up and Running](#get-up-and-running)
	- [Run the app](#run-the-app)
	- [Debugging](#debugging)
	- [Running tests](#running-tests)
- [Deployment and Production Notes](#deployment-and-production-notes)

### Install Prerequisites

*NB: These installation instructions are catered for Mac OS X users. You will need to look up alternative installation methods for different operating systems or feel free to [chat to us on Slack](https://empowerhackteam.slack.com/messages/project_drawmylife/) for advice on how to get set up.*

#### About the Command Line

Most of these instructions require typing commands into your shell prompt (if you're new to this, [this is a nice beginner tutorial](https://www.codecademy.com/learn/learn-the-command-line)). Whenever you see a box like this:

	$ echo "Hi! I'm a friendly command in your prompt."

these are commands you should type into your command line program, e.g. Terminal on a Mac. The $ represents a new line in your shell prompt, you need to type everything _after_ it.

#### Homebrew package manager

This is a package management system for Mac that help you install a lot of dev tools easily.

Follow the download instructions at [brew.sh](http://brew.sh/)

#### Git version control

[Git](https://www.codecademy.com/learn/learn-git) is the most popular tool for tracking changes to your project.  If you don't have a GitHub account, [set one up now](https://help.github.com/articles/signing-up-for-a-new-github-account/). Then install git locally:

	$ brew install git

#### Ruby (v2.3.1)

There are many methods for installing Ruby which you can explore [here](https://www.ruby-lang.org/en/documentation/installation/). We recommend installing using a version manager. The instructions below use [rbenv](https://github.com/rbenv/rbenv). *NB: It's always good to check official READMEs of external tools for detailed and up-to-date instructions.*

**Installing with rbenv (via homebrew):**

    $ brew install rbenv ruby-build
    $ rbenv init
    $ rbenv install 2.3.1

#### Bundler

You'll use this to [manage gems](http://www.knicklabs.com/my-rubygems-toolbox-part-1/) installed under your version/s of Ruby or specified in your project. Note if you're using a version manager like rbenv, you need to reinstall gems for each different version of ruby you switch to and you can see what gems are currently installed for your version of Ruby with the command `$ gem list`. Bundler can be installed as a gem itself (I know, meta right?):

	$ gem install bundler

#### Postgres

We use Postgres for all our database needs. Download the latest version in a single package from [PostgresApp](http://postgresapp.com/).

You can also set up your path to use tools directly on your command line as per [these docs](http://postgresapp.com/documentation/cli-tools.html):

    $ echo 'export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin' >> ~/.bash_profile

*Create your development and test databases*

		$ createdb drawmylife_development
		$ createdb travis_ci_test

#### ImageMagick

For image uploads, you'll need [ImageMagick](https://github.com/ImageMagick/ImageMagick) installed. You can install nice and easily using our friend Homebrew:

	$ brew install imagemagick


### Get Up and Running

#### Run the app

Clone the repository on GitHub:

	$ git clone git@github.com:empowerhack/DrawMyLife-Service

Enter your new project folder:

	$ cd DrawMyLife-Service

***The following steps should be done now any time you pull new changes in from the remote:***

Install all the dependencies from your Gemfile using Bundler:

	$ bundle install

Run any database migrations:

	$ bundle exec rake db:migrate

Run the Rails server:

	$ bundle exec rails s


**You should now be able to access the app in your browser at [localhost:3000](http://localhost:3000)**!


#### Debugging

To run commands, queries and play around in the Rails console (in a new shell):

	$ bundle exec rails c

Also, in the shell window you ran the actual server, you can see request logs as you navigate the site. If you stick the `byebug` command anywhere in the codebase, it will pause any request and give you an interactive shell to step through the process, inspect variables etc.


#### Running Tests

We will be using [rspec](http://rspec.info/) for tests. To run all tests, from your project's root, run:

	$ bundle exec rspec spec

Or for just one set of tests:

	$ bundle exec rspec spec/models/drawing_spec.rb


### Deployment and Production Notes

Draw My Life is currently hosted on [Heroku](https://www.heroku.com/), with images automagically hosted on a free tier [Amazon Simple Storage Service (S3)](https://aws.amazon.com/documentation/s3/) instance. The `.env.production.example` file holds a template of the ENV vars required to be set on the live production environment.

Please ask the team for details if you need deployment instructions.
