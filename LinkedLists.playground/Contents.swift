/// What is LINKED LISTS?
/// Collection of nodes
/// Nodes contain values/data and pointer to the next and/or previous node
/// Singly lists have just the next nodes pointer
/// Implementing doubly lists here ie it has next and previous nodes pointers

import UIKit
/// Create a node as a class, this has to be a reference type. Cannot use structs here
public class LLNode<T> {
    var value: T
    var next: LLNode?
    var previous: LLNode?
    
    public init(value: T) {
        self.value = value
    }
}
/// typealias here allows provide a new name for an existing data type in the program
public class LinkedList<T> {
    
    /// creating a type alias to avoid writing <T> everytime we acces the LLNode element
    public typealias Node = LLNode<T>
    
    ///Creating a Head node, this will be first node in the linked list
    public var head: Node?
    public var first: Node? {
        return head
    }
    
    ///Creating a Tail node, this will be last node in the linked list
    public var last : Node? {
        /// check if head node exists else Linked list is empty
        guard var node = head else { return nil }
        
        ///loop through all the nodes till next is nil, which will be out last node
        while let next = node.next {
            node = next
        }
        return node
    }
    
    /// Count the number of node
    public var count: Int {
        guard var node = head else {
            return 0
        }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    ///Print the values in the linked list
    public var print: String {
        guard var node = head else {
            return "[]"
        }
        var stringArray = "[\(node.value),"
        while let next = node.next {
            node = next
            stringArray += "\(node.value),"
        }
        return stringArray + "]"
    }
    //MARK: - Append
    /// Add nodes to linked list
    public func append(_ value: T) {
        let newNode = Node(value: value)
        
        /// Check if linked List has nodes
        /// If list has nodes, we will have a last node
        if let lastNode = last {
            
            /// newNode that is being added will now be the last node in the list
            /// newNodes next will now be nil, and previous will be last
            newNode.previous = last
            
            ///last node's next will be the new Node
            lastNode.next = newNode
        }
        else {
            ///When linked list is empty newNode is the head node
            head = newNode
        }
    }
    //MARK: - Search
    /// search node in linked list
    public func searchNode(atIndex index: Int) -> Node {
        ///if index is 0 return the first/head node
        if index == 0 {
            return first!
        }
        else {
            var node = first?.next
            /// get the next nodes in list after the first node
            for _ in 1 ..< index {
                node = node?.next
                /// when next is nil, it is the last node, hence break the loop
                if node == nil { break }
            }
        return node!
        }
    }
    //MARK: - Insert At Index
    /// Insert node at index
    public func insertNode(_ value: T, atIndex index: Int) {
        let newNode = Node(value: value)
        if index == 0 {
            ///push the head to next  index
            /// set the new node as the head
            newNode.next = head
            head?.previous = newNode
            head = newNode
        }
        else {
            ///get the index - 1 node
            let previousNode = searchNode(atIndex: index - 1)
            let nextNode = previousNode.next
            /// connect the newNodes previous and next to existing nodes
            newNode.previous = previousNode
            newNode.next = previousNode.next
            
            /// Updates the existing nodes next and Previous pointer to point to the newNode
            previousNode.next = newNode
            nextNode?.previous = newNode
        }
    }
    //MARK: - Remove
    /// Mark Remove Node at index
    func removeNode(_ node: Node) -> T {
        let previousNode = node.previous
        let nextNode = node.next
        if let previousNode = previousNode {
            /// if node is not a head node or previous of a node is not nil
            previousNode.next = nextNode
        }
        else {
            /// if the node to be removed is the head node, nextNode will now be the head
           head = nextNode
        }
        
        nextNode?.previous = previousNode
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    func removeAt(_ index: Int) -> T {
    /// fetch the node to remove
    let nodeToRemove = searchNode(atIndex: index)
        return removeNode(nodeToRemove)
    }
    
}
let linkedLists = LinkedList<Int>()
linkedLists.append(1)
linkedLists.append(2)
linkedLists.append(3)
linkedLists.print
linkedLists.insertNode(33, atIndex: 0)
linkedLists.print
linkedLists.insertNode(4, atIndex: 2)
linkedLists.print
linkedLists.removeAt(2)
linkedLists.print
linkedLists.removeAt(0)

