class_name player
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var beach_sprite: Sprite2D = $Sprite2D

const SPEED = 900
const Y_MULT = 8
const ACCELERATION = 6
const BUFFER = 75
var log_ref = null
var direction = 0

enum PlayerState {
	BEACH,
	SWIMMING,
	ON_LOG,
	DEAD
}

var state : PlayerState = PlayerState.BEACH

func _ready() -> void:
	Global.player_node = self
	EventBus.player_attaches_to_log.connect(attach_to_log)
	EventBus.deattached_log.connect(detach_from_log)
	state = PlayerState.BEACH
	
	
func _physics_process(delta: float) -> void:
	if not Global.game_is_running:
		# if dead
		state = PlayerState.DEAD
		#handle_death()
	else:
		if not state == PlayerState.ON_LOG:
			state = PlayerState.SWIMMING
		self.rotation = lerp_angle(self.rotation, direction*45, 10 * delta)
	match state:
		PlayerState.BEACH:
			handle_beach()
		PlayerState.SWIMMING:
			handle_swimming()
		PlayerState.ON_LOG:
			handle_log()
		PlayerState.DEAD:
			handle_death()
	#print(state)

func handle_swimming():
	handle_swimming_visuals()
	direction = Input.get_axis("up", "down")
	velocity.y = move_toward(velocity.y, SPEED * direction * Y_MULT, ACCELERATION * Y_MULT)
	velocity.x = move_toward(velocity.x, SPEED, ACCELERATION)
	if position.y + BUFFER > Global.viewport.y/2:
		velocity.y = 0
		position.y = Global.viewport.y/2 - BUFFER
	elif position.y - BUFFER < -Global.viewport.y/2:
		velocity.y = 0
		position.y = -Global.viewport.y/2 + BUFFER
	move_and_slide()
	
func handle_log():
	Global.player_is_swimming = false
	self.position.x = move_toward(self.position.x, log_ref.position.x - 70, 10)
	self.position.y = move_toward(self.position.y, log_ref.position.y, 10)
	if Input.is_action_just_pressed("escapethelog"):
		detach_from_log()
	direction = 0
	velocity = Vector2(100, 0)
	animated_sprite_2d.play("log")
	
func attach_to_log(log_ref):
	print("attaching to log")
	state = PlayerState.ON_LOG
	AudioPlayer.play_sfx(AudioPlayer.LOG, 1)
	cpu_particles_2d.hide()
	self.log_ref = log_ref
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 3
	
func detach_from_log():
	state = PlayerState.SWIMMING
	AudioPlayer.play_sfx(AudioPlayer.LOG, 6767)
	EventBus.player_deattaches_to_log.emit()
	cpu_particles_2d.show()
	animated_sprite_2d.play()
	
func handle_death():
	# Logic
	Global.player_is_swimming = false
	Global.is_decreasing = false
	# Visuals
	cpu_particles_2d.hide()
	animated_sprite_2d.stop()
	animated_sprite_2d.frame = 0
	animated_sprite_2d.hide()

func handle_beach():
	velocity.x = 0
	beach_sprite.show()
	animated_sprite_2d.hide()
func handle_swimming_visuals():
	Global.player_is_swimming = true
	animated_sprite_2d.show()
	beach_sprite.hide()
	animated_sprite_2d.play("default")
	cpu_particles_2d.show()
