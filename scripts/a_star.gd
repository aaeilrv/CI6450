class_name AStar extends Node

func a_star_algorithm(graph: Graph, start: TileNode, end: TileNode, heuristic: Heuristic) -> Array[Connection]:
	var start_record = NodeRecord.new()
	start_record.node = start
	start_record.connection = null
	start_record.cost_so_far = 0
	start_record.estimated_total_cost = heuristic.estimate(start)
	print(start_record.estimated_total_cost)
	
	var open = PathFindingList.new()
	open.insert(start_record)
	var closed = PathFindingList.new()
	
	var current: NodeRecord
	
	# Iterate through processing each node
	while open.total_elements() > 0:
		# find the smallest element in the open list
		# According to the book, the one with the smallest
		# estimated total cost
		current = open.smallest_element()
		
		# if its the goal node, then terminate
		if current.node.node_position == end.node_position:
			print("lessgo")
			break
		
		# otherwise get its outgoing connections
		var connections = graph.get_connections(current.node)
		
		# loop through each connection in turn
		for connection in connections:
			# get the estimated cost for the end node
			var end_node = connection.get_to_node()
			var end_node_cost = current.cost_so_far + connection.get_cost()
			
			var end_node_record: NodeRecord
			var end_node_heuristic: float
			
			# if the node is closed we may have to skip it
			# or remove it from the closed list
			if closed.contains(end_node):
				# we find the record in the closed list
				# corresponding to the end node
				end_node_record = closed.find(end_node)
				
				# if we didn't find a shorter route, skip
				if end_node_record.cost_so_far <= end_node_cost:
					continue
				
				# otherwise remove it from the closed list
				closed.delete(end_node_record)
				
				# We can use the node's old cost value to
				# calculate its heuristic without calling
				# the possibly expensive heuristic function
				end_node_heuristic = end_node_record.estimated_total_cost -\
				 end_node_record.cost_so_far
				
			elif open.contains(end_node):
				# here we find the record in the open list
				# corresponding to the end_node
				end_node_record = open.find(end_node)
				
				# if our route is no better, then skip it
				if end_node_record.cost_so_far <= end_node_cost:
					continue
					
				# we calculate its heuristic
				end_node_heuristic = end_node_record.estimated_total_cost -\
				 end_node_record.cost_so_far
			
			# otherwise, we know we've got an univisted node,
			# so we make a record for it
			else:
				end_node_record = NodeRecord.new()
				end_node_record.node = end_node
				
				# we calculate the heuristic value
				end_node_heuristic = heuristic.estimate(end_node)
		
			# update the node: cost, estimate and connection if needed
			end_node_record.cost_so_far = end_node_cost
			end_node_record.connection = connection
			end_node_record.estimated_total_cost = end_node_cost + end_node_heuristic
			
			# add it to the open list
			if not open.contains(end_node):
				open.insert(end_node_record)
				
		# remove current node from the open list
		open.remove(current)
		closed.insert(current)
	
	# if we've found the goal or there are no more nodes to search
	if current.node.node_position != end.node_position:
		# we've round out of nodes, there is no solution
		return []
	
	else:
		# compile the list of connections in the path
		var path: Array[Connection]
			
		# work back along the path, accumulating connections
		while current.node.node_position != start.node_position:
			path.append(current.connection)
			current = current.connection.get_from_node()
			# obtener el NodeRecord que tenga el nodo de from_node
			# however, cómo puedo saber cuál es ese?
			
		path.reverse()
		
		return path
