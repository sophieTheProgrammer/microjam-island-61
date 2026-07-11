extends Node2D

@onready var back_button: Button = $BackButton
@onready var music_slider: HSlider = $"VBoxContainer2/Music Slider"
@onready var sfx_slider: HSlider = $"VBoxContainer2/SFX Slider"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_slider.value = 100
	sfx_slider.value = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _slider_value_changed(value: float, source: Range) -> void:
	if source == music_slider:
		AudioPlayer.Music_Volume_Modifier = value/100
	elif source == sfx_slider:
		AudioPlayer.SFX_Volume_Modifier = value/100
	print(AudioPlayer.Music_Volume_Modifier)
	print(AudioPlayer.SFX_Volume_Modifier)

func _button_pressed(source: BaseButton) -> void:
	if source == back_button:
		get_tree().change_scene_to_packed(load("res://scenes/start.tscn"))
