extends Node


var instances : Dictionary


func instantiate(scene : PackedScene):
	var existing_instances = instances.get(scene, null)
	if existing_instances:
		var instance = existing_instances.pop_back()
		if existing_instances.size() == 0:
			instances.erase(scene)
		instance.request_ready()
		# why poolingHandle??
		return instance
	else:
		var instance = scene.instantiate()
		#maybe use _init instead??
		return instance
	

func return_instance(instance, scene):
	instances[scene] = instance
