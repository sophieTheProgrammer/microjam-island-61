extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score


func _ready():
	EventBus.game_over.connect(gameover)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = "Your score is " + str(int(Global.score*Global.measure_unit))
	if Input.is_action_just_pressed("restart game") and not Global.game_is_running:
		Global.start_game(true)
	if Global.game_is_running:
		$CanvasLayer.hide()


func gameover():
	if not Global.DEBUG_DEATH:
		$CanvasLayer.show()
		Global.fade_node.fade(0.5, 0)
		Global.game_is_running = false
