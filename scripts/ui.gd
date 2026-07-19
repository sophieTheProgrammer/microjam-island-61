extends CanvasLayer
@onready var distance: RichTextLabel = $Distance
@onready var spacetolaunch: RichTextLabel = $spacetolaunch
@onready var stamina: RichTextLabel = $stamina
@onready var texture_progress_bar: TextureProgressBar = $Control/TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spacetolaunch.show()
	update_distance_text(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("restart game"):
		spacetolaunch.hide()
	update_distance_text(delta)
	stamina.show()
	distance.show()
	texture_progress_bar.show()
	if not Global.game_is_running:
		stamina.hide()
		distance.hide()
		texture_progress_bar.hide()
		
func update_distance_text(delta):
	Global.score += delta
	distance.text = "Distance: " + str(int(floor(Global.score*Global.measure_unit)))
	if Global.measure_unit == 0.9144:
		distance.text += " meters"
	else:
		distance.text += " yards"
