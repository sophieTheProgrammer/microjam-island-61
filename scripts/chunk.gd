extends Node2D
var WHIRLPOOL = preload("res://scenes/whirlpool.tscn")
@onready var obstacles: Node = $"obstacles"
var SHARK = preload("res://scenes/shark.tscn")

func _ready() -> void:
	spawn(5, "whirlpool")
	spawn(3, "shark")
func _process(_delta: float) -> void:
	pass
	
func spawn(num, type):
	for i in range(num):
		var new_whirlpool
		if type == "whirlpool":
			new_whirlpool = WHIRLPOOL.instantiate()
		else:
			new_whirlpool = SHARK.instantiate()
		new_whirlpool.name = type
		new_whirlpool.position.x = randf_range(Global.viewport.x / 2, -Global.viewport.x / 2) + self.position.x
		new_whirlpool.position.y = randf_range(Global.viewport.y / 2, -Global.viewport.y / 2) + self.position.y
		obstacles.add_child(new_whirlpool)



func _on_area_2d_body_entered(_body: Node2D) -> void:
	EventBus.spawn_new_chunk.emit()
