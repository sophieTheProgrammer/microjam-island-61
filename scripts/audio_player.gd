extends Node2D

@export var Music_Volume_Modifier := 10.0
@export var SFX_Volume_Modifier := 10.0
const CLICK_002 = preload("res://audio/click_002.ogg")
const CLICK_003 = preload("res://audio/click_003.ogg")

#add SFX definitions here and then play the sfx in other scripts with the functions
#for example const CLICK = preload("res://audio/clicksound.mp3")
const START_SCREEN_SONG = preload("res://audio/𝄞₊˚ ⊹  lovely elevator •.¸¸♬.wav")

const GAME_SONG_1 = preload("res://audio/'miffy cafe' ｜ cute bossa type beat, cafe music.wav")
const GAME_SONG_2 = preload("res://audio/just another day.wav")
const CHOMP = preload("res://audio/chomp.mp3")
const SPLASH = preload("res://audio/SPLASH.mp3")
const WAVES = preload("res://audio/WAVES.mp3")

# the difference between playing music and SFX is that
# only one song can play at a time so if you call the music 
# it will override the other one but the sfx can play
# simultaneously

func play_sfx(Stream, Volume):
	var fx = AudioStreamPlayer.new()
	fx.stream = Stream
	fx.name = "audio effects player"
	fx.volume_db = Volume * SFX_Volume_Modifier
	add_child(fx)
	fx.play()
	await fx.finished
	
	fx.queue_free()

var current_player = null

func play_music(Stream, Volume=1):

	if current_player:
		if Stream == current_player.stream:
			return
		current_player.queue_free()
	var musicPlayer = AudioStreamPlayer.new()
	musicPlayer.stream = Stream
	musicPlayer.name = "music player"
	musicPlayer.volume_db = Volume * Music_Volume_Modifier
	print(musicPlayer.volume_db)
	add_child(musicPlayer)
	musicPlayer.play()
	current_player = musicPlayer
	await musicPlayer.finished
	musicPlayer.queue_free()

func play_waves(Stream, Volume=-2):
	var fx = AudioStreamPlayer.new()
	fx.stream = Stream
	fx.name = "audio effects player"
	fx.volume_db = Volume * SFX_Volume_Modifier
	add_child(fx)
	fx.play()
	await fx.finished
	
	fx.queue_free()
