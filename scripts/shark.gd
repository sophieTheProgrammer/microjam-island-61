extends Node2D
@onready var anisprite: AnimatedSprite2D = $AnimatedSprite2D
const FRAME_COUNT = 5
const ACCELERATION = 4
const MAX_SPEED = 6
var rand_x
var rand_y
var velocity = Vector2.ZERO
var speed = 4.0

func _ready() -> void:
	if Global.dudeno:
		anisprite.hide()
		var newSprite = Sprite2D.new()
		newSprite.texture = load("res://art/dudeno.png")
		newSprite.scale = Vector2(2, 2)
		newSprite.rotation_degrees = 90
		add_child(newSprite)
	anisprite.frame = randi() % FRAME_COUNT #which frame it starts on
	anisprite.sprite_frames.set_animation_speed("default", (randi() % FRAME_COUNT - 1) + FRAME_COUNT) # fps

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var rand = Vector2((randi() % int(Global.viewport.x)) - Global.viewport.x*10, (randi() % int(Global.viewport.y)) - Global.viewport.y)
	if rand == position:
		rand = Vector2((randi() % int(Global.viewport.x)) - Global.viewport.x*10, (randi() % int(Global.viewport.y)) - Global.viewport.y)
	speed = (randi() % MAX_SPEED) + float(MAX_SPEED)/2
	look_at(rand)
	
	self.rotate(PI/2)
	position = position.move_toward(rand, speed * 100 * delta)
	speed = move_toward(float(speed), 0.0, float(.01))
