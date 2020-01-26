extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var manager = get_node("/root/Main/TimeManager")
	self.text = manager.get_time_string()
