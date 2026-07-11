extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score

func _ready():
	EventBus.game_over.connect(gameover)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = "Your score is " + str(int(Global.score))
	if Input.is_action_just_pressed("restart game"):
		Global.start_game()
		

func gameover():
	$CanvasLayer.show()
	Engine.time_scale = 0
