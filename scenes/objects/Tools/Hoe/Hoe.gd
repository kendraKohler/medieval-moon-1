extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	#var t = get_transform()
	#t.origin += Vector3(delta,0,0)
	#set_transform(t)
	self.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func animate(direction):
	self.show()
	match direction:
		'right':
			$AnimationPlayer.play('hoe_right')
	