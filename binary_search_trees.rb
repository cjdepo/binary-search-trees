
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
end

tree = Tree.new
tree.build_tree([1, 5, 8, 6, 10, 7, 2])
p tree
p tree.find(10)
p tree.insert(11)
p tree.insert(11)
p tree.insert(9)
p tree.delete(9)
p tree.delete(5)
p tree.delete(2)
p tree.root