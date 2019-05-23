# GetSwoleAPI

## Introduction

### This is a Backend application for GetSwole, an moblie application designed to help users schedule workout routines.
[GetSwole Frontend Repository](https://github.com/JakeAdmire/JA-DC-EF-TA--GetSwole.git) 

## Background/About
### This was the capstone project for Module 4 students at Turing School of Software and Design.  Teams of Backend and Frontend students were given 13 days to create a full-stack application from the ground up.  This project gave us further insight into how teams communicate and collaborate to make the development process flow smoothly.  

## Initial Setup

### If you would like to use the API in production mode, you can skip to the "How To Use" Section.

### If you want to interact with the repo on your local machine:
#### 1. Clone down the repo:
```
git clone git@github.com:timnallen/BE-GetSwole.git
```
#### 2. Install the dependencies in the Gemfile:

```
bundle install
```

#### Set up the database:

#### 1. Create and migrate:

```
rake db:{create,migrate}
```

#### 2. Import the exercises from the .csv file in the /lib directory:

```
rake import:exercises
```

#### 3. Seed the other db items in the seed file:

```
rake db:seed
```

#### 4. Run the code in development mode:

```
rails s
```

#### 5. Open your browser and visit http://localhost:3000

## Using the API

#### If you would like to use the development environment and see the code, read the walkthrough entitled: "Initial Setup", found above.

#### All endpoints adhere to the Fast JSON API standards

### Base URL 

```https://warm-cove-89223.herokuapp.com/api/v1```

### GET All Exercises

#### In order to get all exercises in the database, make a GET request to the following URI:

```
GET /exercises
```

#### This will return an array of the all the exercises in our database.


### GET Exercise by ID

#### In order to get a single exercise, you must have that exercise's id handy, and make a GET request to:


```
GET /exercises/<INSERT THE EXERCISE ID HERE>
```
```
Example: /exercises/1
```

#### This will return a single exercise.

### GET All Routines

#### In order to get all routines in the database, make a GET request to the following URI:

```
GET /routines
```

#### This will return an array of the all the routines in our database, but each routine will also include all exercises that are a part of that routine with the specific reps, sets, weights, and/or durations specific to that routine for a particular exercise.

### GET Routine by ID

#### In order to get a single routine, you must have that routine's id handy, and make a GET request to:

```
GET /routines/<INSERT THE ROUTINE ID HERE>
```
```
Example: /routines/1
```

#### This will return a single routine, with all included exercises.

### Getting All Routines A User Has Scheduled On A Date

#### In order to get all scheduled routines on a given date for a user, with the included exercises, make a GET request to:

```
GET /my_routines?date=<DATE REQUESTED>?id=<SPECIFIC USER ID>
```
```
Example: /my_routines?date=2019-05-22&id=1
```

#### Note: both a date and an id MUST be included as query parameters in order to get a valid response. This will return an array of routines with the included exercises and relevant information.

### Scheduling A Routine On A Day For A User

#### In order to schedule a routine on a particular day for a user, a request body must be provided with the following syntax:


#### Request Body:
```
{
  date: <DATE OF DESIRED SCHEDULING>,
  routine_id: <ID OF ROUTINE BEING SCHEDULED>,
  user_id: <ID OF USER SCHEDULING>
}
```

#### Example:
```
{
  date: "2019-05-22",
  routine_id: 2,
  user_id: 1
}
```

#### A POST request must be made with the body to the following:

```
POST /my_routines
```

## Running Tests

#### The Application uses [RSPEC](https://rspec.info/) as a testing suite. To run the test suite, after completing the steps from "Initial Set Up" above, simply run:

```
rspec
```

#### To check out test coverage after running the tests, you can run:

```
open coverage/index.html
```

#### This will open a file in your browser that will show details about test coverage.

## Contributors
- [Tim Allen](https://github.com/timallen)
- [Eric Fitzsimons](https://github.com/ericfitzsimons451)
- [Jake Admire](https://github.com/JakeAdmire)
- [David Cisneros](https://github.com/developingdavid)

## Schema Design

## Tech Stack List
- Ruby
- Rails
- Postgresql
