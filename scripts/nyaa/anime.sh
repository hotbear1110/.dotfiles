#!/bin/bash
animeName=$1

request=$(curl "http://$URL/api/v3/series/lookup?term=$animeName" --header "X-Api-Key: $API_KEY")
animeResult=$(echo ${request} | jq '.[0]')

animeResult=$(echo ${animeResult} | jq '.RootFolderPath = "/downloads/media/anime"')
animeResult=$(echo ${animeResult} | jq --arg torrentPath "/downloads/media/anime/$animeName"'.Path = $torrentPath')
animeResult=$(echo ${animeResult} | jq '.QualityProfileId = "4"')

curl "http://$URL/api/v3/series" \
 --request POST \
 --header 'Content-Type: application/json'\
 --header "X-Api-Key: $API_KEY"\
 --data "$animeResult"
