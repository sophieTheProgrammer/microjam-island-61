extends Area2D

func _ready():
	EventBus.game_over.connect(death)


func death():
	print("die")


func _on_body_entered(body: Node2D) -> void:
	death()
