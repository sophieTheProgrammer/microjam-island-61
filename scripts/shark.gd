extends Node2D
@onready var anisprite: AnimatedSprite2D = $AnimatedSprite2D
const FRAME_COUNT = 1
const ACCELERATION = 4
const MAX_SPEED = 6
var rand_x
var rand_y
var velocity = Vector2.ZERO
var speed = 4.0

func _ready() -> void:
	anisprite.frame = randi() % FRAME_COUNT #which frame it starts on
	anisprite.sprite_frames.set_animation_speed("default", (randi() % FRAME_COUNT - 1) + FRAME_COUNT) # fps
	rand_x = (randi() % int(Global.viewport.x)) - Global.viewport.x
	rand_y = (randi() % int(Global.viewport.y)) - Global.viewport.y
	speed = (randi() % MAX_SPEED) + float(MAX_SPEED)/2
	look_at(Vector2(rand_x, rand_y))
	self.rotate(PI/2)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(Vector2(rand_x, rand_y), speed * 100 * delta)
	speed = move_toward(float(speed), 0.0, float(.01))
