
extends Node2D

@onready var tutorial_sprite: Sprite2D = $CanvasLayer/TutorialImage
@onready var start_button: Button = $CanvasLayer/StartButton
@onready var fade: CanvasLayer = $Fade

var current_step = 0
const GAME = preload("res://scenes/game.tscn")

var tutorial_data : Array = [
	{
		"text":"you are an avid nature photographer",
		"image_path":"res://art/tutorial/0.png"
	},
	{
		"text":"too bad you are BROKE!!!",
		"image_path":"res://art/tutorial/1.png"
	},
	{
		"text":"are we broke or is the broke broking us",
		"image_path":"res://art/tutorial/2.png"
	},
	{
		"text":"are we broke or is the broke broking us",
		"image_path":"res://art/tutorial/3.png"
	},
	{
		"text":"",
		"image_path":""
	},
]
func _ready() -> void:
	loadIndexItems(current_step, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("click") or Input.is_action_just_released("ui_accept"):
		# Subtracts -1 prevents OBO error
		# .size() is not zero indexed but current_step is
		
		# Can start at one since the 0 loads at ready()
		current_step += 1
		if not current_step > tutorial_data.size() - 1:
			loadIndexItems(current_step, true)


func loadIndexItems(index, is_fading: bool):
	if not tutorial_data[index]["image_path"]:
		printerr("Image Texture Doesn't Exist")
	# print(tutorial_data[index]["image_path"])
	await fade.fade(0.7, 0.1).finished
	tutorial_sprite.texture = load(tutorial_data[index]["image_path"])
	if current_step == tutorial_data.size() - 1:
		# shows start button to start game
		start_button.show()
		$CanvasLayer/ClickToContinueLabel.hide()
	#tutorial_label.text = tutorial_data[index]["text"]
	await fade.fade(0, 0.2).finished
func _on_start_button_pressed() -> void:
	await fade.fade(1, 1.5).finished
	print("Starting game, from tutorial cutscene")
	get_tree().change_scene_to_packed(Global.GAME)
