class_name player
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 750
const y_multiplier = 2
const acceleration = 15
const buffer = 50
var log_ref = null
var direction = 0
func _ready() -> void:
	Global.player_node = self
	EventBus.game_over.connect(game_over)
	EventBus.player_attaches_to_log.connect(attach_to_log)
	velocity.x = 0
	
func _physics_process(delta: float) -> void:
	if Global.attached:
		self.position.x = log_ref.position.x
		self.position.y = log_ref.position.y
	if Input.is_action_just_pressed("escapethelog"):
		detach_from_log()
	direction = Input.get_axis("up", "down")
	velocity.y = move_toward(velocity.y, SPEED * direction * y_multiplier, acceleration * y_multiplier)
	velocity.x = move_toward(velocity.x, SPEED, acceleration)
	if position.y + buffer > Global.viewport.y/2:
		velocity.y = 0
		position.y = Global.viewport.y/2 - buffer
	elif position.y - buffer < -Global.viewport.y/2:
		velocity.y = 0
		position.y = -Global.viewport.y/2 + buffer
	self.rotation = lerp_angle(self.rotation, direction*45, 10 * delta)
	move_and_slide()
func game_over():
	collision_shape_2d.set_deferred("disabled", false) 
func attach_to_log(log_ref):
	print("attaching shall commence")
	Global.attached = true
	self.log_ref = log_ref
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 3

func detach_from_log():
	EventBus.player_deattaches_to_log.emit()
	Global.attached = false
	animated_sprite_2d.play()
