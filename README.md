[![Build Status](https://travis-ci.org/empowerhack/DrawMyLife-Service.svg?branch=master)](https://travis-ci.org/empowerhack/DrawMyLife-Service)

![DML](https://cloud.githubusercontent.com/assets/574526/26177709/bfe9365e-3b52-11e7-8d05-eeef8f908fdc.png)

# Draw My Life API / Admin

**Draw My Life** is an open source, volunteer-led initiative in partnership with [Terre Des Hommes](terredeshommes.org) and  partners, born at an [EmpowerHack](empowerhack.com) hackathon for refugee women and girls in 2016. The initiative consists of multiple, separate and inter-related projects aiming to improve mental health support for refugee children.

[![Project Introduction](./app/assets/images/video-screenshot.png)](http://www.youtube.com/watch?v=chG9_jWdJL8 "Draw my Life project introduction")


**You can get an overview of DML projects on the [Project Definition](https://github.com/empowerhack/DrawMyLife-Service/wiki/1.-Project-Definition) wiki page. This specific repository is built with the [Ruby on Rails](http://rubyonrails.org/) framework and includes the following features:**

1) An administration system used by field workers to upload images and data from art therapy sessions ***- status: live, with  updates/improvement issues open***
2) A public API of this data (see [Apiary spec](http://docs.drawmylife.apiary.io/#)), ensuring anonymity and with respect to consent ***- in progress, issues open***
3) A JSON endpoint to integrate with the UN's [Humanitarian Data Exchange (HDX)](https://data.humdata.org) collating open data sources. This endpoint will expose data using [HXL standards](http://hxlstandard.org) and be used to create a separate HXL-formatted API via the open source [HXL Proxy](https://github.com/HXLStandard/hxl-proxy/wiki/Source-page) - (see [example Draw My Life Proxy API interface](https://proxy.hxlstandard.org/data/tZOYfb)). ***- in progress, issues open***

We also have a team website being built with Jekyll/React with open issues over at [empowerhack/DrawMyLife-Website](https://github.com/empowerhack/DrawMyLife-Website)

## Project Status/Timeline


**2017**

**Q2**: [Project Boards](https://github.com/empowerhack/DrawMyLife-Service/projects)  
[Milestones](https://github.com/empowerhack/DrawMyLife-Service/milestones)  


## For New Volunteers

* Say hi to the team on [Slack](https://empowerhackteam.slack.com/messages/project_drawmylife/)
* Read the starter [document](https://www.notion.so/Draw-My-Life-DML-Team-Info-a4ee64eb01cd445ea9f7a71ead5b5140)
* Check the [Project Sprint Boards](https://github.com/empowerhack/DrawMyLife-Service/projects) for issues in the **Pick Me Up** column. The boards are organised by goal. Open issues will typically have a milestone. We also have frontend-heavy project boards on our team website repository [empowerhack/DrawMyLife-Website](https://github.com/empowerhack/DrawMyLife-Website/projects).
* If creating a new issue to work on, please ensure the task is discrete (i.e. easily transferred to a new assignee), clearly described, and has no more than 3 labels. Ideally we should clearly separate UX/design and dev tasks.
* Follow the instructions below to set up (feel free to holler/submit a pull request if it looks out of date)

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
	- [Set up emails](#set-up-emails)
	- [Debugging](#debugging)
	- [Running tests](#running-tests)
- [Deployment and Production Notes](#deployment-and-production-notes)
	- [Staging environment](#staging-environment)

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

Copy the example development ENV vars to your own .env file:

	$ cp .env.development.example .env

***The following steps should be done now any time you pull new changes in from the remote:***

Install all the dependencies from your Gemfile using Bundler:

	$ bundle install

Set up your database and seed sample data (including admin users to log in and an API key!):

	$ bundle exec rake db:migrate
	$ bundle exec rake db:seed

Run the Rails server:

	$ bundle exec rails s


**You should now be able to access the admin app in your browser at [localhost:3000](http://localhost:3000). If you ran the database seed task you can log in with super_admin@example.com or admin@example.com (password is 'password')**!

### Try out the API

Once you've completed the steps above, you should also now be able to access the drawings API. The hypermedia API format is JSON HAL and is secured with very simple token access. You will need to pass a token through as a header with your request.

Find the seeded API key in your Rails console:

	$ APIKey.first.access_token


If this errors, you may not have run the seeds script yet. You can also generate one using:

	$ APIKey.create!

Using this token, make a request via cURL on the command line, e.g:

	$ curl http://localhost:3000/api/drawings.hal -H 'Authorization: Token token="cd1facb479c09638967c2dcf78d22d5b"'

*Note the .hal extension there ^*


### Set up emails

In development, emails are configured to send to localhost:1025. You can install the [mailcatcher](https://mailcatcher.me) gem for an interface to see these emails (follow instructions on the site and do not add this to the Gemfile!).


#### Debugging

To run commands, queries and play around in the Rails console (in a new shell):

	$ bundle exec rails c

Also, in the shell window you ran the actual server, you can see request logs as you navigate the site. If you stick the `byebug` command anywhere in the codebase, it will pause any request and give you an interactive shell to step through the process, inspect variables etc.


#### Running Tests

To ensure your test database is up-to-date, run:
	$ RAILS_ENV=test bundle exec rake db:reset

We will be using [rspec](http://rspec.info/) for tests. To run all tests, from your project's root, run:

	$ bundle exec rspec spec

Or for just one set of tests:

	$ bundle exec rspec spec/models/drawing_spec.rb

### Deployment and Production Notes

Draw My Life is currently hosted on [Heroku](https://www.heroku.com/), with images automagically hosted on a free tier [Amazon Simple Storage Service (S3)](https://aws.amazon.com/documentation/s3/) instance. The `.env.production.example` file holds a template of the ENV vars required to be set on the live production environment.

Please ask the team for details if you need deployment instructions.

#### Staging Environment

We have a staging environment set up which is auto-deployed to from the `staging` branch in GitHub. Pushing any changes to this branch will update the staging environment.

The staging environment is set up as a replica of the Production environment, hosted on Heroku using an Amazon Simple Storage (S3) instance for image storage.
