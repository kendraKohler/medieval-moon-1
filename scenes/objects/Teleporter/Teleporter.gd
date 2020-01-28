extends Area2D

export(String) var targetMap
export(Vector2) var targetPosition
export(int) var targetDirection = -1

func _on_Teleporter_body_entered(body):
	var main = get_node("/root/Main")
	var player = get_node("/root/Main/Player")

	if targetDirection >= 0:
		player.teleport_to(targetPosition, targetDirection)
	else:
		player.teleport_to(targetPosition)
		
	main.show_map(targetMap)