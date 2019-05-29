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

### CREATE A User

#### In order to create a User, you must have a request body with the following syntax:

#### Request Body:
```
{
  name: <STRING for NAME of User>,
  email: <STRING for UNIQUE email>,
  password: <STRING for PASSWORD>,
  password_confirmation: <STRING for PASSWORD CONFIRMATION>
}
```
#### Note: You MUST have a body with a name, unique email and a password. The password MUST match the password_confirmation. In the response a randomly generated user api_key will be returned.

#### Example:
```
{
  name: "Jim",
  email: 'email@email.com',
  password: '1',
  password_confirmation: '1'
}
```
#### A POST request must be made with the body and a user id in the query params to the following:

```
POST /users
```

### LOGIN/AUTHENTICATE a User

#### In order to authenticate and get a User, you must have a request body with the following syntax:

#### Request Body:
```
{
  email: <STRING for email>,
  password: <STRING for PASSWORD>
}
```
#### Note: You MUST have a body with an email and a password. The email/password combo MUST match. In the response the user will be returned with their name and api_key.

#### Example:
```
{
  email: 'email@email.com',
  password: '1'
}
```

#### A POST request must be made with the body to the following:

```
POST /login
```

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

### CREATE a New Routine

#### In order to create a routine, a request body must be made with the following syntax:

#### Request Body:
```
{
  name: <ROUTINE NAME as a STRING>,
  exercises: <ARRAY of EXERCISE IDS AS INTEGERS>
}
```
#### Note: The name is REQUIRED, but the exercises are OPTIONAL. A routine can be made with or without a list of desired exercises to be included. The name however, MUST be in the request body.

#### Example:
```
{
  name: "Leg Day",
  exercises: [1, 3, 56, 345]
}
```

#### A POST request must be made with the body and a user id in the query params to the following:

```
POST /routines?user_id=<USER ID>&api_key=<USERS API KEY>
```
```
Example: /routines?user_id=2&api_key=123456789
```

### UPDATE a Routine

#### In order to update a routine, a request body must be made with the following syntax:

#### Request Body:
```
{
  name: <NEW name as a STRING>
}
```
#### Note: The name is REQUIRED.

#### Example:
```
{
  name: "Leg Day 2.0"
}
```

#### A PUT request must be made with the body and the id of the the routine being updated to the following:

```
PUT /routines/:id
```
```
Example: /routines/1
```

### ADD an Exercise to a Routine

#### In order to add an exercise to a routine, a request body must be made with the following syntax:

#### Request Body:
```
{
  exercise_id: <EXERCISE ID INTEGER HERE>,
  routine_id: <ROUTINE ID HERE>
}
```
#### Note: Both the exercise id and the routine id is required to add the exercise to the routine

#### Example Request Body:
```
{
  exercise_id: 3,
  routine_id: 5
}
```

#### A POST Request must be made with the body to the following:

```
POST /exercise_routines
```

### REMOVE an Exercise from a Routine

#### In order to remove an exercise from a routine, you must have the exercise_routine id handy and make a DELETE request to the following:

```
DELETE /exercise_routines/:id
```
```
Example: /exercise_routines/2
```

### DELETE a Routine

#### In order to delete a routine, you will need the routine id handy, and simply make a DELETE request to:

```
DELETE /routines/:id
```

```
Example: /routines/1
```

### GET All SCHEDULED Routines A User Has On A Date

#### In order to get all scheduled routines on a given date for a user, with the included exercises, make a GET request to:

```
GET /my_routines?date=<DATE REQUESTED>&user_id=<SPECIFIC USER ID>&api_key=<USER SPECIFIC API KEY>
```
```
Example: /my_routines?date=2019-05-22&user_id=1&api_key=0987654321
```

#### Note: both a date and an id MUST be included as query parameters in order to get a valid response. This will return an array of routines with the included exercises and relevant information.

### SCHEDULE A Routine On A Day For A User

#### In order to schedule a routine on a particular day for a user, a request body must be provided with the following syntax:


#### Request Body:
```
{
  date: <DATE OF DESIRED SCHEDULING>,
  routine_id: <ID OF ROUTINE BEING SCHEDULED>,
  user_id: <ID OF USER SCHEDULING>,
  api_key: <API KEY OF USER SCHEDULING>
}
```

#### Example:
```
{
  date: "2019-05-22",
  routine_id: 2,
  user_id: 1,
  api_key: '123456789'
}
```

#### A POST request must be made with the body to the following:

```
POST /my_routines
```

### UNSCHEDULE A Routine From A Day For A User

#### In order to unschedule a routine on a particular day for a user, you will need the routine's id handy and the user's id, and make a DELETE request to:

```
DELETE /my_routines?routine_id=<ROUTINE ID>&user_id=<USER ID>&date=<DATE YYYY-MM-DD>&api_key=<USER API KEY>
```
```
Example: /my_routines?routine_id=3&user_id=23&date=2019-05-29&api_key=12345678
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
- [Tim Allen](https://github.com/timnallen)
- [Eric Fitzsimons](https://github.com/ericfitzsimons451)
- [Jake Admire](https://github.com/JakeAdmire)
- [David Cisneros](https://github.com/developingdavid)

## Schema Design

## Tech Stack List
- Ruby
- Rails
- Postgresql
---
**[Back to Top](https://github.com/timnallen/BE-GetSwole/blob/master/README.md)**
