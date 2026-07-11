extends TextureProgressBar

@export var stamina_decrease_rate_per_second = 0
var is_decreasing = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = 100

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_decreasing:
		self.value -= stamina_decrease_rate_per_second*delta

	if value == 0:
		EventBus.game_over.emit()
