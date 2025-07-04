extends Node

var element 
var speed: float = 0
var damage: float = 0
var knockback: float = 750
var SPC = ""
var SSlot = 0
var SPComp = []
var BehaveDict = {"Blast": 500, "Trap": 0}

@onready var Player = get_node("Player")

signal Early_Freed

var direction

var ElementDict = {
				"Fire": [15, 0, 3, 5, 0, "res://Assets/Sprites/blast_fire.png"], 
				"Wind": [9, 700, 0, 0, 0, "res://Assets/Sprites/blast_wind.png"],
				"Earth":[30, 0, 0, 0, 0, "res://Assets/Sprites/blast_rock.png"],
				"Ice": [9, 0, 0, 7, -0.2, "res://Assets/Sprites/blast_ice.png"]
					}
var AugmentDict = {
				"SizeUp": [-0.2, -0.1, 0, 0, 0.5],
				"Knockback": [- 0.4, 0.2, 0, 0.25, 0],
				"Power": [0.3, 0, 0.5, 0, 0],
				"Speed":[-0.2, 0.5, 0, 0, 0],
				null: [0,0,0,0,0]
}
func _process(float):
	direction = SPC.direction
	
func SetSpell(SPComp):
	if SPComp[0] == null or SPComp [1] == null:
		queue_free()
		return
	$Hurtbox.add_to_group(SPComp[0])
	var SendDown = []
	SendDown.append_array(ElementDict[SPComp[0]])
	SendDown.append(BehaveDict[SPComp[1]])
	SendDown.append_array(AugmentDict[SPComp[2]])
	SendDown.append_array(AugmentDict[SPComp[3]])
	SPC.callv("Cast", SendDown)
	SendDown.clear()
	
func GetVars(SpellCasted):
	SPC = get_node(SpellCasted)
	SPC.visible = true
	SPComp = SPC.Vars
	SetSpell(SPComp)
	
func KYS():
	emit_signal("Early_Freed")
	queue_free()
