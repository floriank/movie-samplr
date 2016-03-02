# movie-samplr

<img src="https://circleci.com/gh/floriank/movie-samplr.svg?style=shield" alt="Build status">

This is a project I did in approx. 10 hours as a challenge for an employer. I had a lot of interruptions with this and had to look up some shenanigans that changed over time.

Anyway, here is the original description:

> Build an AngularJS OR Ruby on Rails (Preferred) application to manage your 
> movie collection. The user should be able to CRUD movies and upload multiple 
> pictures for each of her films. To store the data, you can use local storage 
> mechanisms modern browsers are giving you - use what you're comfortable 
> with! Upon loading, the user should be able to see a visual representation 
> of his/her film library (i.e. utilizing the films' uploaded pictures.)

## Interpretation

I chose to build the Rails-variation of the application, since this was preferred. I opted for my usual setup:

- Rails (latest, `v4.2.5.1` to be exact)
- PostgreSQL backend
- Redis for managing Sidekiq queue

Instead of having the user upload data themselves I chose to grant access to IMDb. The integration is done via the `imdb` gem. Additionally, the CRUD part is doubled. Movies can be organised into lists which reuse movie objects as much as possible.

I aim for a solidly tested and easy to build upon application which is able to be put in production. that includes being a responsive, ideally mobile-ready application that is well-tested and extensible in the future.

## Installing and running

```
bundle exec rails -b  0.0.0.0
```

should fire up Rails.

```
bundle exec sidekiq
```

should boot up the sidekiq queue for processing, otherwise movies added will not be filled up.

## Docker

I prepared a docker composition for your convenience. Run `docker-compose up` to make everything available under http://dev:8080. Rails runs in the container in production mode on `thin`.

And please, if you have not already:

```
# so that the local docker image has a db config
cp config/database.yml.example config/database.yml
```

Do not forget to migrate the database:

```
docker-compose run web bundle exec rake db:migrate
```

## Flaws and improvements

There is a lot that can obviously be made better:

### UX

While I opted for some design gimmicks, I am not a designer, nor am I a particularily good templater. The design is kept minimal, with no extra that could have come from using shiny frontend frameworks/libraries, like Angualr or React. 

Most of it uses the basic Rails stuff that is provided. However, CSS and JavaScript should be cleaned out to the point of being production ready.

Improvements:

- ohmygodineedadesignertothinkaboutthis
- there is o actual need to have a the lists not scroll netflix-style
- Last search term should be kept between search-login process chain
- there could be more "additional" data that the user can add to the movie. At the moment, this is only notes.

### Technology

I currently use the IMDb urls for the movie posters. While there is no guarantee that these will not change, this seems pretty stable.

Improvements I see ad hoc could be:

- actually downloading the image, storing it ourselves, maybe even cropping it to a size that fits us.
- I like the presenter pattern, altough helpers might have sufficed
- (maybe not use Rails for this? If I had had the choice I might have moved to Erlang/Elixir with this project)
- I packaged this as docker images just because I can, the shortest way to deploy this probably remains heroku
- I have not set every index I could, prime candidate i see at the moment is ensuring that the combination (`user_id`, `imdb_id`) is unique as to constrain the user from creating the same movie twice on the db level

### Testing

Not every edge case that exists has been tested - there are also no email tests, since most of the processes on the platform can be done without bombarding the user with emails.

I rely heavily on using selenium based integration tests here whilst using PageObjects to encapsulate most of the html-building-blocks.

Improvements:

- cleanup and put configuration in better places
- I feel that database cleaner does whatever it wants to do - while I have done my best to stabilize these tests, i can only guarantee that this works on my machine (and the CI)
