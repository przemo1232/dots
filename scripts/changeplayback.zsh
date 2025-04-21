spotifycli --playpause
STATUS=$(spotifycli --playbackstatus)
$(EWW_EXECUTABLE) update playstatus=$STATUS
