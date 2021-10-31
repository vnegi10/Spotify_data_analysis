### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ a2ab9402-33f4-11ec-3e98-cf21ff5a08ff
begin
	using Pkg
	Pkg.activate(pwd())
	Pkg.instantiate
end

# ╔═╡ a51a03ae-1291-466f-afd9-4c2ce99f9fd1
using Spotify, DataFrames, VegaLite, Setfield, JSON, Statistics, Query

# ╔═╡ a6aed967-ae4c-4875-be0a-bfb9fb48b8b6
md"## Analyzing Spotify Data"

# ╔═╡ 961c42fc-3757-4f13-a031-0eec39e7754d
md" > **Author: Vikas Negi**
>
> [LinkedIn] (https://www.linkedin.com/in/negivikas/)
"

# ╔═╡ 25c4530d-cf7d-4be5-8822-3e56fc051e51
md"
## Pkg environment
"

# ╔═╡ ee6f5730-8942-4f96-b1e4-fc33e3478640
md"
## Refresh credentials
"

# ╔═╡ 54124ea6-9881-441d-bc4e-82b2a0ff7b80
Spotify.refresh_spotify_credentials()

# ╔═╡ 46ce5db5-e253-4430-83e3-e4ae63d8ee96
md"
## Test API calls
"

# ╔═╡ 3277efe5-f9a3-4eac-ab2f-2024ab0b97fa
md"
### Albums
"

# ╔═╡ 40ddee5f-703f-4113-9be9-e8ea9005e4b1
md"
Example album ID: **1ae143c0rHcjJgPS8QdWnn** (No Escape) from Hades original soundtrack
"

# ╔═╡ 8b156db9-6f01-4a0a-996b-e9c5b62f4fb2
md"
##### Get Spotify catalog information for an album(s)
"

# ╔═╡ c61ace5e-b693-402f-bebb-5b059254aa60
Spotify.album_get("1ae143c0rHcjJgPS8QdWnn", "US")[1]

# ╔═╡ 158d5248-ba79-48f0-8e8d-5387d5690655
md"
##### Get Spotify catalog information about an album's tracks. Optional parameters can be used to limit the number of tracks returned.
"

# ╔═╡ 4621640d-f497-43ed-b0dc-33852b2930e2
Spotify.album_get_tracks("1ae143c0rHcjJgPS8QdWnn", 20, 0, "US")[1]

# ╔═╡ 3ebfecf0-c5f0-4501-a57b-7f65d5b2c03c
md"
### Artists
"

# ╔═╡ 0975e14e-3c22-41fd-8552-461aa6b092d0
md" 
Example artist ID: **0ZMWrgLff357yxLyEU77a1** (Darren Korb)
"

# ╔═╡ 7c510221-6422-443a-9452-1bb30f643c44
md"
##### Get Spotify catalog information for a single artist identified by their unique Spotify ID
"

# ╔═╡ cc690c71-6ad2-4d15-8d8e-40961dd8b5ec
artist_dict = Spotify.artist_get("0ZMWrgLff357yxLyEU77a1")[1]

# ╔═╡ 1789e445-b7e3-4eab-81de-7911b23ca407
artist_dict["followers"]["total"]

# ╔═╡ 6cdf4f1b-c09c-4110-85d9-2a24c2badaf3
artist_dict["genres"][1]

# ╔═╡ f51fd54c-aa7e-4628-9424-3b5418a68d0a
md"
##### Get Spotify catalog information about an artist's albums
"

# ╔═╡ 83b0d873-17bd-45ee-9f3f-8ab309c9432d
Spotify.artist_get_albums("0ZMWrgLff357yxLyEU77a1", "album")[1]

# ╔═╡ 99d6daca-22e0-49fa-9a89-59b0e2350a18
md"
##### Get Spotify catalog information about an artist's top tracks by country
"

# ╔═╡ 2a6e2643-a4aa-445e-95de-03f646aea51d
Spotify.artist_top_tracks("0ZMWrgLff357yxLyEU77a1", "US")[1]

# ╔═╡ 115eacc2-c5bb-4764-ab3f-703d34067d06
md"
##### Get spotify catalog information about artists similar to a given artist. Similarity is based on analysis of the Spotify community's listening history.
"

# ╔═╡ 00bfc64f-44d1-4945-a05a-b6c85015e2c8
Spotify.artist_get_related_artists("0ZMWrgLff357yxLyEU77a1")[1];

# ╔═╡ 66f61607-f426-4d38-a30f-c36b10860563
md"
### Tracks
"

# ╔═╡ 8d63c025-cfbc-40f5-955a-479058ada45c
md"
Example track ID: **21CCrq1fx0SQYiqOYkhOb5?context=spotify%3Aplaylist%3A65IYC6s2O51VPLuXwQspQN**
"

# ╔═╡ 3e438618-27bd-4c00-8e6d-9cb05d5cc42d
md"
##### Get a detailed audio analysis for a single track identified by it's unique Spotify ID
"

# ╔═╡ dfce4570-ee75-4c91-839e-b69619e5a78f
analysis_dict = Spotify.tracks_get_audio_analysis("7MZ42H7Ld8oCeAoBOasVGM")[1];

# ╔═╡ 9ee024c8-1781-42d2-8496-8f76f0d324d0
keys(analysis_dict)

# ╔═╡ 4794239d-91b0-45e0-bcb8-a79f902f5aa1
md"
##### Get audio feature information for a single track identified by it's unique Spotify ID
"

# ╔═╡ 0c1db091-8af0-45ca-a692-99249ecb133e
audio_dict = Spotify.tracks_get_audio_features("5giETs7WBuIGyadCPo5Qvp")[1]

# ╔═╡ b16bb216-bc38-4fdd-8fec-432005491924
DataFrame(audio_dict)

# ╔═╡ 645b18c6-67c5-4e45-920f-9520c76409c7
track_dict = Spotify.tracks_get("3hz3oapMG07NJ5oRDDxtkx")[1]

# ╔═╡ 17c44470-033a-4050-becd-509eb5a1c2d4
keys(track_dict)

# ╔═╡ fa94b74f-6766-48d7-a82e-1cb2b372f972
track_dict["artists"][1]["id"]

# ╔═╡ 59f30cd4-4766-4c3e-9d3b-643d9f4f1fd9
md"
### User data
"

# ╔═╡ 5442bf0b-5ae7-4470-9d3d-98ee25b18781
md"
##### Get the current user's top tracks based on calculated affinity
"

# ╔═╡ 4fc23636-3ace-4671-ad70-739e682b4eb5
#Spotify.top_tracks(0, 10, "medium")

# ╔═╡ 3420a943-81ca-4b6f-b258-e7045b7adb04
md"
### User library data
"

# ╔═╡ ef0ab66c-eb3a-4647-93b7-fd1b015170db
md"
##### Get a list of the songs saved in the current Spotify user's 'Your Music' library
"

# ╔═╡ d34577df-95d7-4214-99f2-7a86f5311048
#tracks_dict = Spotify.library_get_saved_tracks(45, 0, "US")[1];

# ╔═╡ 595f0b86-9add-4051-85ea-432db4bb4ee5
md"
## Get track IDs from album IDs
"

# ╔═╡ 9fdc2298-6297-4644-beca-601cc020352e
function get_album_ids(limit::Int64, index::Int64)
	
	tracks_dict = Spotify.library_get_saved_tracks(limit, index, "US")[1]	
	
	album_ids = String[]
	
	try	
		for i = 1:length(tracks_dict["items"])

			album = tracks_dict["items"][i]["track"]["album"]

			if album["album_type"] == "album"
				id = album["id"]
				push!(album_ids, id)
			end

		end
	catch e
		if isa(e, KeyError)
			@info "Check access token"
		else
			@info "This is a new error, check: $(e)"
		end
	end
	
	return album_ids
end

# ╔═╡ b1571a70-c143-4ebd-902b-dc6241763447
function get_track_ids_from_albums(limit::Int64, index::Int64)
	
	album_ids = get_album_ids(limit, index)
	
	track_ids = String[]
	
	for album_id in album_ids
		
		album_dict = Spotify.album_get_tracks(album_id)[1]
		
		for i = 1:length(album_dict["items"])	
			
			id = album_dict["items"][i]["id"]
			push!(track_ids, id)	
			
		end
		
	end
	
	return track_ids
end	

# ╔═╡ ba8e0bff-e623-4e82-b6b5-3de36dbab37f
md"
## Get track IDs from a playlist
"

# ╔═╡ 5e7a303d-4637-4c63-a73d-82472007d59f
function get_playlist_tracks(playlist_id::String; additional_types="track", 
		                     limit=50, offset=0, market="US")
	
	return Spotify.spotify_request("playlists/$(playlist_id)/tracks?additional_types=$additional_types&limit=$limit&offset=$offset&market=$market")
	
end

# ╔═╡ e87723e8-4c15-40f7-bfb0-bfc27c6fda35
function get_track_ids_from_playlists(playlist_ids::Vector{String})
	
	track_ids = String[]
	
	for playlist_id in playlist_ids
		
		# Start from first track		
		new_offset = 0
		
		# Number of tracks in a playlist is not known beforehand, so repeat
		# multiple (currently set to 5) times
		for i = 1:5
		
			pl_dict = get_playlist_tracks(playlist_id; offset = new_offset)[1]
			
			try 
				for j = 1:length(pl_dict["items"])

					track_id = pl_dict["items"][j]["track"]["id"]
					push!(track_ids, track_id)

				end
			catch e
				if isa(e, KeyError)
					@info "No more tracks present, breaking out of the $(i)th loop!"
					break
				end
			end
			
			# Check for the next 50 tracks
			new_offset = new_offset + 50
			
		end
		
	end
	
	# Remove duplicates	
	return unique(track_ids)
	
end	

# ╔═╡ 7ce38bc9-8404-409b-aa49-0b5267736c91
md"
- 65IYC6s2O51VPLuXwQspQN - Hades
- 37i9dQZF1E4vUblDJbCkV3 - Lord Huron Radio
- 37i9dQZF1DZ06evO3Khq6I - This is Lord Huron
- 0BysSTNbwlYqNFJDFFLObM - Kasoor
- 37i9dQZF1DWUvZBXGjNCU4 - Sweater Weather Instrumentals
- 52OWMxwRgSI8EjerBNu2He - Guitar Music
- 37i9dQZF1DXbcCmWfoUaw2 - 00 Pop Run
- 2ichNtxvAesLPqyjwRo250 - Japanese Lofi Beats 2021
- 4G3jt07NEjXXiM2nMM53gJ - Relaxing Guitar
- 6c8d845p4mo3DSQ30iTien - Liked from Radio
- 37i9dQZF1DWYcDQ1hSjOpY - Deep Sleep
- 37i9dQZF1DWY8U6Zq7nvbE - Hot Acoustics
- 37i9dQZF1DWXLeA8Omikj7 - Brain Food
- 0wCD2lqq5lih8hMmfWsof4 - Milind's Runtastic Rhythms
- 74ai2k73yeRLMmcBxdMWaY - Commute
- 7DlKGMBPT7FBO75kmGZe8s - Evening Stroll
- 5MeNAow48nmXdlQr08oSI8 - Bike Ride Tunes
- 37i9dQZF1DWWLToO3EeTtX - Morning Stroll
- 37i9dQZF1DWT6anPZiHuxz - Energetic Run
- 37i9dQZF1DWWPcvnOpPG3x - Run This Town
- 37i9dQZF1DX4HXqI93DPvP - This is Yiruma
- 37i9dQZF1DX1g0iEXLFycr - Feel Good Friday
- 37i9dQZF1E4p41Xla62Vi2 - Ritviz Radio
"

# ╔═╡ 0c1cf2f8-64a3-4d02-8001-a2888a4dfa13
playlist_ids = ["65IYC6s2O51VPLuXwQspQN", "37i9dQZF1E4vUblDJbCkV3", "37i9dQZF1DZ06evO3Khq6I", "0BysSTNbwlYqNFJDFFLObM", "37i9dQZF1DWUvZBXGjNCU4", "52OWMxwRgSI8EjerBNu2He", "37i9dQZF1DXbcCmWfoUaw2", "2ichNtxvAesLPqyjwRo250", "4G3jt07NEjXXiM2nMM53gJ", "6c8d845p4mo3DSQ30iTien", "37i9dQZF1DWYcDQ1hSjOpY", "37i9dQZF1DWY8U6Zq7nvbE", "37i9dQZF1DWXLeA8Omikj7", "0wCD2lqq5lih8hMmfWsof4",
"74ai2k73yeRLMmcBxdMWaY", "7DlKGMBPT7FBO75kmGZe8s", "5MeNAow48nmXdlQr08oSI8",
"37i9dQZF1DWWLToO3EeTtX", "37i9dQZF1DWT6anPZiHuxz", "37i9dQZF1DWWPcvnOpPG3x", "37i9dQZF1DX4HXqI93DPvP", "37i9dQZF1DX1g0iEXLFycr", "37i9dQZF1E4p41Xla62Vi2"]

# ╔═╡ bf48bcf6-96d4-4daf-9963-7fe5ba1231f1
typeof(playlist_ids)

# ╔═╡ e1131a63-4865-4554-8f69-17d4eed84812
track_ids = get_track_ids_from_playlists(playlist_ids)

# ╔═╡ 9ee49374-08b4-44fa-9be2-9dc02cd75a8d
length(track_ids)

# ╔═╡ bf6edc97-25ef-4a58-8742-6d9805c45205
md"
## Get audio features
"

# ╔═╡ 173cc817-49a5-49c5-8c5d-690343859dd4
function get_audio_features(track_ids::Vector{String})		
	
	audio_dicts = Any[]
	
	for id in track_ids
		
		try
			audio_dict = Spotify.tracks_get_audio_features(id)[1]
			push!(audio_dicts, audio_dict)
		catch e
			@info "Unable to fetch audio features, moving on to the next track ID"
			continue
		end

	end
	
	# Convert all dicts to DataFrame and vertically concatenate to combine into one
	df_audio = vcat(DataFrame.(audio_dicts)...)
	
	return df_audio
	
end

# ╔═╡ 2752fc17-b3f8-4caa-a3af-fe28df20cb38
df_audio = get_audio_features(track_ids)

# ╔═╡ 89c35540-a171-4867-9de8-6e34b02e2ac1
md"
## Get popularity and duration data
"

# ╔═╡ f106df8a-8c4c-4576-8f32-d7e0f1dfba80
function get_pop_dur_data(track_ids::Vector{String})
	
	pop_list, dur_list = Int64[], Float64[]
	
	for id in track_ids
		
		try
			track_dict = Spotify.tracks_get(id)[1]
			pop = track_dict["popularity"]
			push!(pop_list, pop)
			
			dur = track_dict["duration_ms"]/(1000*60) # convert to minutes
			push!(dur_list, dur)
		catch e			
			if isa(e, KeyError)
				@info "Unable to find popularity data, moving on to the next track ID"
				continue
			else
				@info "Something went wrong, check this: $(e)"
			end
		end

	end
	
	# DataFrame will only be created when both lists have the same length	
	return DataFrame(popularity = pop_list, duration = dur_list)
end	

# ╔═╡ e250f5bd-19d3-467b-9051-85657f778c84
df_track = get_pop_dur_data(track_ids)

# ╔═╡ 41398bdd-8c31-474f-9732-859b143b6121
md"
## Get artists data
"

# ╔═╡ 1ed7b836-6c55-47ce-9dfd-1da4ef92839a
function get_artist_ids(track_ids::Vector{String})
	
	artist_ids = String[]
	
	for id in track_ids
		
		try
			track_dict = Spotify.tracks_get(id)[1]
			artist_id = track_dict["artists"][1]["id"]
			push!(artist_ids, artist_id)
		catch e
			if isa(e, KeyError)
				@info "Unable to find artist ID, moving on to the next track ID"
				continue
			else
				@info "Something went wrong, check this: $(e)"
			end
		end
	end
	
	# Remove duplicate artist IDs	
	return unique(artist_ids)
end		

# ╔═╡ 746abd73-f882-427f-8675-f0300898da61
function get_artist_data(artist_ids::Vector{String})
	
	foll_list, pop_list = [Int64[] for i = 1:2]
	genre_list = Union{String, Missing}[]
	
	for id in artist_ids
		
		try
			artist_dict = Spotify.artist_get(id)[1]
			
			followers = artist_dict["followers"]["total"]
			popularity = artist_dict["popularity"]
			
			push!(foll_list, followers)
			push!(pop_list, popularity)
			
			# Some genres might be missing
			if ~isempty(artist_dict["genres"])
				genre = artist_dict["genres"][1]
				push!(genre_list, genre)
			else
				push!(genre_list, missing)
			end	
			
		catch e
			if isa(e, KeyError)
				@info "Unable to find artist data, moving on to the next track ID"
				continue
			else
				@info "Something went wrong, check this: $(e)"
			end
		end
		
	end
	
	return DataFrame(followers = foll_list, popularity = pop_list, genre = genre_list)

end	

# ╔═╡ 8e433176-dd89-4fdd-a6d1-97f9b590b301
artist_ids = get_artist_ids(track_ids)

# ╔═╡ 8418ed5d-eaab-46fa-8968-050a09fd9884
df_artist = get_artist_data(artist_ids)

# ╔═╡ 59d76c81-b6af-41c1-86b1-b16679599f02
md"
## Plot audio features
"

# ╔═╡ 618e2b1d-93d5-4ac1-a942-2d17a04a2c04
function plot_audio_features(df_audio::DataFrame, feature::String)
	
	figure = df_audio |> 

@vlplot(:bar, 
	x = {Symbol(feature), "axis" = {"title" = "$(feature)", "labelFontSize" = 12, "titleFontSize" = 14}, "bin" = {"maxbins" = 50}}, 
	y = {"count()", "axis" = {"title" = "Number of counts", "labelFontSize" = 12, "titleFontSize" = 14 }}, 
	width = 850, height = 500, 
	"title" = {"text" = "Audio $(feature) distribution", "fontSize" = 16},
	color = Symbol(feature))
	
	return figure
	
end

# ╔═╡ 529f97b3-66bb-4e67-abd2-fb0db586d363
plot_audio_features(df_audio, "danceability")

# ╔═╡ cc26c013-a912-4a9d-a7b8-3e74d0a94194
plot_audio_features(df_audio, "energy")

# ╔═╡ b410ca4f-86fd-4054-b363-040c56ae0f68
plot_audio_features(df_audio, "speechiness")

# ╔═╡ 182126a8-e399-4991-977e-659ed0ec1f3f
plot_audio_features(df_audio, "valence")

# ╔═╡ 27990d96-e035-4e4c-af17-26f1f58d3273
md"
### Correlation between different audio features
"

# ╔═╡ 2da2fc22-67e1-4e5e-a911-5e5feaa47acd
function plot_feature_corr_hist(df_audio::DataFrame, x::String, y::String)
	
	figure = df_audio |> 

@vlplot(:circle, 
	x = {Symbol(x), "axis" = {"title" = "$(x)", "labelFontSize" = 14, "titleFontSize" = 14}, "bin" = {"maxbins" = 30}}, 
	y = {Symbol(y), "axis" = {"title" = "$(y)", "labelFontSize" = 14, "titleFontSize" = 14 }, "bin" = {"maxbins" = 30}}, 
	width = 850, height = 500, 
	"title" = {"text" = "2D histogram scatterplot $(x) vs $(y)", "fontSize" = 16},
	size = "count()")
	
	return figure
end	

# ╔═╡ dee028e6-ff58-479c-89b0-02d2575222fd
function plot_feature_corr_scatter(df_audio::DataFrame, x::String, y::String)
	
	# Calculate Pearson's correlation coefficient		
	correlation = round(cor(df_audio[!,Symbol(x)], df_audio[!,Symbol(y)]), digits=2)
	
	figure = df_audio |> 
	
	@vlplot(:point, 
		x = {Symbol(x), "axis" = {"title" = "$(x)", "labelFontSize" = 14, "titleFontSize" = 14}}, 
		y = {Symbol(y), "axis" = {"title" = "$(y)", "labelFontSize" = 14, "titleFontSize" = 14 }}, 
		width = 850, height = 500, 
		"title" = {"text" = "Scatterplot $(x) vs $(y) with corr = $(correlation)", "fontSize" = 16})
	
	return figure
end

# ╔═╡ 019f91bd-923d-48ce-9fa8-5ff23f903604
md"
##### Danceability vs energy
"

# ╔═╡ c6a31f8e-b480-4aac-a0a7-fa3a12fb34f5
plot_feature_corr_scatter(df_audio, "danceability", "energy")

# ╔═╡ 59e24878-c378-4371-9d7e-92a02937b813
md" 
##### Danceability vs Valence
"


# ╔═╡ 2bb18901-5d96-4697-a5e2-0b34fc5317f7
plot_feature_corr_scatter(df_audio, "danceability", "valence")

# ╔═╡ f252f1fd-56d5-445b-ae92-24e16eef7c34
md"
##### Tempo vs Energy
"

# ╔═╡ 2d204f60-2049-4e5b-a4ee-0b5374fd4251
plot_feature_corr_scatter(df_audio, "tempo", "energy")

# ╔═╡ 2051b83d-3388-4cb6-ab28-ece959a601d0
md"
##### Tempo vs Danceability
"

# ╔═╡ 7d3dd03e-efa1-4fec-9cb2-05062312d8ec
plot_feature_corr_scatter(df_audio, "tempo", "danceability")

# ╔═╡ 4632bc9d-e0a6-4130-820e-7525758c53b6
md"
##### Valence vs Energy
"

# ╔═╡ 9993b9dc-a406-4408-9650-83a74c9cab0f
plot_feature_corr_scatter(df_audio, "valence", "energy")

# ╔═╡ 38a6f16a-869d-4b5c-8e6d-6d1cafb0ace3
md"
## Plot track data
"

# ╔═╡ cff07855-f205-4990-90f1-237719f79f92
function plot_track_data(df_track::DataFrame, feature::String)
	
	figure = df_track |> 

@vlplot(:bar, 
	x = {Symbol(feature), "axis" = {"title" = "$(feature)", "labelFontSize" = 12, "titleFontSize" = 14}, "bin" = {"maxbins" = 50}}, 
	y = {"count()", "axis" = {"title" = "Number of counts", "labelFontSize" = 12, "titleFontSize" = 14 }}, 
	width = 850, height = 500, 
	"title" = {"text" = "Track $(feature) distribution", "fontSize" = 16},
	color = Symbol(feature))
	
	if feature == "duration"
		figure1 = @set figure.encoding.x.axis.title = " $(feature) [mins]"
		return figure1		
	end
	
	return figure
	
end

# ╔═╡ e789b6d7-184c-4634-b773-878e0cff223c
md"
### Duration
"

# ╔═╡ 9cefe05a-aa6a-406c-9f34-1e2b1b89b5ca
plot_track_data(df_track, "duration")

# ╔═╡ 90d6a022-1482-49c9-9b08-e1d766d31b5e
md"
### Popularity
"

# ╔═╡ fc1d4498-398e-4d78-a613-18d6ce4dba32
plot_track_data(df_track, "popularity")

# ╔═╡ 38106607-cd2e-405d-b6d3-1e99899b40c1
md"
## Plot artist data
"

# ╔═╡ 871f498f-8547-441d-ab77-8301691da6b8
function plot_artist_data(df_track::DataFrame, feature::String)
	
	figure = df_artist |> 

@vlplot(:bar, 
	x = {Symbol(feature), "axis" = {"title" = "$(feature)", "labelFontSize" = 12, "titleFontSize" = 14}, "bin" = {"maxbins" = 50}}, 
	y = {"count()", "axis" = {"title" = "Number of counts", "labelFontSize" = 12, "titleFontSize" = 14 }}, 
	width = 850, height = 500, 
	"title" = {"text" = "Artist $(feature) distribution", "fontSize" = 16},
	color = Symbol(feature))
	
	return figure
	
end

# ╔═╡ 128a311f-f0ae-401c-b719-c84a316d855b
plot_artist_data(df_artist, "popularity")

# ╔═╡ 666de595-4760-4ce0-8a3f-d4e0373329bb
figure = plot_artist_data(df_artist, "genre")

# ╔═╡ 72e092fc-cc93-4b41-8f55-f285165aba6d
md"
## Understanding personal Spotify data
"

# ╔═╡ c711d4ec-b7c7-4904-9798-63101cfcdafe
md"
### Read JSON data into a DataFrame
"

# ╔═╡ 27838514-100e-4b07-ba13-6dc14a9626cf
begin
	stream_0 = JSON.parsefile("MyData/StreamingHistory0.json")
	stream_1 = JSON.parsefile("MyData/StreamingHistory1.json")
	
	# Convert Dict to DataFrame
	df_stream_0 = vcat(DataFrame.(stream_0)...);
	df_stream_1 = vcat(DataFrame.(stream_1)...);
	
	# Combine the two DataFrames
	df_stream = vcat(df_stream_0, df_stream_1; cols = :setequal);
	
	# Convert ms to mins and rename the corresponding column
	df_stream[!, :msPlayed] = df_stream[!, :msPlayed]/(1000*60)
	rename!(df_stream, Dict(:msPlayed => :minsPlayed))
	
	# Sort in decreasing order of time
	sort!(df_stream, :minsPlayed; rev = true)
end

# ╔═╡ 0bcc096f-07a5-4fdb-9a93-006d25501312
md"
### Plot streaming data
"

# ╔═╡ 00888c8c-635b-467d-bd6d-84ee3bd0c314
md"
##### Top 10 tracks
"

# ╔═╡ f805c8b2-ae42-44ce-ad89-70dcb594b703
function plot_streaming_data(df_stream::DataFrame, num_top::Int64, y_axis::String, data_type::String)
	
	figure = df_stream[1:num_top, :] |>
		
		@vlplot(:bar, 
			y = {Symbol(y_axis), "axis" = {"title" = "Names of the track", "labelFontSize" = 12, "titleFontSize" = 14}, "sort" = "-x"}, 
			x = {:minsPlayed, "axis" = {"title" = "Number of minutes played", "labelFontSize" = 12, "titleFontSize" = 14 }}, 
			width = 850, height = 500, 
			"title" = {"text" = "Top $(num_top) tracks ", "fontSize" = 16},
			color = :artistName)
	
	if data_type == "top_artists"
		figure1 = @set figure.encoding.y.axis.title = "Names of the artists"
		figure1 = @set figure.title.text = "Top $(num_top) artists"
		
		return figure1		
	end
	
	return figure	
end

# ╔═╡ 95faf1d5-2cb1-4ca1-9131-c28b5137d91f
figure2 = plot_streaming_data(df_stream, 10, "trackName", "top_tracks")

# ╔═╡ 3f532621-d29f-4707-be46-12157eef4413
md"
##### Get top 10 artists
"

# ╔═╡ 632ab9a5-fe2b-4732-a6ed-d6084d2faf92
begin
	rows, cols  = size(df_stream)
	
	artist_col = String[]
	total_mins_col = Float64[]
	
	artists = unique(df_stream[!, :artistName])
	
	for artist in artists
		
		# Filter based on name of the artist		
		df_match = df_stream |> @filter(_.artistName == artist) |> DataFrame		
		
		# Append to columns for final DataFrame
		push!(artist_col, artist)
		push!(total_mins_col, sum(df_match[!, :minsPlayed]))
		
	end
	
	df_stream_artists = DataFrame(artistName = artist_col, minsPlayed = total_mins_col)	
	
	sort!(df_stream_artists, :minsPlayed; rev = true)
end

# ╔═╡ 69caf03d-4997-4e45-a119-fe9e09fd76d2
figure3 = plot_streaming_data(df_stream_artists, 10, "artistName", "top_artists")

# ╔═╡ Cell order:
# ╟─a6aed967-ae4c-4875-be0a-bfb9fb48b8b6
# ╟─961c42fc-3757-4f13-a031-0eec39e7754d
# ╟─25c4530d-cf7d-4be5-8822-3e56fc051e51
# ╟─a2ab9402-33f4-11ec-3e98-cf21ff5a08ff
# ╠═a51a03ae-1291-466f-afd9-4c2ce99f9fd1
# ╟─ee6f5730-8942-4f96-b1e4-fc33e3478640
# ╠═54124ea6-9881-441d-bc4e-82b2a0ff7b80
# ╟─46ce5db5-e253-4430-83e3-e4ae63d8ee96
# ╟─3277efe5-f9a3-4eac-ab2f-2024ab0b97fa
# ╟─40ddee5f-703f-4113-9be9-e8ea9005e4b1
# ╟─8b156db9-6f01-4a0a-996b-e9c5b62f4fb2
# ╠═c61ace5e-b693-402f-bebb-5b059254aa60
# ╟─158d5248-ba79-48f0-8e8d-5387d5690655
# ╠═4621640d-f497-43ed-b0dc-33852b2930e2
# ╟─3ebfecf0-c5f0-4501-a57b-7f65d5b2c03c
# ╟─0975e14e-3c22-41fd-8552-461aa6b092d0
# ╟─7c510221-6422-443a-9452-1bb30f643c44
# ╠═cc690c71-6ad2-4d15-8d8e-40961dd8b5ec
# ╠═1789e445-b7e3-4eab-81de-7911b23ca407
# ╠═6cdf4f1b-c09c-4110-85d9-2a24c2badaf3
# ╟─f51fd54c-aa7e-4628-9424-3b5418a68d0a
# ╠═83b0d873-17bd-45ee-9f3f-8ab309c9432d
# ╟─99d6daca-22e0-49fa-9a89-59b0e2350a18
# ╠═2a6e2643-a4aa-445e-95de-03f646aea51d
# ╟─115eacc2-c5bb-4764-ab3f-703d34067d06
# ╠═00bfc64f-44d1-4945-a05a-b6c85015e2c8
# ╟─66f61607-f426-4d38-a30f-c36b10860563
# ╟─8d63c025-cfbc-40f5-955a-479058ada45c
# ╟─3e438618-27bd-4c00-8e6d-9cb05d5cc42d
# ╠═dfce4570-ee75-4c91-839e-b69619e5a78f
# ╠═9ee024c8-1781-42d2-8496-8f76f0d324d0
# ╟─4794239d-91b0-45e0-bcb8-a79f902f5aa1
# ╠═0c1db091-8af0-45ca-a692-99249ecb133e
# ╠═b16bb216-bc38-4fdd-8fec-432005491924
# ╠═645b18c6-67c5-4e45-920f-9520c76409c7
# ╠═17c44470-033a-4050-becd-509eb5a1c2d4
# ╠═fa94b74f-6766-48d7-a82e-1cb2b372f972
# ╟─59f30cd4-4766-4c3e-9d3b-643d9f4f1fd9
# ╟─5442bf0b-5ae7-4470-9d3d-98ee25b18781
# ╠═4fc23636-3ace-4671-ad70-739e682b4eb5
# ╟─3420a943-81ca-4b6f-b258-e7045b7adb04
# ╟─ef0ab66c-eb3a-4647-93b7-fd1b015170db
# ╠═d34577df-95d7-4214-99f2-7a86f5311048
# ╟─595f0b86-9add-4051-85ea-432db4bb4ee5
# ╟─9fdc2298-6297-4644-beca-601cc020352e
# ╟─b1571a70-c143-4ebd-902b-dc6241763447
# ╟─ba8e0bff-e623-4e82-b6b5-3de36dbab37f
# ╟─5e7a303d-4637-4c63-a73d-82472007d59f
# ╟─e87723e8-4c15-40f7-bfb0-bfc27c6fda35
# ╟─7ce38bc9-8404-409b-aa49-0b5267736c91
# ╠═0c1cf2f8-64a3-4d02-8001-a2888a4dfa13
# ╠═bf48bcf6-96d4-4daf-9963-7fe5ba1231f1
# ╠═e1131a63-4865-4554-8f69-17d4eed84812
# ╠═9ee49374-08b4-44fa-9be2-9dc02cd75a8d
# ╟─bf6edc97-25ef-4a58-8742-6d9805c45205
# ╟─173cc817-49a5-49c5-8c5d-690343859dd4
# ╠═2752fc17-b3f8-4caa-a3af-fe28df20cb38
# ╟─89c35540-a171-4867-9de8-6e34b02e2ac1
# ╟─f106df8a-8c4c-4576-8f32-d7e0f1dfba80
# ╠═e250f5bd-19d3-467b-9051-85657f778c84
# ╟─41398bdd-8c31-474f-9732-859b143b6121
# ╟─1ed7b836-6c55-47ce-9dfd-1da4ef92839a
# ╟─746abd73-f882-427f-8675-f0300898da61
# ╠═8e433176-dd89-4fdd-a6d1-97f9b590b301
# ╠═8418ed5d-eaab-46fa-8968-050a09fd9884
# ╟─59d76c81-b6af-41c1-86b1-b16679599f02
# ╟─618e2b1d-93d5-4ac1-a942-2d17a04a2c04
# ╠═529f97b3-66bb-4e67-abd2-fb0db586d363
# ╠═cc26c013-a912-4a9d-a7b8-3e74d0a94194
# ╠═b410ca4f-86fd-4054-b363-040c56ae0f68
# ╠═182126a8-e399-4991-977e-659ed0ec1f3f
# ╟─27990d96-e035-4e4c-af17-26f1f58d3273
# ╟─2da2fc22-67e1-4e5e-a911-5e5feaa47acd
# ╟─dee028e6-ff58-479c-89b0-02d2575222fd
# ╟─019f91bd-923d-48ce-9fa8-5ff23f903604
# ╠═c6a31f8e-b480-4aac-a0a7-fa3a12fb34f5
# ╟─59e24878-c378-4371-9d7e-92a02937b813
# ╠═2bb18901-5d96-4697-a5e2-0b34fc5317f7
# ╟─f252f1fd-56d5-445b-ae92-24e16eef7c34
# ╠═2d204f60-2049-4e5b-a4ee-0b5374fd4251
# ╟─2051b83d-3388-4cb6-ab28-ece959a601d0
# ╠═7d3dd03e-efa1-4fec-9cb2-05062312d8ec
# ╟─4632bc9d-e0a6-4130-820e-7525758c53b6
# ╠═9993b9dc-a406-4408-9650-83a74c9cab0f
# ╟─38a6f16a-869d-4b5c-8e6d-6d1cafb0ace3
# ╟─cff07855-f205-4990-90f1-237719f79f92
# ╟─e789b6d7-184c-4634-b773-878e0cff223c
# ╠═9cefe05a-aa6a-406c-9f34-1e2b1b89b5ca
# ╟─90d6a022-1482-49c9-9b08-e1d766d31b5e
# ╠═fc1d4498-398e-4d78-a613-18d6ce4dba32
# ╟─38106607-cd2e-405d-b6d3-1e99899b40c1
# ╟─871f498f-8547-441d-ab77-8301691da6b8
# ╠═128a311f-f0ae-401c-b719-c84a316d855b
# ╠═666de595-4760-4ce0-8a3f-d4e0373329bb
# ╟─72e092fc-cc93-4b41-8f55-f285165aba6d
# ╟─c711d4ec-b7c7-4904-9798-63101cfcdafe
# ╟─27838514-100e-4b07-ba13-6dc14a9626cf
# ╟─0bcc096f-07a5-4fdb-9a93-006d25501312
# ╟─00888c8c-635b-467d-bd6d-84ee3bd0c314
# ╟─f805c8b2-ae42-44ce-ad89-70dcb594b703
# ╠═95faf1d5-2cb1-4ca1-9131-c28b5137d91f
# ╟─3f532621-d29f-4707-be46-12157eef4413
# ╟─632ab9a5-fe2b-4732-a6ed-d6084d2faf92
# ╠═69caf03d-4997-4e45-a119-fe9e09fd76d2
