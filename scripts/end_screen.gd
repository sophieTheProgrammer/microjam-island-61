extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score
var game: PackedScene = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = "Your score is " + str(Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart game"):
		get_tree().change_scene_to_packed(game)
