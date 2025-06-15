extends ProgressBar

var Hp = 0 

func health_init(health):
	Hp = health
	max_value = Hp
	value = Hp
	
func health_change(health):
	Hp -= health
	value = Hp
