# cfp

UIKonf Call for Proposal application.

## Development

You need a working installation of PostgreSQL, including having the command line tools in your PATH.
Check the instructions on [postgresapp.com](https://postgresapp.com/).

Bootstrap all dependencies:

```
bin/setup
```

Run the application locally:

```
bin/rails server
```

Run the tests:

```
bin/rails test
```

## Application configuration

### GitHub authentication

We use [GitHub OAuth application](https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/) to log
users in.

You'll have to set the following environment variables:
* `GITHUB_KEY`
* `GITHUB_SECRET`

They're used to configure omniauth in [omniauth.rb](https://github.com/UIKonf/cfp/blob/master/config/initializers/omniauth.rb#L3).

