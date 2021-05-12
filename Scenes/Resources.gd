extends Node

var resources = {
	"Carrots": 0,
	"Potatoes": 0
}
onready var carrot_amount = $GUI/CropDisplay/CarrotDisplay/CarrotAmount
onready var potato_amount = $GUI/CropDisplay/PotatoDisplay/PotatoAmount

func add_to_resources(resource_name, resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) + resource_amount
		update_resource_display()
	else:
		print("ERROR: RESOURCE NOT FOUND")

func update_resource_display():
	carrot_amount.text = str(resources.get("Carrots"))
	potato_amount.text = str(resources.get("Potatoes"))
