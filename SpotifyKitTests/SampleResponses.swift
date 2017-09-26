import Foundation

public enum SampleResponseType {
    case artist, album, track, playlist, findArtist, findTrack, user
}

public var sampleResponses: [SampleResponseType: Data] = [
    .artist: """
{
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/0OdUWJ0sBjDrqHygGUXeCF"
},
"followers" : {
"href" : null,
"total" : 306565
},
"genres" : [ "indie folk", "indie pop" ],
"href" : "https://api.spotify.com/v1/artists/0OdUWJ0sBjDrqHygGUXeCF",
"id" : "0OdUWJ0sBjDrqHygGUXeCF",
"images" : [ {
"height" : 816,
"url" : "https://i.scdn.co/image/eb266625dab075341e8c4378a177a27370f91903",
"width" : 1000
}, {
"height" : 522,
"url" : "https://i.scdn.co/image/2f91c3cace3c5a6a48f3d0e2fd21364d4911b332",
"width" : 640
}, {
"height" : 163,
"url" : "https://i.scdn.co/image/2efc93d7ee88435116093274980f04ebceb7b527",
"width" : 200
}, {
"height" : 52,
"url" : "https://i.scdn.co/image/4f25297750dfa4051195c36809a9049f6b841a23",
"width" : 64
} ],
"name" : "Band of Horses",
"popularity" : 59,
"type" : "artist",
"uri" : "spotify:artist:0OdUWJ0sBjDrqHygGUXeCF"
}
""".data(using: .utf8)!,
    .album: """
{
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"copyrights" : [ {
"text" : "(P) 2000 Sony Music Entertainment Inc.",
"type" : "P"
} ],
"external_ids" : {
"upc" : "5099749994324"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/album/0sNOF9WDwhWunNAHPD3Baj"
},
"genres" : [ ],
"href" : "https://api.spotify.com/v1/albums/0sNOF9WDwhWunNAHPD3Baj",
"id" : "0sNOF9WDwhWunNAHPD3Baj",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/b6e762dcce1502ce63eb2c68798843eb2ed53c51",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/66302ca80395b6be3600d5f0ef69db9e0c43f4f5",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/e2e8cd6bf776613f9b84d1e4403a8abd51bb7234",
"width" : 64
} ],
"label" : "Epic/Legacy",
"name" : "She's So Unusual",
"popularity" : 0,
"release_date" : "1983",
"release_date_precision" : "year",
"tracks" : {
"href" : "https://api.spotify.com/v1/albums/0sNOF9WDwhWunNAHPD3Baj/tracks?offset=0&limit=50",
"items" : [ {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 305560,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3f9zqUnrnIq0LANhmnaF0V"
},
"href" : "https://api.spotify.com/v1/tracks/3f9zqUnrnIq0LANhmnaF0V",
"id" : "3f9zqUnrnIq0LANhmnaF0V",
"name" : "Money Changes Everything",
"preview_url" : null,
"track_number" : 1,
"type" : "track",
"uri" : "spotify:track:3f9zqUnrnIq0LANhmnaF0V"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 238266,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/2joHDtKFVDDyWDHnOxZMAX"
},
"href" : "https://api.spotify.com/v1/tracks/2joHDtKFVDDyWDHnOxZMAX",
"id" : "2joHDtKFVDDyWDHnOxZMAX",
"name" : "Girls Just Want to Have Fun",
"preview_url" : null,
"track_number" : 2,
"type" : "track",
"uri" : "spotify:track:2joHDtKFVDDyWDHnOxZMAX"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 306706,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/6ClztHzretmPHCeiNqR5wD"
},
"href" : "https://api.spotify.com/v1/tracks/6ClztHzretmPHCeiNqR5wD",
"id" : "6ClztHzretmPHCeiNqR5wD",
"name" : "When You Were Mine",
"preview_url" : null,
"track_number" : 3,
"type" : "track",
"uri" : "spotify:track:6ClztHzretmPHCeiNqR5wD"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 241333,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/2tVHvZK4YYzTloSCBPm2tg"
},
"href" : "https://api.spotify.com/v1/tracks/2tVHvZK4YYzTloSCBPm2tg",
"id" : "2tVHvZK4YYzTloSCBPm2tg",
"name" : "Time After Time",
"preview_url" : null,
"track_number" : 4,
"type" : "track",
"uri" : "spotify:track:2tVHvZK4YYzTloSCBPm2tg"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 229266,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/6iLhMDtOr52OVXaZdha5M6"
},
"href" : "https://api.spotify.com/v1/tracks/6iLhMDtOr52OVXaZdha5M6",
"id" : "6iLhMDtOr52OVXaZdha5M6",
"name" : "She Bop",
"preview_url" : null,
"track_number" : 5,
"type" : "track",
"uri" : "spotify:track:6iLhMDtOr52OVXaZdha5M6"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 272840,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3csiLr2B2wRj4lsExn6jLf"
},
"href" : "https://api.spotify.com/v1/tracks/3csiLr2B2wRj4lsExn6jLf",
"id" : "3csiLr2B2wRj4lsExn6jLf",
"name" : "All Through the Night",
"preview_url" : null,
"track_number" : 6,
"type" : "track",
"uri" : "spotify:track:3csiLr2B2wRj4lsExn6jLf"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 220333,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/4mRAnuBGYsW4WGbpW0QUkp"
},
"href" : "https://api.spotify.com/v1/tracks/4mRAnuBGYsW4WGbpW0QUkp",
"id" : "4mRAnuBGYsW4WGbpW0QUkp",
"name" : "Witness",
"preview_url" : null,
"track_number" : 7,
"type" : "track",
"uri" : "spotify:track:4mRAnuBGYsW4WGbpW0QUkp"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 252626,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3AIeUnffkLQaUaX1pkHyeD"
},
"href" : "https://api.spotify.com/v1/tracks/3AIeUnffkLQaUaX1pkHyeD",
"id" : "3AIeUnffkLQaUaX1pkHyeD",
"name" : "I'll Kiss You",
"preview_url" : null,
"track_number" : 8,
"type" : "track",
"uri" : "spotify:track:3AIeUnffkLQaUaX1pkHyeD"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 45933,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/53eCpAFNbA9MQNfLilN3CH"
},
"href" : "https://api.spotify.com/v1/tracks/53eCpAFNbA9MQNfLilN3CH",
"id" : "53eCpAFNbA9MQNfLilN3CH",
"name" : "He's so Unusual",
"preview_url" : null,
"track_number" : 9,
"type" : "track",
"uri" : "spotify:track:53eCpAFNbA9MQNfLilN3CH"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 196373,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/51JS0KXziu9U1T8EBdRTUF"
},
"href" : "https://api.spotify.com/v1/tracks/51JS0KXziu9U1T8EBdRTUF",
"id" : "51JS0KXziu9U1T8EBdRTUF",
"name" : "Yeah Yeah",
"preview_url" : null,
"track_number" : 10,
"type" : "track",
"uri" : "spotify:track:51JS0KXziu9U1T8EBdRTUF"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 275560,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/2BGJvRarwOa2kiIGpLjIXT"
},
"href" : "https://api.spotify.com/v1/tracks/2BGJvRarwOa2kiIGpLjIXT",
"id" : "2BGJvRarwOa2kiIGpLjIXT",
"name" : "Money Changes Everything",
"preview_url" : null,
"track_number" : 11,
"type" : "track",
"uri" : "spotify:track:2BGJvRarwOa2kiIGpLjIXT"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 320400,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/5ggatiDTbCIJsUAa7IUP65"
},
"href" : "https://api.spotify.com/v1/tracks/5ggatiDTbCIJsUAa7IUP65",
"id" : "5ggatiDTbCIJsUAa7IUP65",
"name" : "She Bop - Live",
"preview_url" : null,
"track_number" : 12,
"type" : "track",
"uri" : "spotify:track:5ggatiDTbCIJsUAa7IUP65"
}, {
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/2BTZIqw0ntH9MvilQ3ewNY"
},
"href" : "https://api.spotify.com/v1/artists/2BTZIqw0ntH9MvilQ3ewNY",
"id" : "2BTZIqw0ntH9MvilQ3ewNY",
"name" : "Cyndi Lauper",
"type" : "artist",
"uri" : "spotify:artist:2BTZIqw0ntH9MvilQ3ewNY"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 288240,
"explicit" : false,
"external_urls" : {
"spotify" : "https://open.spotify.com/track/5ZBxoa2kBrBah3qNIV4rm7"
},
"href" : "https://api.spotify.com/v1/tracks/5ZBxoa2kBrBah3qNIV4rm7",
"id" : "5ZBxoa2kBrBah3qNIV4rm7",
"name" : "All Through The Night - Live",
"preview_url" : null,
"track_number" : 13,
"type" : "track",
"uri" : "spotify:track:5ZBxoa2kBrBah3qNIV4rm7"
} ],
"limit" : 50,
"next" : null,
"offset" : 0,
"previous" : null,
"total" : 13
},
"type" : "album",
"uri" : "spotify:album:0sNOF9WDwhWunNAHPD3Baj"
}
""".data(using: .utf8)!,
    .track: """
{
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/0C0XlULifJtAgn6ZNCW2eu"
},
"href" : "https://api.spotify.com/v1/artists/0C0XlULifJtAgn6ZNCW2eu",
"id" : "0C0XlULifJtAgn6ZNCW2eu",
"name" : "The Killers",
"type" : "artist",
"uri" : "spotify:artist:0C0XlULifJtAgn6ZNCW2eu"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/4OHNH3sDzIxnmUADXzv2kT"
},
"href" : "https://api.spotify.com/v1/albums/4OHNH3sDzIxnmUADXzv2kT",
"id" : "4OHNH3sDzIxnmUADXzv2kT",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/ac68a9e4a867ec3ce8249cd90a2d7c73755fb487",
"width" : 629
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/d0186ad64df7d6fc5f65c20c7d16f4279ffeb815",
"width" : 295
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/7c3ec33d478f5f517eeb5339c2f75f150e4d601e",
"width" : 63
} ],
"name" : "Hot Fuss (Deluxe Version)",
"type" : "album",
"uri" : "spotify:album:4OHNH3sDzIxnmUADXzv2kT"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/0C0XlULifJtAgn6ZNCW2eu"
},
"href" : "https://api.spotify.com/v1/artists/0C0XlULifJtAgn6ZNCW2eu",
"id" : "0C0XlULifJtAgn6ZNCW2eu",
"name" : "The Killers",
"type" : "artist",
"uri" : "spotify:artist:0C0XlULifJtAgn6ZNCW2eu"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TR", "TW", "UY" ],
"disc_number" : 1,
"duration_ms" : 222200,
"explicit" : false,
"external_ids" : {
"isrc" : "GBFFP0300052"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3n3Ppam7vgaVa1iaRUc9Lp"
},
"href" : "https://api.spotify.com/v1/tracks/3n3Ppam7vgaVa1iaRUc9Lp",
"id" : "3n3Ppam7vgaVa1iaRUc9Lp",
"name" : "Mr. Brightside",
"popularity" : 73,
"preview_url" : "https://p.scdn.co/mp3-preview/4839b070015ab7d6de9fec1756e1f3096d908fba",
"track_number" : 2,
"type" : "track",
"uri" : "spotify:track:3n3Ppam7vgaVa1iaRUc9Lp"
}
""".data(using: .utf8)!,
    .playlist: """
{
"collaborative" : false,
"description" : null,
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097/playlist/2LKpvYKQmtbYoQBwA8qa7U"
},
"followers" : {
"href" : null,
"total" : 0
},
"href" : "https://api.spotify.com/v1/users/edge9097/playlists/2LKpvYKQmtbYoQBwA8qa7U",
"id" : "2LKpvYKQmtbYoQBwA8qa7U",
"images" : [ {
"height" : 640,
"url" : "https://mosaic.scdn.co/640/be3fae1dbec734476c18fd4298f4577a4c598e73c0193357d5a9a2261729189694fe1488eb0045c7a8db79f3ed9d5f3712f8c0a9b356c184c46ac25586d2ea59969c263d3c82d5ef37013b9a3f18807c",
"width" : 640
}, {
"height" : 300,
"url" : "https://mosaic.scdn.co/300/be3fae1dbec734476c18fd4298f4577a4c598e73c0193357d5a9a2261729189694fe1488eb0045c7a8db79f3ed9d5f3712f8c0a9b356c184c46ac25586d2ea59969c263d3c82d5ef37013b9a3f18807c",
"width" : 300
}, {
"height" : 60,
"url" : "https://mosaic.scdn.co/60/be3fae1dbec734476c18fd4298f4577a4c598e73c0193357d5a9a2261729189694fe1488eb0045c7a8db79f3ed9d5f3712f8c0a9b356c184c46ac25586d2ea59969c263d3c82d5ef37013b9a3f18807c",
"width" : 60
} ],
"name" : "Favourites",
"owner" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"public" : true,
"snapshot_id" : "umz11l0s3Ag69gjtN8zKP/RMeuxwl47h+tM7JbH7BSnHZLvmsjyvvgXCyJMmNVSy",
"tracks" : {
"href" : "https://api.spotify.com/v1/users/edge9097/playlists/2LKpvYKQmtbYoQBwA8qa7U/tracks?offset=0&limit=100",
"items" : [ {
"added_at" : "2017-08-01T07:47:00Z",
"added_by" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"is_local" : false,
"track" : {
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/07QEuhtrNmmZ0zEcqE9SF6"
},
"href" : "https://api.spotify.com/v1/artists/07QEuhtrNmmZ0zEcqE9SF6",
"id" : "07QEuhtrNmmZ0zEcqE9SF6",
"name" : "Owl City",
"type" : "artist",
"uri" : "spotify:artist:07QEuhtrNmmZ0zEcqE9SF6"
} ],
"available_markets" : [ ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/0mcAVDF8XdRrsV4Q0dXcR9"
},
"href" : "https://api.spotify.com/v1/albums/0mcAVDF8XdRrsV4Q0dXcR9",
"id" : "0mcAVDF8XdRrsV4Q0dXcR9",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/9184d232ead9bf6f53159950107239dc516f8c65",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/17ff58fc64de516149994322d36500d638088624",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/e63973849351539842afa4f0befe4ac903256cdf",
"width" : 64
} ],
"name" : "Ultraviolet",
"type" : "album",
"uri" : "spotify:album:0mcAVDF8XdRrsV4Q0dXcR9"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/07QEuhtrNmmZ0zEcqE9SF6"
},
"href" : "https://api.spotify.com/v1/artists/07QEuhtrNmmZ0zEcqE9SF6",
"id" : "07QEuhtrNmmZ0zEcqE9SF6",
"name" : "Owl City",
"type" : "artist",
"uri" : "spotify:artist:07QEuhtrNmmZ0zEcqE9SF6"
} ],
"available_markets" : [ ],
"disc_number" : 1,
"duration_ms" : 231453,
"explicit" : false,
"external_ids" : {
"isrc" : "USUM71406978"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/7nOLBi8XnzQMxslv95fHox"
},
"href" : "https://api.spotify.com/v1/tracks/7nOLBi8XnzQMxslv95fHox",
"id" : "7nOLBi8XnzQMxslv95fHox",
"name" : "Up All Night",
"popularity" : 0,
"preview_url" : null,
"track_number" : 2,
"type" : "track",
"uri" : "spotify:track:7nOLBi8XnzQMxslv95fHox"
}
}, {
"added_at" : "2017-08-01T07:47:09Z",
"added_by" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"is_local" : false,
"track" : {
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/3TVXtAsR1Inumwj472S9r4"
},
"href" : "https://api.spotify.com/v1/artists/3TVXtAsR1Inumwj472S9r4",
"id" : "3TVXtAsR1Inumwj472S9r4",
"name" : "Drake",
"type" : "artist",
"uri" : "spotify:artist:3TVXtAsR1Inumwj472S9r4"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/3hARKC8cinq3mZLLAEaBh9"
},
"href" : "https://api.spotify.com/v1/albums/3hARKC8cinq3mZLLAEaBh9",
"id" : "3hARKC8cinq3mZLLAEaBh9",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/c0193357d5a9a2261729189694fe1488eb0045c7",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/b48b1b7e56f424818f2e8df537c3b692740f100b",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/3cc13a8c1fc2fb71a178d2ad7e6e812b27ac913f",
"width" : 64
} ],
"name" : "Views",
"type" : "album",
"uri" : "spotify:album:3hARKC8cinq3mZLLAEaBh9"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/3TVXtAsR1Inumwj472S9r4"
},
"href" : "https://api.spotify.com/v1/artists/3TVXtAsR1Inumwj472S9r4",
"id" : "3TVXtAsR1Inumwj472S9r4",
"name" : "Drake",
"type" : "artist",
"uri" : "spotify:artist:3TVXtAsR1Inumwj472S9r4"
}, {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/5pKCCKE2ajJHZ9KAiaK11H"
},
"href" : "https://api.spotify.com/v1/artists/5pKCCKE2ajJHZ9KAiaK11H",
"id" : "5pKCCKE2ajJHZ9KAiaK11H",
"name" : "Rihanna",
"type" : "artist",
"uri" : "spotify:artist:5pKCCKE2ajJHZ9KAiaK11H"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 263373,
"explicit" : true,
"external_ids" : {
"isrc" : "USCM51600088"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/11KJSRSgaDxqydKYiD2Jew"
},
"href" : "https://api.spotify.com/v1/tracks/11KJSRSgaDxqydKYiD2Jew",
"id" : "11KJSRSgaDxqydKYiD2Jew",
"name" : "Too Good",
"popularity" : 78,
"preview_url" : null,
"track_number" : 16,
"type" : "track",
"uri" : "spotify:track:11KJSRSgaDxqydKYiD2Jew"
}
}, {
"added_at" : "2017-08-01T07:47:21Z",
"added_by" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"is_local" : false,
"track" : {
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/39eKOohR66fk0DaVRgYr18"
},
"href" : "https://api.spotify.com/v1/artists/39eKOohR66fk0DaVRgYr18",
"id" : "39eKOohR66fk0DaVRgYr18",
"name" : "The Lost Electric",
"type" : "artist",
"uri" : "spotify:artist:39eKOohR66fk0DaVRgYr18"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/4IKyYu9zNndBVpi8FoekaS"
},
"href" : "https://api.spotify.com/v1/albums/4IKyYu9zNndBVpi8FoekaS",
"id" : "4IKyYu9zNndBVpi8FoekaS",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/a8db79f3ed9d5f3712f8c0a9b356c184c46ac255",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/236e9432881298c4a99479e68ee66e6a9213eb78",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/9cac394599a05824708e2be2a3e2627b58e6cf32",
"width" : 64
} ],
"name" : "The Lost Electric",
"type" : "album",
"uri" : "spotify:album:4IKyYu9zNndBVpi8FoekaS"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/39eKOohR66fk0DaVRgYr18"
},
"href" : "https://api.spotify.com/v1/artists/39eKOohR66fk0DaVRgYr18",
"id" : "39eKOohR66fk0DaVRgYr18",
"name" : "The Lost Electric",
"type" : "artist",
"uri" : "spotify:artist:39eKOohR66fk0DaVRgYr18"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 170965,
"explicit" : false,
"external_ids" : {
"isrc" : "US3DF1607125"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3eXOzLl7KjJHoOPeXUsDAB"
},
"href" : "https://api.spotify.com/v1/tracks/3eXOzLl7KjJHoOPeXUsDAB",
"id" : "3eXOzLl7KjJHoOPeXUsDAB",
"name" : "Concrete Heartbeat",
"popularity" : 28,
"preview_url" : "https://p.scdn.co/mp3-preview/57a999a45673529d93320a97c5d06d0f4e0c241c?cid=8897482848704f2a8f8d7c79726a70d4",
"track_number" : 1,
"type" : "track",
"uri" : "spotify:track:3eXOzLl7KjJHoOPeXUsDAB"
}
}, {
"added_at" : "2017-08-01T07:47:40Z",
"added_by" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"is_local" : false,
"track" : {
"album" : {
"album_type" : "single",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/3dz0NnIZhtKKeXZxLOxCam"
},
"href" : "https://api.spotify.com/v1/artists/3dz0NnIZhtKKeXZxLOxCam",
"id" : "3dz0NnIZhtKKeXZxLOxCam",
"name" : "Porter Robinson",
"type" : "artist",
"uri" : "spotify:artist:3dz0NnIZhtKKeXZxLOxCam"
}, {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/4pb4rqWSoGUgxm63xmJ8xc"
},
"href" : "https://api.spotify.com/v1/artists/4pb4rqWSoGUgxm63xmJ8xc",
"id" : "4pb4rqWSoGUgxm63xmJ8xc",
"name" : "Madeon",
"type" : "artist",
"uri" : "spotify:artist:4pb4rqWSoGUgxm63xmJ8xc"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/1n8ESe5nt7EeuZedZUI3yu"
},
"href" : "https://api.spotify.com/v1/albums/1n8ESe5nt7EeuZedZUI3yu",
"id" : "1n8ESe5nt7EeuZedZUI3yu",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/86d2ea59969c263d3c82d5ef37013b9a3f18807c",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/68f416fd0621950781ac84d273978b9e0a4b7eaa",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/a0e8487416d4a219b23192bc6eeec705dbae1adb",
"width" : 64
} ],
"name" : "Shelter",
"type" : "album",
"uri" : "spotify:album:1n8ESe5nt7EeuZedZUI3yu"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/3dz0NnIZhtKKeXZxLOxCam"
},
"href" : "https://api.spotify.com/v1/artists/3dz0NnIZhtKKeXZxLOxCam",
"id" : "3dz0NnIZhtKKeXZxLOxCam",
"name" : "Porter Robinson",
"type" : "artist",
"uri" : "spotify:artist:3dz0NnIZhtKKeXZxLOxCam"
}, {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/4pb4rqWSoGUgxm63xmJ8xc"
},
"href" : "https://api.spotify.com/v1/artists/4pb4rqWSoGUgxm63xmJ8xc",
"id" : "4pb4rqWSoGUgxm63xmJ8xc",
"name" : "Madeon",
"type" : "artist",
"uri" : "spotify:artist:4pb4rqWSoGUgxm63xmJ8xc"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 218964,
"explicit" : false,
"external_ids" : {
"isrc" : "QMUY41600040"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/2CgOd0Lj5MuvOqzqdaAXtS"
},
"href" : "https://api.spotify.com/v1/tracks/2CgOd0Lj5MuvOqzqdaAXtS",
"id" : "2CgOd0Lj5MuvOqzqdaAXtS",
"name" : "Shelter",
"popularity" : 75,
"preview_url" : "https://p.scdn.co/mp3-preview/2312e9b4429d32218bf18778afb4dca0b25ac3f5?cid=8897482848704f2a8f8d7c79726a70d4",
"track_number" : 1,
"type" : "track",
"uri" : "spotify:track:2CgOd0Lj5MuvOqzqdaAXtS"
}
}, {
"added_at" : "2017-08-01T07:48:06Z",
"added_by" : {
"external_urls" : {
"spotify" : "http://open.spotify.com/user/edge9097"
},
"href" : "https://api.spotify.com/v1/users/edge9097",
"id" : "edge9097",
"type" : "user",
"uri" : "spotify:user:edge9097"
},
"is_local" : false,
"track" : {
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/422RLznpwUa5FsQgnTlgUH"
},
"href" : "https://api.spotify.com/v1/artists/422RLznpwUa5FsQgnTlgUH",
"id" : "422RLznpwUa5FsQgnTlgUH",
"name" : "Great Good Fine Ok",
"type" : "artist",
"uri" : "spotify:artist:422RLznpwUa5FsQgnTlgUH"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/6LxFWRPqoL446CkxQyL7sQ"
},
"href" : "https://api.spotify.com/v1/albums/6LxFWRPqoL446CkxQyL7sQ",
"id" : "6LxFWRPqoL446CkxQyL7sQ",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/f0a94ee5288c59ebf419a0b2f6cdff10d86281f4",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/198c086e531a7ca8995e2d64835b31742e4b6bae",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/5fc7d2da74214f18700a7f91024121d3a363e03a",
"width" : 64
} ],
"name" : "III",
"type" : "album",
"uri" : "spotify:album:6LxFWRPqoL446CkxQyL7sQ"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/422RLznpwUa5FsQgnTlgUH"
},
"href" : "https://api.spotify.com/v1/artists/422RLznpwUa5FsQgnTlgUH",
"id" : "422RLznpwUa5FsQgnTlgUH",
"name" : "Great Good Fine Ok",
"type" : "artist",
"uri" : "spotify:artist:422RLznpwUa5FsQgnTlgUH"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 211095,
"explicit" : false,
"external_ids" : {
"isrc" : "TCACW1601464"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/0Xe3C9GFIcEAiOw5ryA6y7"
},
"href" : "https://api.spotify.com/v1/tracks/0Xe3C9GFIcEAiOw5ryA6y7",
"id" : "0Xe3C9GFIcEAiOw5ryA6y7",
"name" : "Holding You",
"popularity" : 52,
"preview_url" : "https://p.scdn.co/mp3-preview/90ce9a7fc914b062957e348fc90287a0b17cfdcd?cid=8897482848704f2a8f8d7c79726a70d4",
"track_number" : 4,
"type" : "track",
"uri" : "spotify:track:0Xe3C9GFIcEAiOw5ryA6y7"
}
} ],
"limit" : 100,
"next" : null,
"offset" : 0,
"previous" : null,
"total" : 5
},
"type" : "playlist",
"uri" : "spotify:user:edge9097:playlist:2LKpvYKQmtbYoQBwA8qa7U"
}
""".data(using: .utf8)!,
    .findArtist: """
{
"artists": {
"href": "https://api.spotify.com/v1/search?query=tania+bowra&offset=0&limit=20&type=artist",
"items": [ {
"external_urls": {
"spotify": "https://open.spotify.com/artist/08td7MxkoHQkXnWAYD8d6Q"
},
"genres": [ ],
"href": "https://api.spotify.com/v1/artists/08td7MxkoHQkXnWAYD8d6Q",
"id": "08td7MxkoHQkXnWAYD8d6Q",
"images": [ {
"height": 640,
"url": "https://i.scdn.co/image/f2798ddab0c7b76dc2d270b65c4f67ddef7f6718",
"width": 640
}, {
"height": 300,
"url": "https://i.scdn.co/image/b414091165ea0f4172089c2fc67bb35aa37cfc55",
"width": 300
}, {
"height": 64,
"url": "https://i.scdn.co/image/8522fc78be4bf4e83fea8e67bb742e7d3dfe21b4",
"width": 64
} ],
"name": "Tania Bowra",
"popularity": 0,
"type": "artist",
"uri": "spotify:artist:08td7MxkoHQkXnWAYD8d6Q"
} ],
"limit": 20,
"next": null,
"offset": 0,
"previous": null,
"total": 1
}
}
""".data(using: .utf8)!,
    .findTrack: """
{
"tracks" : {
"href" : "https://api.spotify.com/v1/search?query=concrete+heartbeat&type=track&market=IT&offset=0&limit=2",
"items" : [ {
"album" : {
"album_type" : "album",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/39eKOohR66fk0DaVRgYr18"
},
"href" : "https://api.spotify.com/v1/artists/39eKOohR66fk0DaVRgYr18",
"id" : "39eKOohR66fk0DaVRgYr18",
"name" : "The Lost Electric",
"type" : "artist",
"uri" : "spotify:artist:39eKOohR66fk0DaVRgYr18"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/4IKyYu9zNndBVpi8FoekaS"
},
"href" : "https://api.spotify.com/v1/albums/4IKyYu9zNndBVpi8FoekaS",
"id" : "4IKyYu9zNndBVpi8FoekaS",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/a8db79f3ed9d5f3712f8c0a9b356c184c46ac255",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/236e9432881298c4a99479e68ee66e6a9213eb78",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/9cac394599a05824708e2be2a3e2627b58e6cf32",
"width" : 64
} ],
"name" : "The Lost Electric",
"type" : "album",
"uri" : "spotify:album:4IKyYu9zNndBVpi8FoekaS"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/39eKOohR66fk0DaVRgYr18"
},
"href" : "https://api.spotify.com/v1/artists/39eKOohR66fk0DaVRgYr18",
"id" : "39eKOohR66fk0DaVRgYr18",
"name" : "The Lost Electric",
"type" : "artist",
"uri" : "spotify:artist:39eKOohR66fk0DaVRgYr18"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 170965,
"explicit" : false,
"external_ids" : {
"isrc" : "US3DF1607125"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/3eXOzLl7KjJHoOPeXUsDAB"
},
"href" : "https://api.spotify.com/v1/tracks/3eXOzLl7KjJHoOPeXUsDAB",
"id" : "3eXOzLl7KjJHoOPeXUsDAB",
"name" : "Concrete Heartbeat",
"popularity" : 28,
"preview_url" : "https://p.scdn.co/mp3-preview/57a999a45673529d93320a97c5d06d0f4e0c241c?cid=8897482848704f2a8f8d7c79726a70d4",
"track_number" : 1,
"type" : "track",
"uri" : "spotify:track:3eXOzLl7KjJHoOPeXUsDAB"
}, {
"album" : {
"album_type" : "single",
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/6L90AYW2tkZOwCgCOKQkuv"
},
"href" : "https://api.spotify.com/v1/artists/6L90AYW2tkZOwCgCOKQkuv",
"id" : "6L90AYW2tkZOwCgCOKQkuv",
"name" : "Slow Motion Celebrity",
"type" : "artist",
"uri" : "spotify:artist:6L90AYW2tkZOwCgCOKQkuv"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"external_urls" : {
"spotify" : "https://open.spotify.com/album/0mJUHVlJkXEtLb0B7g5l0N"
},
"href" : "https://api.spotify.com/v1/albums/0mJUHVlJkXEtLb0B7g5l0N",
"id" : "0mJUHVlJkXEtLb0B7g5l0N",
"images" : [ {
"height" : 640,
"url" : "https://i.scdn.co/image/e0efcbf038bc49b9d4163546dda77a23dc6eb410",
"width" : 640
}, {
"height" : 300,
"url" : "https://i.scdn.co/image/4e6c03bbd2c7af7ec3c5feb564345ba8be639e33",
"width" : 300
}, {
"height" : 64,
"url" : "https://i.scdn.co/image/e6a44b0fb3a374fbed25dea186936478a2bf574f",
"width" : 64
} ],
"name" : "The Skeleton Tree",
"type" : "album",
"uri" : "spotify:album:0mJUHVlJkXEtLb0B7g5l0N"
},
"artists" : [ {
"external_urls" : {
"spotify" : "https://open.spotify.com/artist/6L90AYW2tkZOwCgCOKQkuv"
},
"href" : "https://api.spotify.com/v1/artists/6L90AYW2tkZOwCgCOKQkuv",
"id" : "6L90AYW2tkZOwCgCOKQkuv",
"name" : "Slow Motion Celebrity",
"type" : "artist",
"uri" : "spotify:artist:6L90AYW2tkZOwCgCOKQkuv"
} ],
"available_markets" : [ "AD", "AR", "AT", "AU", "BE", "BG", "BO", "BR", "CA", "CH", "CL", "CO", "CR", "CY", "CZ", "DE", "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", "HN", "HU", "ID", "IE", "IS", "IT", "JP", "LI", "LT", "LU", "LV", "MC", "MT", "MX", "MY", "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "SE", "SG", "SK", "SV", "TH", "TR", "TW", "US", "UY" ],
"disc_number" : 1,
"duration_ms" : 239700,
"explicit" : false,
"external_ids" : {
"isrc" : "QMQ961200001"
},
"external_urls" : {
"spotify" : "https://open.spotify.com/track/6rvp5KRag03UYvpBYhco2P"
},
"href" : "https://api.spotify.com/v1/tracks/6rvp5KRag03UYvpBYhco2P",
"id" : "6rvp5KRag03UYvpBYhco2P",
"name" : "Concrete Heartbeat",
"popularity" : 1,
"preview_url" : "https://p.scdn.co/mp3-preview/6a087150bd6ec2525f2b8e090b2fdee7a1db2ad1?cid=8897482848704f2a8f8d7c79726a70d4",
"track_number" : 1,
"type" : "track",
"uri" : "spotify:track:6rvp5KRag03UYvpBYhco2P"
} ],
"limit" : 2,
"next" : "https://api.spotify.com/v1/search?query=concrete+heartbeat&type=track&market=IT&offset=2&limit=2",
"offset" : 0,
"previous" : null,
"total" : 6
}
}
""".data(using: .utf8)!,
    .user: """
{
"display_name" : "Lilla Namo",
"external_urls" : {
"spotify" : "https://open.spotify.com/user/tuggareutangranser"
},
"followers" : {
"href" : null,
"total" : 4561
},
"href" : "https://api.spotify.com/v1/users/tuggareutangranser",
"id" : "tuggareutangranser",
"images" : [ {
"height" : null,
"url" : "http://profile-images.scdn.co/artists/default/d4f208d4d49c6f3e1363765597d10c4277f5b74f",
"width" : null
} ],
"type" : "user",
"uri" : "spotify:user:tuggareutangranser"
}
""".data(using: .utf8)!
]

