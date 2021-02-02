require_relative("node.rb")

class Tree
    def initialize(array=[])
        @array = array.uniq.sort
        @root = build_tree(@array)
    end
    def build_tree(arr, parent=nil)
        if arr.empty?
            return nil
        end
        center = arr.length / 2.0
        node = Node.new(arr[center])
        arr -= [arr[center]]
        left = arr[...center]
        right = arr[center..]
        unless parent.nil?
            node.sort(parent)
        end
        build_tree(left, node)
        build_tree(right, node)
        return node
    end
    def insert(args)
        args.each do |data|
            node = Node.new(data)
            node.sort(@root)
        end
    end
    def delete(args)
        args.each do |data|
            result = @root.delete(data, @root)
            unless result.nil?
                @root = result
                puts "New root determined (#{@root.data})!"
            end
            puts "Deletion of #{data} completed!"
        end
    end
    def find(args)
        args.each do |data|
            result = @root.find(data, @root)
            if result.nil?
                puts "#{data} was not found!"
                return nil
            else
                puts "#{data} found at #{result}!"
                return result
            end
        end
    end
    def level_order(node=@root, queue=[@root])
        if queue.empty?
            puts "end"
            return
        else
            print "#{queue.shift.data} --> "
        end
        unless node.left_branch.nil?
            queue.push(node.left_branch)
        end
        unless node.right_branch.nil?
            queue.push(node.right_branch)
        end
        level_order(queue[0], queue)
    end
    def level_order?(node=@root, queue=[@root], result_array=[])
        if queue.empty?
            return result_array
        else
            result_array.push(queue.shift)
        end
        unless node.left_branch.nil?
            queue.push(node.left_branch)
        end
        unless node.right_branch.nil?
            queue.push(node.right_branch)
        end
        level_order?(queue[0], queue, result_array)
    end
    def height(parent_search, child)
        parent = find([parent_search])
        if parent.nil?
            puts "#{parent_search} was not found, could not check height of #{child}!"
            return
        end
        result = parent.find_depth(child, parent)
        if result.nil?
            puts "#{child} was not found as a child of #{parent.data}, could not check height!"
        else
            puts "The height of #{child} from #{parent.data} is #{result}"
        end
    end
    def depth(data)
        result = @root.find_depth(data, @root)
        if result.nil?
            puts "#{data} was not found, could not check depth!"
        else
            puts "The depth of #{data} is #{result}"
        end
    end
    def balanced?
        nodes = level_order?
        nodes.each do |node|
            difference = node.balanced?
            unless difference < 2
                puts "Node #{node.data} is unbalanced!"
            end
        end
    end
    def rebalance
        puts "Rebalancing tree"
        arr = level_order?
        data = []
        arr.each do |node|
            data.push(node.data)
        end
        @root = build_tree(data.sort.uniq)
    end
    #Thanks for the print method random student!
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_branch, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_branch
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left_branch, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_branch
    end
end
