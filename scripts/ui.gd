extends CanvasLayer
@onready var distance: RichTextLabel = $Distance
@onready var spacetolaunch: RichTextLabel = $spacetolaunch
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spacetolaunch.show()
	distance.text = "Distance Traveled: " + str(int(floor(Global.score*Global.measure_unit)))
	if Global.measure_unit == 0.9144:
		distance.text += " meters"
	else:
		distance.text += " yards"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("restart game"):
		spacetolaunch.hide()
	if Global.game_is_running and not Global.attached:
		Global.score += delta
		distance.text = "Distance Traveled: " + str(int(floor(Global.score*Global.measure_unit)))
		if Global.measure_unit == 0.9144:
			distance.text += " meters"
		else:
			distance.text += " yards"
