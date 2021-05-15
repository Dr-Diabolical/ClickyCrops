extends Node

# Dictionary of resource names and amounts
var resources = {
	"Coins": 15,
	"Carrots": 0,
	"Potatoes": 0
}

# References the resource amount display nodes
onready var coin_amount = $ResourceDisplay/IconDisplay/CoinDisplay/CoinAmount
onready var carrot_amount = $ResourceDisplay/IconDisplay/CarrotDisplay/CarrotAmount
onready var potato_amount = $ResourceDisplay/IconDisplay/PotatoDisplay/PotatoAmount

# On ready, update the resource display
func _ready():
	update_resource_display()

# Add the specified amount of resources to the resource, and update the display
func add_to_resources(resource_name, add_resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) + add_resource_amount
		update_resource_display()
	else:
		print("ERROR: RESOURCE NOT FOUND")

# Remove the specified amount of resources from the resource, and update the display
func remove_from_resources(resource_name, remove_resource_amount):
	if (resources.has(resource_name)):
		resources[resource_name] = resources.get(resource_name) - remove_resource_amount
		update_resource_display()
	else:
		print("ERROR: RESOURCE NOT FOUND")

# Returns the amount of the specified resource
func get_resource(resource_name):
	return resources.get(resource_name)

# Updates the text of each resource display node
func update_resource_display():
	coin_amount.text = str(resources.get("Coins"))
	carrot_amount.text = str(resources.get("Carrots"))
	potato_amount.text = str(resources.get("Potatoes"))
