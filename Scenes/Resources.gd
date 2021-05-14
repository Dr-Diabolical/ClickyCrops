extends Node

var resources = {
	"Coins": 15,
	"Carrots": 0,
	"Potatoes": 0
}

onready var coin_amount = $GUI/IconDisplay/CoinDisplay/CoinAmount
onready var carrot_amount = $GUI/IconDisplay/CarrotDisplay/CarrotAmount
onready var potato_amount = $GUI/IconDisplay/PotatoDisplay/PotatoAmount

func _ready():
	update_resource_display()

func add_to_resources(resource_name, add_resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) + add_resource_amount
		update_resource_display()
	else:
		print("ERROR: RESOURCE NOT FOUND")

func remove_from_resources(resource_name, remove_resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) - remove_resource_amount
		update_resource_display()
	else:
		print("ERROR: RESOURCE NOT FOUND")
		
func get_resource(resource_name):
	return resources.get(resource_name)

func update_resource_display():
	coin_amount.text = str(resources.get("Coins"))
	carrot_amount.text = str(resources.get("Carrots"))
	potato_amount.text = str(resources.get("Potatoes"))
