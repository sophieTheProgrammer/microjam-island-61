extends Node2D

@onready var start_screen_tutorial_button: Button = $CanvasLayer/StartScreenTutorialButton
@onready var start_screen_start_button: Button = $CanvasLayer/StartScreenStartButton
@onready var start_screen_settings_button: Button = $CanvasLayer/StartScreenSettingsButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _button_pressed(source: BaseButton) -> void:
	match source:
		start_screen_tutorial_button:
			get_tree().change_scene_to_packed(Global.TUTORIAL)
		start_screen_start_button:
			get_tree().change_scene_to_packed(Global.GAME)
		start_screen_start_button:
			get_tree().change_scene_to_packed(Global.SETTINGS)
