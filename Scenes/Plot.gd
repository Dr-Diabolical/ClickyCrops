extends TextureButton

var crop_name = "" # Name of the crop planted in the plot
var crop_amount = 0 # Amount of resources gained from harvesting the crop
var stage = 0 # The current stage of the crop's growth
var grown_stage = 0 # # The final stage of the crop's growth
var seconds_between_stages = 0 # The time in seconds between stages
var is_grown = false # If the crop is grown or not
var stage_timer # The timer that handles counting the seconds between stages

# The AnimatedSprites node for handling the sprites of the crops
onready var crop_sprites = $CropSprites 

# Adds a crop to the plot, including all the data that is associated with the
# crop. 
func fill_plot(new_crop_name, new_crop_amount, new_grown_stage, new_seconds_between_stages):
	crop_name = new_crop_name
	crop_amount = new_crop_amount
	grown_stage = new_grown_stage
	seconds_between_stages = new_seconds_between_stages
	crop_sprites.animation = crop_name
	crop_sprites.frame = 0
	create_stage_timer()

# Removes all crop info, sets animation info to default, removes the crop timer
func clear_plot():
	crop_name = ""
	crop_amount = 0
	stage = 0
	grown_stage = 0
	seconds_between_stages = 0
	is_grown = false
	crop_sprites.animation = "default"
	crop_sprites.frame = 0
	stage_timer.queue_free()

# Resets crop stage, and restarts animation and timer
func reset_plot():
	stage = 0
	is_grown = false
	stage_timer.start()
	crop_sprites.frame = 0

# Resets the crop, and sends harvest info to resources
func harvest_plot():
	reset_plot()
	get_tree().call_group("resources", "add_to_resources", crop_name, crop_amount)

# Creates a timer to handle crop stage changing
func create_stage_timer():
	stage_timer = Timer.new()
	stage_timer.connect("timeout", self, "_on_Stage_Timer_timeout")
	if (not seconds_between_stages > 0):
		stage_timer.wait_time = 1
	else:
		stage_timer.wait_time = seconds_between_stages
	add_child(stage_timer)
	stage_timer.start()

# Checks if the crop stage is at the final grown stage
func check_if_grown():
	if (stage == grown_stage):
		is_grown = true
		stage_timer.stop()

# Increases the stage of the crop and current frame of the animation
func increase_stage():
	stage += 1
	crop_sprites.frame = stage
	check_if_grown()

# On press, if the crop is grown, harvest the plot
func _on_Plot_pressed():
	if (is_grown):
		harvest_plot()

# When the timer times out, increase crop stage
func _on_Stage_Timer_timeout():
	increase_stage()
