extends TextureButton

export var crop_name = ""
export var crop_amount = 0

var stage = 0
export var grown_stage = 0
export var seconds_between_stages = 0
var is_grown = false
var stage_timer

onready var plant_sprites = $PlantSprites

func _ready():
	create_stage_timer()
	plant_sprites.frame = stage
	clear_plot()
	fill_plot("Carrots", 5, 3, 1)

func fill_plot(crop_name, crop_amount, grown_stage, seconds_between_stages):
	self.crop_name = crop_name
	self.crop_amount = crop_amount
	self.grown_stage = grown_stage
	self.seconds_between_stages = seconds_between_stages
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
	plant_sprites.frame = 0
	
func harvest_plot():
	reset_plot()
	get_tree().call_group("resources", "add_to_resources", crop_name, crop_amount)

func create_stage_timer():
	stage_timer = Timer.new()
	stage_timer.connect("timeout", self, "_on_Stage_Timer_timeout")
	stage_timer.wait_time = seconds_between_stages
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

func _on_Plot_pressed():
	if (is_grown):
		harvest_plot()

func _on_Stage_Timer_timeout():
	increase_stage()
