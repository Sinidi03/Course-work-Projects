#Sinidi Yashara Balasooriya-10673683
class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        self.height = 1  # height for leaf node is 1


class AVLTree:
    def __init__(self):
        self.node = None

    def _height(self, node):
        return node.height if node else 0

    def _update_height(self, node):
        node.height = 1 + max(self._height(node.left), self._height(node.right))

    def _balance_factor(self, node):
        return self._height(node.left) - self._height(node.right)

    def _rotate_left(self, z):
        y = z.right
        T2 = y.left
        y.left = z
        z.right = T2
        self._update_height(z)
        self._update_height(y)
        return y

    def _rotate_right(self, z):
        y = z.left
        T3 = y.right
        y.right = z
        z.left = T3
        self._update_height(z)
        self._update_height(y)
        return y

    def _rebalance(self, node):
        self._update_height(node)
        balance = self._balance_factor(node)

        if balance > 1:
            if self._balance_factor(node.left) < 0:
                node.left = self._rotate_left(node.left)
            return self._rotate_right(node)

        if balance < -1:
            if self._balance_factor(node.right) > 0:
                node.right = self._rotate_right(node.right)
            return self._rotate_left(node)

        return node

    def insert(self, key):
        inserted, self.node = self._insert(self.node, key)
        return inserted

    def _insert(self, node, key):
        if node is None:
            return True, Node(key)
        if key == node.key:
            print(f"Key {key} already exists.")
            return False, node
        elif key < node.key:
            inserted, node.left = self._insert(node.left, key)
        else:
            inserted, node.right = self._insert(node.right, key)
        return inserted, self._rebalance(node)

    def _get_min_value_node(self, node):
        current = node
        while current.left:
            current = current.left
        return current

    def delete_AVLNode(self, key):
        self.node, deleted = self._delete(self.node, key)
        return deleted

    def _delete(self, node, key):
        if node is None:
            return node, False

        deleted = False
        if key < node.key:
            node.left, deleted = self._delete(node.left, key)
        elif key > node.key:
            node.right, deleted = self._delete(node.right, key)
        else:
            deleted = True
            if node.left is None:
                return node.right, deleted
            elif node.right is None:
                return node.left, deleted
            else:
                temp = self._get_min_value_node(node.right)
                node.key = temp.key
                node.right, _ = self._delete(node.right, temp.key)

        if node is None:
            return node, deleted

        return self._rebalance(node), deleted

    def inorder_traverse(self):
        return self._inorder(self.node)

    def _inorder(self, node):
        return self._inorder(node.left) + [node.key] + self._inorder(node.right) if node else []

    def preorder_traverse(self):
        return self._preorder(self.node)

    def _preorder(self, node):
        return [node.key] + self._preorder(node.left) + self._preorder(node.right) if node else []

    def postorder_traverse(self):
        return self._postorder(self.node)

    def _postorder(self, node):
        return self._postorder(node.left) + self._postorder(node.right) + [node.key] if node else []

    def avl_search(self, key):
        return self._search(self.node, key)

    def _search(self, node, key):
        if node is None or node.key == key:
            return node
        return self._search(node.left, key) if key < node.key else self._search(node.right, key)

    def depth_nodeAVL(self, key):
        return self._depth(self.node, key, 0)

    def _depth(self, node, key, depth):
        if node is None:
            return -1
        if key == node.key:
            return depth
        return self._depth(node.left, key, depth + 1) if key < node.key else self._depth(node.right, key, depth + 1)

    def leaf_nodes(self):
        result = []
        self._collect_leaf_nodes(self.node, result)
        return result

    def _collect_leaf_nodes(self, node, result):
        if node:
            if node.left is None and node.right is None:
                result.append(node.key)
            self._collect_leaf_nodes(node.left, result)
            self._collect_leaf_nodes(node.right, result)

    def non_leaf_nodes(self):
        result = []
        self._collect_non_leaf_nodes(self.node, result)
        return result

    def _collect_non_leaf_nodes(self, node, result):
        if node:
            if node.left or node.right:
                result.append(node.key)
            self._collect_non_leaf_nodes(node.left, result)
            self._collect_non_leaf_nodes(node.right, result)

    def print_statistics(self):
        from collections import defaultdict
        counts = defaultdict(int)
        self._count_depths(self.node, 0, counts)
        print("\nDepth of nodes | Count")
        for depth in sorted(counts):
            print(f"{depth:<15} {counts[depth]}")

    def _count_depths(self, node, depth, counts):
        if node:
            counts[depth] += 1
            self._count_depths(node.left, depth + 1, counts)
            self._count_depths(node.right, depth + 1, counts)

    def display(self, node=None, level=0, pref=''):
        if node is None:
            node = self.node  # start at root

        if node is None:
            return

        # Display left subtree first (indented deeper)
        if node.left is not None:
            self.display(node.left, level + 1, ' <')

        # Calculate balance factor for this node
        balance = self._balance_factor(node)

        # Check if leaf node
        is_leaf = (node.left is None and node.right is None)

        # Print current node info with indent and prefix
        print('-' * (level * 2), pref, node.key, f"[{node.height}:{balance}]", 'L' if is_leaf else '')

        # Display right subtree
        if node.right is not None:
            self.display(node.right, level + 1, ' >')



    def level1_menu(self):
        while True:
            print("\nLevel-1 Menu:")
            print("1. Load a preset sequence of integers to build an AVL tree")
            print("2. Manually enter integer keys one by one to build an AVL tree")
            print("3. Exit")
            choice = input("Enter your choice: ")

            if choice == '1':
                self.node = None
                preset_data =  [60, 40, 80, 30, 50, 70, 90, 20, 35, 45, 55, 65, 75, 85, 93, 10, 25, 48, 95, 15]

                for key in preset_data:
                    self.insert(key)
                self.level2_menu()

            elif choice == '2':
                self.node = None
                user_input = input("Enter integers separated by spaces: ")
                try:
                    data = list(map(int, user_input.strip().split()))
                    for key in data:
                        self.insert(key)
                    self.level2_menu()
                except ValueError:
                    print("Please enter valid integers.")

            elif choice == '3':
                print("Exiting the application.")
                break
            else:
                print("Invalid choice. Please try again.")

    def level2_menu(self):
        while True:
            print("\nLevel-2 Menu:")
            print("1. Display the AVL tree with height and balance factor")
            print("2. Print preorder, inorder, and postorder traversals")
            print("3. Show all leaf and non-leaf nodes")
            print("4. Insert a new key")
            print("5. Delete a key")
            print("6. Print node depth statistics")
            print("7. Return to Level-1 Menu")
            choice = input("Choose an option: ")
            if choice == '1':
                print("\n== AVL Tree Structure (key [height:balance]) ==")
                self.display()
            elif choice == '2':
                print("Pre-order:", self.preorder_traverse())
                print("In-order:", self.inorder_traverse())
                print("Post-order:", self.postorder_traverse())
            elif choice == '3':
                print("Leaf nodes:", self.leaf_nodes())
                print("Non-leaf nodes:", self.non_leaf_nodes())
            elif choice == '4':
                try:
                    value = int(input("Enter value to insert: "))
                    if self.insert(value):
                        print("Key inserted.")
                    else:
                        print("Duplicate key. Insertion failed.")
                except ValueError:
                    print("Invalid input.")
            elif choice == '5':
                try:
                    value = int(input("Enter value to delete: "))
                    if self.delete_AVLNode(value):
                        print("Key deleted.")
                    else:
                        print("Key not found. Deletion failed.")
                except ValueError:
                    print("Invalid input.")
            elif choice == '6':
                self.print_statistics()
            elif choice == '7':
                break
            else:
                print("Invalid choice. Try again.")


if __name__ == "__main__":
    tree = AVLTree()
    tree.level1_menu()
    input("Press Enter to exit.")
