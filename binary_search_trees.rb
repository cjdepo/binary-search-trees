module Comparable
end

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
        if arr.length != 1
            frontarr = arr[..middle-1]
            backarr = arr[middle+1..]
            root.left = build_tree(frontarr)
            root.right = build_tree(backarr)
        end
        @root = root
    end

    def find(value, start_node=@root)
        node = start_node
        if node.value == value
            return node
        elsif value < node.value
            if node.left == nil
                return "Not found!"
            else
                find(value, node.left)
            end
        elsif value > node.value
            if node.right == nil
                return "Not found!"
            else
                find(value, node.right)
            end
        end
    end


    

    def insert(value, start_node=@root)
        node = start_node
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
        node = start_node
        if value == node.value
            if !node.left && !node.right
                # replace reference from parent node with nil
            elsif node.left
                # replace reference from parent node with node.left
            elsif node.right
                # replace reference from parent node with node.right
            end
        elsif value < node.value
        elsif value > node.value
        
        end
    end
end

tree = Tree.new
tree.build_tree([1, 5, 8, 6, 10, 7, 2])
p tree.find(10)
p tree.insert(11)
p tree.insert(11)
p tree.root