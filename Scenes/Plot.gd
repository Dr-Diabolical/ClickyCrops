extends Area2D

var mouse_in_plot = false
export var crop_name = "Carrots"
export var crop_amount = 5

var stage = 0
export var grown_stage = 3
export var time_between_stages = 1
var is_grown = false
var stage_timer

onready var plant_sprites = $PlantSprites

# Functions to add:
# clear_plot - remove crop
# fill_plot - add crop
# reset_plot - set stage to zero and restart timer

func _ready():
	create_stage_timer()
	plant_sprites.frame = stage

func _process(delta):
	if (Input.is_action_just_pressed("click") and mouse_in_plot and is_grown):
		harvest_plot()
	
func harvest_plot():
	stage = 0
	is_grown = false
	stage_timer.start()
	plant_sprites.frame = 0
	get_tree().call_group("resources", "add_to_resources", crop_name, crop_amount)

func create_stage_timer():
	stage_timer = Timer.new()
	stage_timer.connect("timeout", self, "_on_Stage_Timer_timeout")
	stage_timer.wait_time = time_between_stages
	add_child(stage_timer)
	stage_timer.start()

func check_if_grown():
	if (stage == grown_stage):
		is_grown = true
		stage_timer.stop()

func increase_stage():
	stage += 1
	plant_sprites.frame = stage
	check_if_grown()

func _on_Plot_mouse_entered():
	mouse_in_plot = true

func _on_Plot_mouse_exited():
	mouse_in_plot = false

func _on_Stage_Timer_timeout():
	increase_stage()
