extends Node2D

@onready var back_button: Button = $BackButton
@onready var distance_button: Button = $VBoxContainer2/Distance
@onready var music_slider: HSlider = $"VBoxContainer2/Music Slider"
@onready var sfx_slider: HSlider = $"VBoxContainer2/SFX Slider"
@export var sharkbtn: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_slider.value = (AudioPlayer.Music_Volume_Modifier + 10) * 5
	sfx_slider.value = (AudioPlayer.SFX_Volume_Modifier + 10) * 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _slider_value_changed(value: float, source: Range) -> void:
	if source == music_slider:
		AudioPlayer.Music_Volume_Modifier = value/5 - 10
	elif source == sfx_slider:
		AudioPlayer.SFX_Volume_Modifier = value/5 - 10
	print(AudioPlayer.Music_Volume_Modifier)
	print(AudioPlayer.SFX_Volume_Modifier)

func _button_pressed(source: BaseButton) -> void:
	AudioPlayer.play_sfx(AudioPlayer.CLICK_003, 1)
	if source == back_button:
		get_tree().change_scene_to_packed(load("res://scenes/start.tscn"))
	elif source == distance_button:
		if (Global.measure_unit == 1):
			Global.measure_unit = 0.9144
			distance_button.text = "Metric"
		else:
			Global.measure_unit = 1
			distance_button.text = "Imperial"
	
func _button_down(_source: BaseButton) -> void:
	AudioPlayer.play_sfx(AudioPlayer.CLICK_002, 1)




func _on_shark_toggled(toggled_on: bool) -> void:
	AudioPlayer.play_sfx(AudioPlayer.CLICK_002, 1)
	print("toglging shark modee")
	if toggled_on:
		sharkbtn.text = "On"
		Global.dudeno = true
	else:
		sharkbtn.text = "Off"
		Global.dudeno = false
