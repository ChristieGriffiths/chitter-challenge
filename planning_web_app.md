# Modelling and Planning a Web application

## Step 0: User stories or specification

```

As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter

As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order

As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made

As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter

As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitter

As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter

```

## Step 1: Planning pages

You'll have to adopt the perspective of a user browsing your website. What are the
different pages that they will use? How does the user navigate to these pages (links,
forms)?

At this point, it's good to do a small diagram of the different pages and their
relationship. If you want to do more complex mockups with the details of the elements on
the page, you can also do it, but it's not necessary to go into this level of detail for
this step.

Here's an example of how the user stories above can be planned. Note that this is only one
of the many possible flows that could be planned for these user stories.

![](./example-pages-planning.png)

## Step 2: Planning routes

Remember that a web application flow is all based on the HTTP request-response cycle, from
the web browser to the server application. You'll now need to draw your routes from the
pages you planned at the previous step.

This time, we're switching from the user perspective to the HTTP application engineer's
perspective - thinking of the application's behaviour in requests and responses, rather
than pages.

For example:

 * A page (such as the home page) is usually returned by a `GET` route. For example, the
   home page (which is almost always the first route you'll start with), is usually `GET
   /`.
 * If the user navigates to a different page using a link, you will need a `GET` route for
   this other page.
 * If the user submits a form that leads to a different page, you will need a `POST` route
   to submit this form to.

From the pages planned above, here are the routes we could plan. Once again, this is only
a possible list of routes for this case — you could come up with slightly different ones,
which would still satisfy the initial user stories.

```md
# Page: list of entries (aka the homepage)

## Request:
GET /
No parameters

## Response (200 OK)
HTML view with two buttons -> 'log in' or 'sign up'

```

```md
# Page: see full entry 

## Request:

GET /entries/:id
With path parameter :id

## Response (200 OK)
HTML view with details of a single entry
```

```md
# Page: add a new entry

## Request:
GET /login


## Response (200 OK)
HTML view with form to submit email address (to POST /confirm/login)
```

```md
# Page: add a new entry

## Request:
GET /sign_up

## Response (200 OK)
HTML view with form to submit email address and username (to POST /confirm/login)
```

```md
# Page: Confirm user's identity

## Request:
GET /confirm/login

## Response (200 OK)
HTML view with form to submit confirmation code user recieved via email (to POST /home)

```

```md
# Page: Confirm user's identity

## Request:
GET /confirm/signup

## Response (200 OK)
HTML view with form to submit confirmation code user recieved via email (to POST /home)

```

```md
# Page: Home page with options to: post a peep, (automatically shows you peep history from all users) with option to reverse order those peeps by time they were posted, and log out option which takes you to get /

## Request:
POST /peep
With parameters:
  content="..."


## Step 3: Test-drive and implement

You'll now test-drive and implement each route. If your application interacts with a
database to store its data, you'll also have to test-drive and implement other layers of
the program (such as Repository classes) as part of your work.

## Challenge

Model and plan the pages and routes for the following web application, which is a game of
Rock Paper Scissors. Test-drive and implement it if you'd like an extra challenge.

```
As a Maker
So I can play Rock Paper Scissors
I would like to enter my move on the home page
And click to confirm my move (rock, paper or scissors)

As a Maker
So I can play Rock Paper Scissors
I would like the opponent's move to be decided randomly by the program

As a Maker
So I can play Rock Paper Scissors
I would like to see the result of the game on the next page

As a Maker
So I can play Rock Paper Scissors again
I would like to click on a link on the result page
So it takes me back to the home page
```
