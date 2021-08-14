# Absimupo

Abinthe Image Uploading with Expo

Lets you upload and browse "logos" for "Things".

It's deployed here:

https://absimupo.peacefulprogramming.dev/

But creating things has probably been forbidden (to prevent spam).

    If you want to create things, contact me here: 

https://peacefulprogramming.dev/contact

with a nice message and I will enable creating things for a short while.

Warning: if enabled, creating things is SLOW. The deployment is on free tier gigalixir, hosted in the US.

### The architecture

The backend is an Elixir/Phoenix/Absinthe API.

The frontend is an Expo React Native app.

Images in production are stored in Backblaze and served using Imgproxy.


### Why is it called "Absimupo" and not "AbsintheImageUploaderExpo"?

I prefer to call my projects names that are unique, single words.
It makes renaming things easier.


### Prerequisites for local development

You need to have these things installed:

- Elixir/Phoenix
- Expo CLI
- Imagemagick ()

### Setting up for local development

```
cd absimupo_backend;
mix deps.get;
mix deps.compile;
mix ecto.setup;
cd ..
cd absimupo_frontend;
yarn install;
cd ..
```

### Running it locally

In one shell:

```
cd absimupo_backend;
iex -S mix phx.server;
```

In another shell:

```
cd absimupo_frontend;
yarn start;
```

Wait for `yarn start` to bring up the Expo window in your browser. Then go back to the shell and press `w` key. This will tell expo to open the app in the web browser.


### Disclaimers

- The frontend code is all in a `src` folder which is not an ideal structure if this project grows.
- The frontend doesn't look very nice.
- There is a warning in the console on web. Info here: https://stackoverflow.com/questions/66424449/react-does-not-recognize-the-enterkeyhint-prop-on-a-dom-element
