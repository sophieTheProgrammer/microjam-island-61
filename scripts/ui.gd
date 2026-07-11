extends CanvasLayer
@onready var distance: RichTextLabel = $Distance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	distance.text = "Distance Traveled: " + str(Global.score) + " yards"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.score += delta
	distance.text = "Distance Traveled: " + str(int(floor(Global.score))) + " yards"
