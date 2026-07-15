extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/Control/score
@onready var xaway: RichTextLabel = $CanvasLayer/Control/xaway
#yards
const DISTANCE_FROM_MIAMI :int = 96800

func _ready():
	EventBus.game_over.connect(gameover)
	$CanvasLayer.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("restart game") and not Global.game_is_running:
		Global.start_game(true)
		$CanvasLayer.hide()


func gameover(source):
	print("gameover")
	if not Global.DEBUG_DEATH:
		if Global.game_is_running:
			var measure := ""
			if Global.measure_unit == 1:
				measure = "yards"
			else:
				measure = "meters"
			xaway.text = "You are only " + str(int(DISTANCE_FROM_MIAMI*Global.measure_unit-Global.score*Global.measure_unit)) + " " + measure +" away from the Bahamas!"

			score.text = "\nHigh score: " + str(Global.high_score*Global.measure_unit) + " " + measure
			
			# Handle High Score
			if int(Global.score*Global.measure_unit) > Global.high_score:
				print("YAYAYYASY HIGH SCHORE")
				Global.high_score = int(Global.score*Global.measure_unit)
				score.text = "New high score! " + str(int(Global.high_score*Global.measure_unit)) + " " + measure
			$CanvasLayer.show()
			Global.game_is_running = false
			await Global.fade_node.fade(0.5, 0.2).finished
