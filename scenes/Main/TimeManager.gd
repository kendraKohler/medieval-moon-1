extends Node
enum { SPRING, SUMMER, FALL, WINTER }

var monthData = [
	{
		"name": "Spring"
	},
	{
		"name": "Summer"
	},
	{
		"name": "Fall"
	},
	{
		"name": "Winter"
	},
]

const speed = 5 # Number of RL seconds per ten game minutes
var timer = 0 # Tick counter 

var year = 1
var month = SPRING
var day = 1
var hour = 6
var minute = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func add_minutes(count):
	minute += int(count)
	clean_time()

func next_day():
	minute = 0
	hour = 6
	day += 1
	clean_time()
	
func clean_time():
	# Makes sure that time ticks over correctly. 
	if (minute >= 60):
		hour += (minute / 60)
		minute -= (minute / 60) * 60
		
	# Run a 24 hour clock where 0 = midnight, 23 = 11 PM
	# In the future we could trigger a pass-out at 2am or something similar
	# For now we'll just tick over to the next day
	if (hour >= 24):
		day += (hour / 24)
		hour -= (hour / 24) * 24
	
	# Let's go with 4 weeks per month for now
	if (day >= 28):
		month += (day / 28)
		day -= (day / 28) * 28
		
	# and 4 months per year
	if (month >= 4):
		year += (month / 4)
		month -= (month / 4) * 4
		
func get_time_string():
	var format_string = "Year %s - %s %s (%s:%s)"
	var string = format_string % [
		year, 
		monthData[month]["name"], 
		day, 
		str(hour).pad_zeros(2), 
		str(minute).pad_zeros(2)
	]
	return string;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if (timer >= speed):
		var ticks = int(timer/speed)
		timer -= ticks
		add_minutes(ticks * 10)
