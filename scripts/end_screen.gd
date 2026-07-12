extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score


func _ready():
	EventBus.game_over.connect(gameover)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = "Your score is " + str(int(Global.score*Global.measure_unit))
	if int(Global.score*Global.measure_unit) > Global.high_score:
		score.text += "\nYou also just got a new high score!"
		Global.high_score = int(Global.score*Global.measure_unit)
	else:
		score.text += "\nYou have a high score of" + str(Global.high_score)
	if Input.is_action_just_pressed("restart game") and not Global.game_is_running:
		Global.start_game(true)
		$CanvasLayer.hide()


func gameover():
	if not Global.DEBUG_DEATH:
		if Global.game_is_running:
			$CanvasLayer.show()
			Global.game_is_running = false
			await Global.fade_node.fade(0.5, 0.2).finished
