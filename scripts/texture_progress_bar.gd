extends TextureProgressBar

@export var stamina_decrease_rate_per_second = 10
@export var stamina_increase_rate_per_second = 45

const yellow_progress = preload("res://art/progress bar/1.png")
const red_progress = preload("res://art/progress bar/3.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = 100
	EventBus.player_attaches_to_log.connect(player_attaches_to_log)
	EventBus.player_deattaches_to_log.connect(player_deattaches_to_log)
	EventBus.start_game.connect(resetBar)	
func player_attaches_to_log(log_ref):
	Global.is_decreasing = false
func player_deattaches_to_log():
	Global.is_decreasing = true
func resetBar():
	self.value = 100
	Global.is_decreasing = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.is_decreasing:
		self.value -= stamina_decrease_rate_per_second*delta
	else:
		self.value += stamina_increase_rate_per_second*delta
	if value == 0:
		EventBus.game_over.emit("stamina")

	# change color of bar depending on how much stamina
	
	if self.value < 20:
		texture_progress = red_progress
	else:
		texture_progress = yellow_progress
