package com.powerteam.vo;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TreeNode<T> {

    public TreeNode() {
        Children = new ArrayList<>();
    }

    private T Node;
    private List<TreeNode<T>> Children;
	public T getNode() {
		return Node;
	}
	public void setNode(T node) {
		Node = node;
	}
	public List<TreeNode<T>> getChildren() {
		return Children;
	}
	public void setChildren(List<TreeNode<T>> children) {
		Children = children;
	}
    
    
    
}
