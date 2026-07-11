extends Node2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var anisprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_timer: Timer = $MoveTimer
var rand_x = position.x
var rand_y = position.y
var min_wait_time = 1
var max_wait_time = 5 - min_wait_time
var velocity = Vector2.ZERO
var min_speed = 3
var max_speed = 6 - min_speed
var speed = 4.0
const ACCELERATION = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#anisprite.modulate = Color(randi () % 5, randi () % 5, randi () % 5)
	rand_x = (randi() % (int)(Global.viewport.x)) - Global.viewport.x/2
	rand_y = (randi() % (int)(Global.viewport.y)) - Global.viewport.y/2
	speed = (randi() % max_speed) + min_speed
	anisprite.frame = randi() % 6 #which frame it starts on
	anisprite.sprite_frames.set_animation_speed("default", randi() % 5 + 6) # fps
	move_timer.wait_time = (randi() % max_wait_time) + min_wait_time
	look_at(Vector2(rand_x, rand_y))
	self.rotate(PI/2)
	move_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(Vector2(rand_x, rand_y), speed * 100 * delta)
	speed = move_toward(float(speed), 0.0, float(.01))
func _on_timer_timeout() -> void:
	rand_x = (randi() % Global.x_viewport_length) - Global.x_viewport_length/2
	rand_y = (randi() % Global.y_viewport_length) - Global.y_viewport_length/2
	speed = (randi() % max_speed) + min_speed
	move_timer.wait_time = (randi() % max_wait_time) + min_wait_time
	look_at(Vector2(rand_x, rand_y))
	self.rotate(PI/2)
	#print("timer ended, new timer: ", move_timer.wait_time)
	#print("new x, y: ", rand_x, ", ", rand_y)

	
