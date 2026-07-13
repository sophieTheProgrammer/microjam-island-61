extends Node2D

@onready var score: RichTextLabel = $CanvasLayer/score
@onready var end_title: RichTextLabel = $CanvasLayer/EndTitle
@onready var xaway: RichTextLabel = $CanvasLayer/xaway
#yards
const DISTANCE_FROM_MIAMI :int = 96800

func _ready():
	EventBus.game_over.connect(gameover)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("restart game") and not Global.game_is_running:
		Global.start_game(true)
		$CanvasLayer.hide()


func gameover(source):
	print("gameover")
	if not Global.DEBUG_DEATH:
		if Global.game_is_running:
			var measure = ""
			if Global.measure_unit == 1:
				measure = "yards"
			else:
				measure = "meters"
			xaway.text = "You are only " + str(DISTANCE_FROM_MIAMI*Global.measure_unit-int(Global.score*Global.measure_unit)) + " " + measure +" away from the Bahamas!"
			end_title.text = "You died by " + source + ", try "
			if source == "stamina":
				end_title.text += "getting on a log to take a break next time"
			else:
				end_title.text += "avoiding them next time"
			score.text = "Score: " + str(int(Global.score*Global.measure_unit))
			score.text += "\nHigh score: " + str(Global.high_score*Global.measure_unit)
			if int(Global.score*Global.measure_unit) > Global.high_score:
				print("YAYAYYASY HIGH SCHORE")
				Global.high_score = int(Global.score*Global.measure_unit)
				score.text = "New high score!    " + str(int(Global.high_score*Global.measure_unit))
				if Global.measure_unit == 1:
					score.text += " yard"
				else:
					score.text += " meter"
				if int(Global.high_score*Global.measure_unit) != 1:
					score.text += "s"
			$CanvasLayer.show()
			Global.game_is_running = false
			await Global.fade_node.fade(0.5, 0.2).finished
