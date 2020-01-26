extends Node2D

var current_map
var maps = {
    "farm": "res://maps/Farm/Farm.tscn",
    "house": "res://maps/House/House.tscn"
}

const STARTING_MAP = "farm"

func _ready():
    self.show_map(STARTING_MAP)

func show_map(map_name):
    if self.current_map != null:
        self.current_map.queue_free()

    self.current_map = load(maps[map_name.to_lower()]).instance()
    self.current_map.z_index = -1 
    self.add_child(self.current_map)