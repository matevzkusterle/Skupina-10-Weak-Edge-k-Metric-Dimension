#poti


a1 = graphs.PathGraph(3)


a2 = graphs.PathGraph(5)


a3 = graphs.PathGraph(10)


#alternativa: sami definiramo graf tako
a1_ = Graph({0:[1], 1:[2], 2:[3]})


a2_ = Graph({0:[1], 1:[2], 2:[3], 3:[4]})


a3_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[5], 5:[6]})

show(g1)


#cikli

b1 = graphs.CycleGraph(3)

b2 = graphs.CycleGraph(5)

b3 = graphs.CycleGraph(10)


#alternativa

b1_ = Graph({0:[1], 1:[2], 2:[3], 3:[0]})

b2_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[0]})

b3_ = Graph({0:[1], 1:[2], 2:[3], 3:[4], 4:[5], 5:[6], 6:[0]})



#polni grafi (complete graphs)

c1 = graphs.CompleteGraph(5)

c2 = graphs.CompleteGraph(10)


# polni dvodelni grafi

d1 = graphs.CompleteBipartiteGraph(3,3)

d2 = graphs.CompleteBipartiteGraph(5,5)

show(d1)


#hiperkocke

h1 = graphs.CubeConnectedCycle(2)

h2 = graphs.CubeConnectedCycle(3)

h3 = graphs.CubeConnectedCycle(4)

show(h2)



#zvezdni grafi

z1 = graphs.StarGraph(5)

z2 = graphs.StarGraph(10)

z3 = graphs.StarGraph(20)

show(z3)

#gem graph

g1 = graphs.GemGraph()

show(g1)

#dart graph

da = graphs.DartGraph()

show(da)

#drevesa
T = graphs.BalancedTree(4,2)
T.show()

from sage.graphs.graph_plot import GraphPlot
G = graphs.HoffmanSingletonGraph()
T = Graph()
T.add_edges(G.min_spanning_tree(starting_vertex=0))
T.show(layout='tree', tree_root=0)

T = list(graphs.trees(7))
t = T[2]
t.show()

T = list(graphs.trees(7))
t = T[3]
t.show()


#finbonaccijeva drevesa

f1 = graphs.FibonacciTree(3)

f2 = graphs.FibonacciTree(5)

f3 = graphs.FibonacciTree(10)

show(f2)
