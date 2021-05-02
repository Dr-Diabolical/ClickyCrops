extends Node

var resources = {
	"Carrots": 0
}
onready var carrot_amount = $GUI/CarrotDisplay/CarrotAmount

func add_to_resources(resource_name, resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) + resource_amount
		update_carrot_display(resources.get(resource_name))
	else:
		print("ERROR: RESOURCE NOT FOUND")

func update_carrot_display(amount):
	carrot_amount.text = str(amount)
