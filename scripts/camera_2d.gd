extends Camera2D
#@onready var Player := $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 450

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.y = 0
	
	position.x = Global.player_node.position.x + 450
	print(position.x)
	
	#position.x = Player.position.x
