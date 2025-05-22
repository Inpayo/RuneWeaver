extends Node

var speed: float = 0
var damage: float = 0
var knockback: float = 0
var SPC = ""
var SSlot = 0
var SPComp = []
var BehaveDict = {"Blast": 500, "Trap": 0}
signal Early_Freed
var ElementDict = {
				"Fire": [5, 0, 3, 5, 0, "res://Assets/Sprites/Poopy temp fire.png"], 
				"Wind": [3, 400, 0, 0, 0, "res://Assets/Sprites/Poopy temp wind.png"],
				"Earth":[10, 0, 0, 0, 0, "res://Assets/Sprites/Poopy temp rock.png"],
				"Ice": [3, 0, 0, 7, -0.2, "res://Assets/Sprites/Poopy temp ice.png"]
					}
var AugmentDict = {
				"SizeUp" = [-0.2, -0.1, 0, 0, 0.5],
				"Knockback" = [- 0.4, 0.2, 0, 0.25, 0],
				"Power" = [0.3, 0, 0.5, 0, 0],
				"Speed" = [-0.2, 0.5, 0, 0, 0],
				"None" = [0 ,0 , 0, 0, 0]
}

func SetSpell(SPComp):
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
