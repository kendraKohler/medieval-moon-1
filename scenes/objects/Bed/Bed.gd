extends StaticBody2D


func on_player_interact():
	var manager = get_node("/root/Main/TimeManager")
	manager.next_day()