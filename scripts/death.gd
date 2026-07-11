extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	if !Global.DEBUG_DEATH:
		print("dying shall commence now")
		EventBus.game_over.emit()
	
