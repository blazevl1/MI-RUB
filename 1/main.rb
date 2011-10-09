require 'thread'

class Graph

  attr_reader :queries, :number

  def initialize(nodes,number)
    @nodes = {}
    @queries = Array.new
    @number = number
    1.upto(nodes) { |i|
      add_node(Node.new(i))
    }
  end

  def add_node(node)
    @nodes[node.index] = node
  end

  def get_node(index)
    @nodes[index]
  end

  def nodes_count?()
    @nodes.size
  end

  def refresh_nodes
    @nodes.each_value do |value|
      value.status_open
    end
  end

  def push_query(query)
    @queries.push(query)
  end
end

class Node

  def initialize(index)
    @neighbours = Array.new
    @index = Integer(index)
    @closed = false;
  end

  public
  def create_connection(node)
    @neighbours.push(node)
  end

  def index
    @index
  end

  def neighbours
    @neighbours
  end

  def closed?
    @closed
  end

  def close
    @closed = true;
  end

  def status_open
    @closed = false;
  end

end

class Query

  attr_reader :algorithm, :root_node_index

  def initialize(root_node_index,algorithm)
    @root_node_index = Integer(root_node_index)
    @algorithm = Integer(algorithm)
  end
end

class InputParser

  @graph_in_process = false;

  @graph = nil;
  @graphs = nil;
  @graph_count;
  

  def initialize()
    @graphs = Array.new
    @node_process = false
    @query_process = false
    @end_of_reading = false;
    @start = true;
  end

  public
  def process_input_from_file()
    File.open("test.txt", "r") { |file|
      lines = file.readlines
      @graph_count = Integer(lines[0]);
      for line in lines
        if (not @end_of_reading)
          if (@graph_in_process)
            process_line(line)
          else
            create_graph(line.chomp)
            @graph_in_process = true;
          end
        end
      end
    }
    return @graphs
  end

  public
  def process_input_from_stdin()
    while (not @end_of_reading)
        line = gets;
        if (@start)
          @graph_count = Integer(line);
          @start = false;
        else
          if (@graph_in_process)
            process_line(line)
          else
            create_graph(line.chomp)
            @graph_in_process = true;
          end
        end
        
    end
    return @graphs
  end

  private
  def process_line(line)
    data = line.split(/\s+/)
    if (end_of_graph_data?(data))
      @graph_in_process = false;
      if (@graph_count == @graphs.size)
        @end_of_reading = true;
      end
    elsif (@node_process)
      if (Integer(data[0]) == @graph.nodes_count?)
        @node_process = false;
      end
      process_connections(line);
    else
      root_node_index = data[0]
      algorithm = data[1]
      query = Query.new(root_node_index, algorithm)
      @graph.push_query(query)
    end
  end

  def create_graph(nodes)
    @graph = Graph.new(Integer(nodes),@graphs.size+1)
    @graphs.push(@graph)
    @node_process = true;
  end

  def end_of_graph_data?(data)
    return (data.size == 2 && data[0] == "0" && data[1] == "0")
  end

  def process_connections(line)
    data = line.split(/ /);
    node = @graph.get_node(Integer(data[0]))
    connections = Integer(data[1])
    2.upto(connections+1) { |i|
      node.create_connection(@graph.get_node(Integer(data[i])))
    }
  end
end

class Search
  def initialize

  end

  public

  def execute(root_node_index,graph)
    root_node = graph.get_node(root_node_index)
    @graph = graph
    execute_algorithm(root_node)
    print_output_and_clear()
    @graph.refresh_nodes()
  end

  protected

  def execute_algorithm
     raise NotImplementedError
  end

  private

  def print_output_and_clear
    output = ""
    for n in @array
      output = output + "#{n.index} "
    end
    puts output
    @array.clear
  end
end

class BFS < Search
  @queue
  @array

  def initialize()
    @queue = Queue.new
    @array = Array.new
  end

  def execute_algorithm(rootNode)
    @queue.push(rootNode)
    rootNode.close
    while (not @queue.empty?)
      node = @queue.pop
      search(node)
      @array.push(node)
    end
  end

  private

  def search(node)
    nodes = node.neighbours
    for neighbour in nodes
      if (not neighbour.closed?)
        neighbour.close
        @queue.push(neighbour)
      end
    end
  end

end

class DFS < Search

  def initialize()
    @array = Array.new
  end

  def execute_algorithm(rootNode)
    search(rootNode)
  end

  private
  def search(node)
    @array.push(node)
    node.close
    for neighbour in node.neighbours
      if (not neighbour.closed?)
        search(neighbour)
      end
    end
  end
end

parser = InputParser.new()
graphs = parser.process_input_from_stdin()
bfs = BFS.new
dfs = DFS.new
for gr in graphs
  puts "graph #{gr.number}"
  for q in gr.queries
    if (q.algorithm == 1)
      bfs.execute(q.root_node_index, gr)
    elsif (q.algorithm == 0)
      dfs.execute(q.root_node_index,gr)
    end

  end
end







