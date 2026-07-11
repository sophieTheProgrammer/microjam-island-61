extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	print("dying shall commence now")
	EventBus.game_over.emit()
	
