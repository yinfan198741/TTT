//
//  ll.cpp
//  TT
//
//  Created by 尹凡 on 2021/1/14.
//  Copyright © 2021 fanyin. All rights reserved.
//

#include "ll.hpp"
#include <iostream>
#include <cmath>
#include<algorithm>
#include <vector>

struct _node {
  int val;
  _node *left;
  _node *right;
  _node(int x) : val(x), left(NULL), right(NULL) {}
};


typedef _node TreeNode;




int inorderPosition( std::vector<int>& inorder, long value)
{
  for (int i = 0 ; i < inorder.size(); i++) {
    if (inorder[i] == value) {
      return i;
    }
  }
  return -1;
}


TreeNode* buildSubTree(std::vector<int>& preorder, long idx, long size,
                       std::vector<int>& inorder,  long in_start,long in_end)
{
  if (in_start > in_end || idx < 0 || idx > size) {
      return nullptr;
  }
  int value = preorder[idx];
  printf("value = %d" , value);
  TreeNode* root = new TreeNode(value);
  int inorderIndex = inorderPosition(inorder, value);
  
  long leftIndex = ++idx;
  long inOrderLeft = in_start;
  long inOrderLeftMax = inorderIndex - 1;
  
  root->left = buildSubTree(preorder ,leftIndex ,size , inorder , inOrderLeft ,inOrderLeftMax);
  
  long rightIndex = inorderIndex + 1;
  long inOrderRight = rightIndex;
  long inOrderRightMax = in_end;
  
  root->right = buildSubTree(preorder , rightIndex, size , inorder , inOrderRight , inOrderRightMax);
  
  return root;
}

TreeNode* buildTree(std::vector<int>& preorder, std::vector<int>& inorder)
{
  long size = preorder.size() - 1;
  TreeNode* root = buildSubTree(preorder , 0, size, inorder , 0 , size);
  return root;
}



void buildTree()
{
  printf("123\n");
  ///前序 跟左右
  std::vector<int> preOrder {1,2,4,7,3,5,6,8};
  ///中序 左跟右
  std::vector<int> inorder {4,7,2,1,5,3,8,6};
  
  
//  std::vector<int> preOrder {1,2,3};
  ///中序 左跟右
//  std::vector<int> inorder {2,1,3};
  
  TreeNode* root = buildTree(preOrder, inorder);
  printf("root");
}


//int diameterOfBinaryTree(TreeNode* root) {
//
//  if (root == NULL) {
//    return 0;
//  }
//
//  if (root->left == NULL && root->right == NULL)
//      {
//    return 1;
//      }
//
//  if(root->left != NULL)
//      {
//    return 1 + diameterOfBinaryTree(root->left);
//      }
//
//  if(root->right != NULL)
//      {
//    return 1 + diameterOfBinaryTree(root->right);
//      }
//
//
//
//  int left = std::max(diameterOfBinaryTree(root->left), 1);
//  int right = std::max(diameterOfBinaryTree(root->right), 1);
//  return left + right;
//}

int result = 0;

int diaTree2(TreeNode* root)
{
  if (root->left == NULL && root->right == NULL) return 0;
  ///左边的最大深度
  int left = root->left != NULL ? 1 + diaTree2(root->left) : 0 ;
  ///右边的最大深度
  int right = root->right != NULL ? 1 + diaTree2(root->right) : 0;
  
  result = std::max(result, left + right);
  ///返回当前节点的最大深度
  return std::max(left, right) ;
}


int diameterOfBinaryTree(TreeNode* root) {
  if (root == NULL) {
    return 0;
  }
  diaTree2(root);
  return result;
}

int diaTree(TreeNode* root)
{
  if (root == NULL) return 0;
  ///左边的最大深度
  int left =  diaTree(root->left) ;
  ///右边的最大深度
  int right =  diaTree(root->right) ;
  result = std::max(result, left + right);
  ///返回当前节点的最大深度
  return std::max(left, right) + 1;
}

int diameterOfBinaryTree5(TreeNode* root) {
  diaTree2(root);
  return result;
}






int maxd = 0;
int Height(TreeNode *root) {
  if (root == NULL) return 0;
  int L = Height(root->left);
  int R = Height(root->right);
  maxd = std::max(maxd, R + L);
  return std::max(R, L) + 1;
}

int ddiameterOfBinaryTree(TreeNode* root) {
  Height(root);
  return maxd;
}

int max = 0;
int getDiameter(TreeNode* root) {
  if (root == NULL) return 0;
  int left = getDiameter(root->left);
  int right = getDiameter(root->right);
  max = std::max(max, left+right);
  return std::max(left, right) + 1;
}

bool preOrderTra(TreeNode* root, TreeNode* p, std::vector<TreeNode*>& nodes)
{
  
  
  if(root == NULL)
      {
    return false;
      }
  
  
  //  std::cout << "push_back" << root->val << std::endl;
  nodes.push_back(root);
  
  if(root->val == p->val)
      {
    return true;
      }
  
  bool find_l = preOrderTra(root->left, p, nodes);
  if(find_l )
      {
    return true;
      }
  bool find_r = preOrderTra(root->right, p, nodes);
  
  if( find_r)
      {
    //    std::cout<< "findr"<< std::endl;
    return true;
      }
  
  nodes.pop_back();
  //  std::cout << "pop_back" << root->val << std::endl;
  return false;
  
}


TreeNode* findLastEqual(std::vector<TreeNode*>& pRoot,std::vector<TreeNode*>& qRoot)
{
  std::cout<< "pRoot"<< std::endl;
  for(int i = 0 ; i< pRoot.size(); i ++)
      {
    std::cout<< " " << pRoot[i]->val;
      }
//  std::cout<< "qRoot"<< std::endl;
  for(int i = 0 ; i< qRoot.size(); i ++)
      {
    std::cout<< " " << qRoot[i]->val;
      }
  
  
  int size = std::min(pRoot.size(), qRoot.size()) ;
  
  int idx = -1;
  for (int i = size - 1 ; i>= 0; i--)
      {
    if(pRoot[i]->val == qRoot[i]->val)
        {
      idx = i;
      break;
        }
      }
  if (idx>-1) {
     return pRoot[idx];
  }
  return NULL;
}



TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
  
  std::cout<< p->val<< std::endl;
  std::cout<< q->val<< std::endl;
  
  // if(p->val == q->val)
  // {
  //     return p;
  // }
  
//  p->val = 2;
  
  
  
   std::vector<TreeNode*> pRoot;
   preOrderTra(root, p, pRoot);
   std::cout<<"start pRoot:======= : "<< p->val << std::endl;
   for(int i = 0 ; i< pRoot.size(); i ++)
   {
       std::cout<< " " << pRoot[i]->val;
   }
   std::cout<<std::endl;
   std::cout<<"end pRoot:======= : "<< p->val << std::endl;
  
  
  
  std::vector<TreeNode*> qRoot;
  preOrderTra(root, q, qRoot);
  std::cout<<"start qRoot:======= : " << q->val << std::endl;
  for(int i = 0 ; i< qRoot.size(); i ++)
      {
      std::cout<< " " << qRoot[i]->val;
      }
   std::cout<<std::endl;
   std::cout<<"end qRoot:======= : " << q->val << std::endl;
  // preOrderTra(root, p, pRoot);
  
   TreeNode* lastE = findLastEqual(pRoot,qRoot);
  
  std::cout<< "lastE->val "<< lastE->val  << std::endl;
  return lastE;
}


void quicksort()
{
  int a[] = {3 , 2, 1, 4, 7, 6};
  int size = sizeof(a)/sizeof(int);
  printf("size = %ld",size);
}


void createTree()
{
  
  TreeNode node_0(0);
  TreeNode node_1(1);
  TreeNode node_2(2);
  TreeNode node_3(3);
  TreeNode node_4(4);
  TreeNode node_5(5);
  TreeNode node_6(6);
  TreeNode node_7(7);
  TreeNode node_8(8);
  TreeNode node_9(9);
  
  
  
  node_6.left = &node_2;
  node_6.right = &node_8;
  
  node_2.left = &node_0;
  node_2.right = &node_4;
  
  node_4.left = &node_3;
  node_4.right = &node_5;
  
  node_8.left = &node_7;
  node_8.right = &node_9;
  
  
  
  lowestCommonAncestor(&node_6, &node_2, &node_4);
//  node_1.left = &node_2;
//  node_1.right = &node_3;
//  node_2.left = &node_4;
//  node_2.right = &node_5;
  
//  int deep1 = diameterOfBinaryTree(&node_1);
//  std::cout<< deep1 << std::endl;
//
//
//  int deep2 = getDiameter(&node_1);
//  std::cout<< deep2 << std::endl;
  
  
//  int deep3 =  diaTree(&node_1);
//  std::cout<< deep3 << std::endl;
  
//  int deep = getDiameter(&node_1);
 
  
//  int deep4 = ddiameterOfBinaryTree(&node_1);
//  std::cout<< deep4 << std::endl;
  
//  int deep5 = diameterOfBinaryTree5(&node_1);
//  std::cout<< deep5 << std::endl;
  
  
}


typedef enum : int {
  H_Right,
  H_Left,
  V_Down,
  V_Up
} direct;


int getMatrix(std::vector<std::vector<int>>& matrix, int x ,int y)
{
  int value = matrix[y][x];
  return value;
}

void printIndex(std::vector<std::vector<int>>& matrix,
                int startX, int startY,
                int endX, int endY,
                int direction,
                std::vector<int>& values)
{
  
  if (direction == H_Right) {
    while (startX <= endX) {
      int v = getMatrix(matrix, startX, startY);
      printf("%d ", v);
      values.push_back(v);
      startX++;
    }
  }
  
  if (direction == V_Down) {
    while (startY <= endY) {
      int v = getMatrix(matrix, startX, startY);
      printf("%d ", v);
      values.push_back(v);
      startY++;
    }
  }
  
  if (direction == H_Left) {
    while (startX >= endX) {
      int v = getMatrix(matrix, startX, startY);
      printf("%d ", v);
      values.push_back(v);
      startX--;
    }
  }
  
  if (direction == V_Up) {
    while (startY >= endY) {
      int v = getMatrix(matrix, startX, startY);
      printf("%d ", v);
      values.push_back(v);
      startY--;
    }
  }
  
}


bool lineCross(int x, int y, int startX, int startY, int endX, int endY)
{
  
  while (endY >= startY) {
    
    if (startX == x && startY == y) {
      return true;
    }
    
    startY++;
  }
  return false;
}

bool lineCrossX(int x, int y, int startX, int startY, int endX, int endY)
{
  
  while (endX <= startX) {
    
    if (startX == x && startY == y) {
      return true;
    }
    
    startX--;
  }
  return false;
}



//public:
std::vector<int> spiralOrder(std::vector<std::vector<int>>& matrix) {
  printf("matrix\n");
  
  
  std::vector<int> prints;
  
  int width = (int)matrix[0].size() - 1;
  int height = (int)matrix.size() - 1;
  
//  if (width == 0 && height == 0) {
//    return {matrix[0][0]};
//  }
//
//  if (width == 0) {
//    for (int i = 0 ; i < matrix.size(); i++) {
//      prints.push_back(matrix[i][0]);
//    }
//    return prints;
//  }
//
//  if (height == 0) {
//    for (int i = 0 ; i < matrix[0].size(); i++) {
//      prints.push_back(matrix[0][i]);
//    }
//    return prints;
//  }
  
  
  
  int originStartX = 0;
  int originStartY = 0;
  
  int loopCount = width > 0 && height > 0 ? std::min(matrix[0].size(), matrix.size()) / 2 : 0;
//  bool hasLast = matrix[0].size() % 2 != 0 || matrix.size() % 2 != 0;
  
  
  
  int startX2 = 0 ;
  int startY2 = 0;
  int endX2 = 0;
  int endY2 = 0;
  
  
  int startX3 = 0;
  int startY3 = 0;
  int endX3 = 0;
  int endY3 = 0;
  
  for (int loopIdx = 0; loopIdx < loopCount; loopIdx++) {
    
    ///上
    int startX1 = originStartX + loopIdx;
    int startY1 = originStartY + loopIdx;
    int endX1 = width - loopIdx - 1;
    int endY1 = startY1;
    ///横坐标
    printIndex(matrix, startX1, startY1, endX1, endY1, H_Right, prints);
    
    //右
     startX2 = width - loopIdx;
     startY2 = loopIdx;
     endX2 = startX2;
     endY2 = height - loopIdx - 1;
    
    printIndex(matrix, startX2, startY2, endX2, endY2, V_Down, prints);
    
    
    //下
     startX3 = width - loopIdx;
     startY3 = height - loopIdx;
     endX3 = loopIdx + 1;
     endY3 = startY3;
    
    printIndex(matrix, startX3, startY3, endX3, endY3, H_Left , prints);
    
    
    //左
    int startX4 = startX1;
    int startY4 = height - loopIdx;
    
    int endX4 = startX1;
    int endY4 = startY1 + 1;
    
    printIndex(matrix, startX4, startY4, endX4, endY4, V_Up, prints);
    
  }
  
  
  int startX1 = originStartX + loopCount;
  int startY1 = originStartY + loopCount;
  
  bool hasLastY = !lineCross(startX1, startY1, startX2, startY2, endX2, endY2);
  bool hasLastX = !lineCrossX(startX1, startY1, startX3, startY3, endX3, endY3);
  
  if (hasLastY && hasLastX) {
    ///横坐标大于
    bool h =  matrix[0].size() >  matrix.size();
    if (h) {
      int endX1 = width - loopCount;
      int endY1 = startY1 ;
      printIndex(matrix, startX1, startY1, endX1, endY1, H_Right, prints);
    }
    else {
      int endX1 =  startY1;
      int endY1 =  height - loopCount;
      printIndex(matrix, startX1, startY1, endX1, endY1, V_Down, prints);
    }
    
  }
  
  
//  [1,2,3,4,8,12,11,10,9,5,6,7]
//  1 2 3 4 8 12 11 10 9 5 6
         
  return prints;
}

using namespace std;
vector<string> ans;

void help(int l, int r, std::vector<string> &a) {
  
  if (l < 0 || r < 0) {
    return;
  }
  
  if (l > r) {
    return;
  }
  
  if (l == 0 && r == 0) {
    string v ="";
    for (int  i = 0; i < a.size() ; i++) {
      v+=a[i];
    }
    ans.push_back(v);
    return;
  }
  
  a.push_back("(");
  help(l - 1, r, a);
  a.pop_back();
  
  a.push_back(")");
  help(l, r - 1,a);
  a.pop_back();
}

vector<string> generateParenthesis(int n) {
  
  std::vector<string> p ;
  
  help(n, n, p);
  
  for (int  i = 0 ; i < ans.size(); i ++) {
    std::cout << ans[i] << std::endl;
  }
  return ans;
}


void choose(std::vector<string> source , int count, int idx, std::vector<string> values)
{
  
  if (values.size() == count) {
    for (int  i = 0 ; i < values.size(); i ++) {
      std::cout << " "<< values[i];
    }
    std::cout<<std::endl;
  }
  
  for (int i = idx; i < source.size(); i ++) {
    string v = source[i];
    values.push_back(v);
    choose(source, count, ++idx, values);
    values.pop_back();
//    choose(source, count, ++idx, values);
  }
}



void deepTree()
{
//    createTree();
//  quicksort();
//  generateParenthesis(3);
  std::vector<string> abc = {"a","b","c"};
  std::vector<string> values;
  choose(abc, 2, 0, values);
  return;
//  buildTree();
  
//  std::vector<std::vector<int>> m{{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}};
//  std::vector<std::vector<int>> m{{1,2,3},{4,5,6},{7,8,9}};
  
//  std::vector<std::vector<int>> m{{1,2,3,4},{5,6,7,8},{9,10,11,12}};
  
//  std::vector<std::vector<int>> m
//
// {{1,2,3},
//  {4,5,6},
//  {7,8,9},
//  {10,11,12}
// };
  
//  [[2,5,8],[4,0,-1]]
//  std::vector<std::vector<int>> m{{1,2,3}};
  
//  std::vector<std::vector<int>> m{{1,2},{3,4}};

//  std::vector<std::vector<int>> m{{2,5},{8,4},{0,-1}};
  
  std::vector<std::vector<int>> m{{1},{2}};
  
//  [[2,3,4],[5,6,7],[8,9,10],[11,12,13],[14,15,16]]
  
//   std::vector<std::vector<int>> m{{2,3,4},{5,6,7},{8,9,10},{11,12,13},{14,15,16}};
  
  std::vector<int> so = spiralOrder(m);
  
  for (int i = 0; i < so.size(); i++) {
    printf("%d ",so[i]);
  }
  
}




