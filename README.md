# cfp

UIKonf Call for Proposal application.

## Development

Bootstrap dependencies:

```
bin/setup
```

Run application locally:

```
bin/rails server
```

## Monitoring

Check logs:

```
heroku logs -t
```

## Application configuration

### GitHub authentication

We use [GitHub OAuth application](https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/) to log
users in.

You'll have to set the following environment variables:
* `GITHUB_KEY`
* `GITHUB_SECRET`

They're used to configure omniauth in [omniauth.rb](https://github.com/UIKonf/cfp/blob/master/config/initializers/omniauth.rb#L3).

