class Node
    include Comparable
    attr_reader :data, :left_branch, :right_branch
    def initialize(data=nil)
        @data = data
        @left_branch = nil
        @right_branch = nil
    end
    def sort(parent)
        case  @data <=> parent.data
        when -1
            if parent.left_branch.nil?
                parent.set_left_branch(self)
                return
            else
                sort(parent.left_branch)
            end
        when 1
            if parent.right_branch.nil?
                parent.set_right_branch(self)
                return
            else
                sort(parent.right_branch)
            end
        end
    end
    def set_left_branch(node)
        @left_branch = node
    end
    def set_right_branch(node)
        @right_branch = node
    end
    def delete(data, node)
        if data == node.data
            puts "Deleting root!"
            left = node.left_branch
            right = node.right_branch
            unless left.nil?
                right.sort(left)
                return left
            end
            unless right.nil?
                left.sort(right)
                return right
            end
        end
        parent = find_parent(data, node)
        if parent.nil?
            puts "Node was not found!"
            return nil
        end
        child = nil
        unless parent.left_branch.nil?
            if parent.left_branch.data == data
                child = parent.left_branch
                parent.set_left_branch(nil)
            end
        end
        unless parent.right_branch.nil?
            if parent.right_branch.data == data
                child = parent.right_branch
                parent.set_right_branch(nil)
            end
        end
        left = child.left_branch
        right = child.right_branch
        unless left.nil?
            left.sort(node)
        end
        unless right.nil?
            right.sort(node)
        end
        return nil
    end
    def find(data, node)
        case data <=> node.data
        when -1
            unless node.left_branch.nil?
                find(data, node.left_branch)
            end
        when 0
            return node
        when 1
            unless node.right_branch.nil?
                find(data, node.right_branch)
            end
        end
    end
    def find_parent(data, node, parent=nil)
        case data <=> node.data
        when -1
            unless node.left_branch.nil?
                find_parent(data, node.left_branch, node)
            end
        when 0
            return parent
        when 1
            unless node.right_branch.nil?
                find_parent(data, node.right_branch, node)
            end
        end
    end
    def find_depth(data, node, i=0)
        case data <=> node.data
        when -1
            unless node.left_branch.nil?
                find_depth(data, node.left_branch, i+1)
            end
        when 0
            return i
        when 1
            unless node.right_branch.nil?
                find_depth(data, node.right_branch, i+1)
            end
        end
    end
    def balanced?
        left = self.left_branch
        right = self.right_branch
        left_count = 0
        right_count = 0
        unless left_branch.nil?
            left_count = follow_left_branch(self)
        end
        unless right_branch.nil?
            right_count = follow_right_branch(self)
        end
        difference = (left_count - right_count).abs
        return difference
    end
    def follow_left_branch(node=self,i=0)
        if node.left_branch.nil?
            return i
        else
            follow_left_branch(node.left_branch, i+1)
        end
    end
    def follow_right_branch(node=self,i=0)
        if node.right_branch.nil?
            return i
        else
            follow_right_branch(node.right_branch, i+1)
        end
    end
end