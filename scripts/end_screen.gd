extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score


func _ready():
	EventBus.game_over.connect(gameover)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("restart game") and not Global.game_is_running:
		Global.start_game(true)
		$CanvasLayer.hide()


func gameover():
	print("gameover")
	if not Global.DEBUG_DEATH:
		if Global.game_is_running:
			$CanvasLayer.show()
			Global.game_is_running = false
			await Global.fade_node.fade(0.5, 0.2).finished
	score.text = "Score: " + str(int(Global.score*Global.measure_unit))
	score.text += "\nHigh score: " + str(Global.high_score*Global.measure_unit)
	if int(Global.score*Global.measure_unit) > Global.high_score:
		print("YAYAYYASY HIGH SCHORE")
		Global.high_score = int(Global.score*Global.measure_unit)
		score.text = "New high score!" + "\n" +str(Global.high_score*Global.measure_unit)
