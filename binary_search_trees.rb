require 'pry-byebug'
class Node

    attr_accessor :value, :left, :right

    def initialize(value, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
    end

end

class Tree

    attr_accessor :root

    def build_tree(arr)
        arr = arr.sort
        middle = arr.length/2
        root = Node.new(arr[middle])
        if arr.length > 1
            frontarr = arr[..middle-1]
            backarr = arr[middle+1..]
            root.left = build_tree(frontarr)
            root.right = build_tree(backarr)
        end
        @root = root
    end

    def find(value, start_node=@root, parent_node=nil)
        node = start_node
        if node.value == value
            return node, parent_node
        elsif value < node.value
            if node.left == nil
                return nil
            else
                parent_node = node
                find(value, node.left, parent_node)
            end
        elsif value > node.value
            if node.right == nil
                return nil
            else
                parent_node = node
                find(value, node.right, parent_node)
            end
        end
    end


    

    def insert(value, node=@root)
        if value == node.value
            return "No duplicate values allowed."
        elsif value < node.value
            if !node.left
                node.left = Node.new(value)
            else
                insert(value, node.left)
            end
        elsif value > node.value
            if !node.right
                node.right = Node.new(value)
            else
                insert(value, node.right)
            end
        end
    end
    

    def delete(value, start_node=@root)
        
        nodes = self.find(value, start_node)
        node = nodes[0]
        parent_node = nodes[1]
        if !parent_node
            @root = nil
        else
            case
            when !node.left && !node.right
                case
                when parent_node.left == node
                    parent_node.left = nil
                when parent_node.right == node
                    parent_node.right = nil
                end
            when node.left && !node.right
                case
                when parent_node.left == node
                    parent_node.left = node.left
                when parent_node.right == node
                    parent_node.right = node.left
                end
            when node.right && !node.left
                case
                when parent_node.left == node
                    parent_node.left = node.right
                when parent_node.right == node
                    parent_node.right = node.right
                end
            when node.left && node.right
                inorder_sub = node.right
                while inorder_sub.left
                    inorder_parent = inorder_sub
                    inorder_sub = inorder_sub.left
                end
                inorder_parent.left = nil
                inorder_sub.left = node.left
                inorder_sub.right = node.right
                case
                when parent_node.left == node
                    parent_node.left = inorder_sub
                when parent_node.right == node
                    parent_node.right = inorder_sub
                end
            end
        end   
    end

    def level_order(node=@root, q=[@root])
        arr = []
        while q.any?
            node = q.shift
            block_given? ? yield(node) : arr.push(node)
            if node.left
                q << node.left
            end
            if node.right
                q << node.right
            end
        end
        if !block_given? 
            return arr
        end
    end

    def inorder(node=@root, arr=[], &block)
        if node.left
            inorder(node.left, arr, &block)
        end
        if block_given?
            yield(node)
        else
            arr << node
        end
        if node.right
            inorder(node.right, arr, &block)
        end
        arr
    end

    def preorder(node=@root, arr=[], &block)
        if block_given?
            yield(node)
        else
            arr << node
        end
        if node.left
            preorder(node.left, arr, &block)
        end
        if node.right
            preorder(node.right, arr, &block)
        end
        arr
    end

    def postorder(node=@root, arr=[], height=0, &block)
        if node.left
            postorder(node.left, arr, height+1, &block)
        end
        if node.right
            postorder(node.right, arr, height+1, &block)
        end
        if block_given?
            yield(node, height)
        else
            arr << node
        end
        arr
    end

    def height(node=@root)
        max_height = 0
        self.postorder(node) do |node, height| 
            if height > max_height
                max_height = height
            end
        end
        max_height
    end

    def depth(node=@root)
        result = 0
        self.postorder(@root) do |this_node, depth|
            if this_node == node
                return depth
            end
        end
    end

    def balanced?(node=@root)
        heights = []
        self.postorder(node) do |node, height|
            if !node.left && !node.right
                heights << height
            end
        end
        if heights.uniq.length == 1
            return true
        elsif heights.uniq.length == 2
            heights.sort[1] - heights.sort[0] <= 1
            return true
        else
            return false
        end
    end
    
    def rebalance
        arr = []
        self.postorder{ |node| if node.value then arr << node.value end}
        self.build_tree(arr)
    end

end

tree = Tree.new
tree.build_tree([1, 5, 8, 6, 10, 7, 3, 4])
# p tree
# p tree.find(10)
#p tree.insert(11)
# p tree.insert(11)
p tree.insert(9)
p tree.insert(13)
p tree.insert(14)
p tree.insert(15)
# p tree.delete(9)
# p tree.delete(5)
# p tree.delete(2)
# p tree.root
# p tree.level_order { |node| p node }
#p tree.inorder{ |node| p node }
#p tree.preorder{ |node| p node }
#p tree.postorder{ |node, height| p node; p height }
#p tree.height(tree.root)
#p tree.depth(tree.root.left.left)
p tree.balanced?
p tree
tree.rebalance
p tree
p tree.balanced?






