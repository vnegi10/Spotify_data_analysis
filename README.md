This repository contains Julia code that can be used to make API calls to Spotify, and fetch information about audio tracks, artists, playlists etc.

## Obtain valid API credentials

This can be done by creating a Spotify developer account [here.](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.spotify.com%2F) Open your dashboard, and create an app by filling a name and purpose. Then click on "Show Client Secret" to view your secret key. Copy these credentials into your **spotify_credentials.ini** file, which will be created automatically (in your home directory) the first time when you try to run the provided Pluto notebook. Credentials are only valid for 1 hour, so they need to be refreshed as shown in the notebook.

## How to use?

Install Pluto.jl (if not done already) by executing the following commands in your Julia REPL:

    using Pkg
    Pkg.add("Pluto")
    using Pluto
    Pluto.run() 

Clone this repository, and open **Spotify_notebook.jl** via Pluto. The package manager should automatically download the necessary packages for you when you run the notebook for the first time.