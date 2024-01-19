#CODE FOR WEAK EDGE K-METRIC DIMENSION:

from sage.numerical.mip import MixedIntegerLinearProgram

def weak_edge_k_metric_dimension_ILP(graph, k):
    # Create an ILP instance
    p = MixedIntegerLinearProgram(maximization=False)

    # Define variables
    x = p.new_variable(binary=True)
    vertices = graph.vertices()

    # Objective function: Minimize the sum of xi variables
    p.set_objective(p.sum(x[vertex] for vertex in vertices))

    # Constraint:
    for ea, eb in graph.edges(labels=False):
        p.add_constraint(sum(abs(graph.distance(ea, vertex) - graph.distance(eb, vertex)) * x[vertex] for vertex in vertices) >= k)

    # Solve the ILP
    p.solve()

#CODE FOR κ′(G) (largest integer k for which G contains k-resolving set)

def κ_G(graph):

    # Define variables
    vertices = graph.vertices()

    # Choose a pair of vertices
    list = []
    for a in vertices:
        for b in vertices:
            if a != b:
                k = 0
                # Count the number of vertices that satisfy the condition
                for v in vertices:
                    if (graph.distance(v,a) != graph.distance(v,b)):
                        k = k+1
                list.append(k)
    list.sort()
    # Return κ′
    return list[0]
    # Extract the solution
    solution = p.get_values(x)

    # Return the cardinality of the selected set
    dimension = sum(1 for vertex in vertices if solution[vertex] == 1)
    return dimension



# CODE FOR WEAK K-METRIC DIMENSION ON VERTICES:

from sage.numerical.mip import MixedIntegerLinearProgram

def weak_vertex_k_metric_dimension_ILP(graph, k):
    # Create an ILP instance
    p = MixedIntegerLinearProgram(maximization=False)

    # Define variables
    x = p.new_variable(binary=True)
    vertices = graph.vertices()

    # Objective function: Minimize the sum of xi variables
    p.set_objective(p.sum(x[vertex] for vertex in vertices))

    # Constraints:
    for u in vertices:
        for v in vertices:
            if u != v:
                p.add_constraint(sum(abs(graph.distance(u, s) + graph.distance(v, s)) * x[s] for s in vertices) >= k)

    # Solve the ILP
    p.solve()

    # Extract the solution
    solution = p.get_values(x)

    # Return the cardinality of the selected set
    dimension = sum(1 for vertex in vertices if solution[vertex] == 1)
    return dimension




