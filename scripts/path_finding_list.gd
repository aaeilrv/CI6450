class_name PathFindingList extends Node

var contained_values: Array[NodeRecord] = []

func insert(node_record: NodeRecord) -> void:
	contained_values.append(node_record)

func remove(node_record: NodeRecord) -> void:
	contained_values.erase(node_record)

func total_elements() -> float:
	return contained_values.size()

# change to binary search (if I insert organized ofc)
func smallest_element() -> NodeRecord:
	var smallest = contained_values[-1]
	var i = 0
	var N = total_elements()
	
	while i < N:
		if smallest.estimated_total_cost > contained_values[i].estimated_total_cost:
			smallest = contained_values[i]
		i += 1
		
	return smallest	
	
func contains(node: Vector2i) -> bool:
	return contained_values.has(node)
	
func find(node: Vector2i) -> NodeRecord: 
	var i = 0
	var N = total_elements()
	
	while i < N:
		if contained_values[i].node == node:
			return contained_values[i]
		i += 1
	
	return null
