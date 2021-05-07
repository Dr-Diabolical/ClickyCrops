extends TextureButton

export var crop_name = ""
export var crop_amount = 0

onready var crop_sprites = $CropSprites

var stage = 0
var grown_stage = 0
export var seconds_between_stages = 0
var is_grown = false
var stage_timer

func fill_plot(new_crop_name, new_crop_amount, new_grown_stage, new_seconds_between_stages):
	crop_name = new_crop_name
	crop_amount = new_crop_amount
	grown_stage = new_grown_stage
	seconds_between_stages = new_seconds_between_stages
	crop_sprites.frame = 0
	create_stage_timer()

func clear_plot():
	crop_name = ""
	crop_amount = 0
	stage = 0
	grown_stage = 0
	seconds_between_stages = 0
	is_grown = false
	stage_timer.queue_free()

func reset_plot():
	stage = 0
	is_grown = false
	stage_timer.start()
	crop_sprites.frame = 0
	
func harvest_plot():
	reset_plot()
	get_tree().call_group("resources", "add_to_resources", crop_name, crop_amount)

func create_stage_timer():
	stage_timer = Timer.new()
	stage_timer.connect("timeout", self, "_on_Stage_Timer_timeout")
	if (not seconds_between_stages > 0):
		stage_timer.wait_time = 1
	else:
		stage_timer.wait_time = seconds_between_stages
	add_child(stage_timer)
	stage_timer.start()

func check_if_grown():
	if (stage == grown_stage):
		is_grown = true
		stage_timer.stop()

func increase_stage():
	stage += 1
	crop_sprites.frame = stage
	check_if_grown()

func _on_Plot_pressed():
	if (is_grown):
		harvest_plot()

func _on_Stage_Timer_timeout():
	increase_stage()
