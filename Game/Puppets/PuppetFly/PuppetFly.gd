extends Puppet

func _on_discharge():
	move_and_slide(gravity_speed,Vector2.UP)

func apply_charge(en,delta):
	var dir=Vector2(0,0)
	if en>0:
		#if is_on_floor():
		dir=direction
	move_and_slide(dir*speed*delta,Vector2.UP)
