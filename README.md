# FlightPub-Group1-2015

Ensure all dependancies are installed

- Ruby
- Rails
- NodeJS
- npm
- postgre
- etc ....

You'll need to set up a working postgre instance to have database access, you are then free to init the
database using the rails/rake console (see documentaion)

Ensure that you have set up a user with access details matching that in the config file
Make sure that you run bundle install to get all of the gems that we will need

To make sure that Ember works, you'll need to ensure npm is installed as well as bower. Once you have done this, run 'bower install' which will grab all of the dependancies that Ember relies on

To start the front end, run 'ember serve' from the Ember app root folder
To start the backend, run 'rails s' from the Rails app root folder

Branches
- master: Only merge to this branch when we have significant features to add
- development: The branch to merge to when we have fully implemented functions. Acts as the bridge between f-end, b-end
  - front-end: Current work on the front end
  - back-end: Current work on the backend
