extends KinematicBody2D

enum { RIGHT, LEFT, UP, DOWN }

export (int) var speed = 100
export (int) var tile_size = 32

var direction = DOWN
var moving = false
var target = Vector2()
var start_pos = Vector2()
var velocity = Vector2()

var movement_vals = [
{
	"input": "move_right",
	"animation": "walk_right",
	"idle": "idle_right",
	"target": Vector2(1, 0),
	"cast": Vector2(32, 0),
	"direction": RIGHT
},
{
	"input": "move_left",
	"animation": "walk_left",
	"idle": "idle_left",
	"target": Vector2(-1, 0),
	"cast": Vector2(-32, 0),
	"direction": LEFT
},
{
	"input": "move_up",
	"animation": "walk_up",
	"idle": "idle_up",
	"target": Vector2(0, -1),
	"cast": Vector2(0, -32),
	"direction": UP
},
{
	"input": "move_down",
	"animation": "walk_down",
	"idle": "idle_down",
	"target": Vector2(0, 1),
	"cast": Vector2(0, 32),
	"direction": DOWN
},
]
# holds current value from movement_vals
var current_movement

func _ready():
	$AnimatedSprite.play("idle_down")
	position = position.snapped(Vector2(tile_size, tile_size))
	target = position

func _input(event):
	if event.is_pressed() && event.is_action('interact'):
		var val = get_direction_info()
		$RayCast2D.cast_to = val["cast"]
		var target = $RayCast2D.get_collider()
		if (target == null):
			return
		if (target.has_method("on_player_interact")):
			target.on_player_interact()

func _physics_process(delta):
	if moving:
		var target_creates_collision = test_move(transform, current_movement["target"]);
		if position.distance_to(start_pos) < tile_size && not target_creates_collision:
			move_and_slide(velocity)
		elif target_creates_collision || not continue_movement():
				$AnimatedSprite.stop()
				$AnimatedSprite.play(current_movement["idle"])
				position = position.snapped(Vector2(tile_size, tile_size))
				moving = false
	else:
		get_move_input()

func get_direction_info():
	for val in movement_vals:
		if val["direction"] == direction:
			return val

func get_move_input():
	for val in movement_vals:
		if Input.is_action_pressed(val["input"]):
			current_movement = val
			$AnimatedSprite.play(val["animation"])
			$RayCast2D.cast_to = val["cast"]
			start_pos = position.snapped(Vector2(tile_size, tile_size))
			target = position + val["target"] * tile_size
			velocity = speed * val["target"]
			direction = val["direction"]
			moving = true
			return true

func continue_movement():
	if Input.is_action_pressed(current_movement["input"]):
		start_pos = position.snapped(Vector2(tile_size, tile_size))
		target = position + current_movement["target"] * tile_size
		return true
	return false
	
func teleport_to(tele_target, target_direction=null):
	position = tele_target * tile_size;
	if (target_direction):
		direction = target_direction
		current_movement = movement_vals[direction]
