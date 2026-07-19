extends Camera2D
var snake_strength: float = 0
var shake_time: float = 0
var shake_time_left: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 450
	Global.camera_node = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.y = 0
	position.x = Global.player_node.position.x + 450
	_update_shake(_delta)


## First parameter is snake_strength and determines how many pixels offset
## Second parameter is shake_timer - how long screenShake lasts
## The more powerful time or strength will take precedence
func shake(amount: float = 10.0, duration: float = 0.3) -> void:
	print("Shaking camera with amount:", amount, " duration:", duration)
	
	# makes sure if 2 screenshakes are called, it replaces smaller one with bigger one 
	snake_strength = max(amount, snake_strength)
	shake_time = max(duration, shake_time)
	shake_time_left = max(duration, shake_time_left)

func _update_shake(_delta: float) -> void:
	if shake_time_left > 0 and shake_time > 0:
		# snake_strength and shake_time are used reference and then shake_time_left is the actual time counter updated
		# So it makes the shake fade out
		shake_time_left -= _delta
		var progress_percent = shake_time_left / shake_time
		var current_strength = progress_percent * snake_strength
		offset = Vector2(randf_range(-current_strength,current_strength),randf_range(-current_strength,current_strength))
	else:
		offset = Vector2(0,0)
		snake_strength = 0
		shake_time = 0
