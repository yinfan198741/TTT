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
#include <sstream>
#include <stack>

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


//bool isMatch(string s, string p) {
//
////  s = "ab" p = ".*"
//
//  const char* p_p = p.c_str();
//  const char* p_p_end = p_p + p.length();
//
//  char p_s_last= ' ';
//  const char* p_s = s.c_str();
//  const char* p_s_end = p_s + s.length();
//
//  bool flag = true;
//
//  while (p_p != p_p_end && p_s != p_s_end ) {
//    if (*p_p == '.') {
////      ++p_p;
////      ++p_s;
////      continue;
//    }
//    else if (*p_p == '*') {
//      while (*p_s == p_s_last) {
//        ++p_s;
//      }
//      p_p++;
//      continue;
//    }
//    else if (*p_p != *p_s) {
//      flag = false;
//      break;
//    }
//
//    p_s_last = *p_s;
//
//    ++p_p;
//    ++p_s;
//  }
//
//  if (p_p != p_p_end || p_s != p_s_end) {
//    flag = false;
//  }
//
//  return flag;
//
//}



bool isMath(std::string s , std::string p )
{
  //    char *s_p = s.;
  //  size_t length = strlen(s);
  
  const char* s_p = s.c_str();
  const char* s_p_end = s_p + strlen(s_p);
  
  const char* p_p = p.c_str();
  const char* p_p_end = p_p + strlen(p_p);
  
  bool match = true;
  while (p_p < p_p_end && s_p < s_p_end) {
    
    char char_S = *s_p;
    char char_P = *p_p;
    char char_p_N = * (p_p + 1) ;
    
    if (char_p_N == '*') {
      
      if (char_P == '.') {
        
        s_p = s_p_end;
        p_p = p_p + 2;
        break;
        
      } else {
        while (char_S == char_P && s_p != s_p_end) {
          s_p++;
          char_S = *s_p;
        }
        p_p = p_p + 2;
      }
      
      
    }
    else {
      if (char_P == '.' || char_S == char_P) {
        ++s_p;
        ++p_p;
      }
      else
          {
        match = false;
        break;
          }
    }
    
//    if (char_P == '*'){
//     char pre = *(p_p - 1);
//      while (char_S == pre && s_p != s_p_end) {
//        s_p++;
//        char_S = *s_p;
//      }
//    }
//    else if ( char_P == '.' ) {
//      if ( *(p_p + 1) == '*') {
//        s_p = s_p_end;
//        p_p = p_p_end;
//        break;
//      }
//    }
//
//    else if (char_P != char_S) {
//      if (*(p_p + 1) == '*') {
//        p_p = p_p + 2;
//        continue;
//      }
//      else {
//        match = false;
//        break;
//      }
//    }
//
//     ++s_p;
//     ++p_p;
  }
  
  if (s_p < s_p_end) {
      return false;
  }
  
  if (p_p < p_p_end ) {
    while (p_p < p_p_end) {
      if (*p_p == '*') {
        ++p_p;
        continue;
      } else {
        match =false;
        break;
      }
    }
  }
  
  return match;
}


int findInDP(vector<int>& coins, int amount)
{
  
  std::vector<int> count;
  count.push_back(0);
  
  for (int i = 1; i < amount + 1; i++) {
    
    int i_count = 0;
    
    if (std::find(coins.begin(), coins.end(), i) != coins.end()) {
      i_count = 1;
      count.push_back(i_count);
      continue;
    }
    
    for (int j = 0 ; j < coins.size(); j++) {
      
      if (i > coins[j]) {
        
//        int coin_j = count[coins[j]];
        int coin_j = 1;
        int coin_l_j = count[i - coins[j]];
        
        if (coin_j == 0 || coin_l_j == 0) {
          continue;
        }
        
        int newC = coin_j + coin_l_j;
        
        if (newC == 0) {
          continue;
        }
        
        if (newC > 0 && i_count == 0 ) {
          i_count = newC;
        }
        else{
             i_count =  min(newC, i_count);
            }
        
      }
    }
    count.push_back(i_count);
  }
  return count[amount];
}


bool countZero(vector<int>& nums, int selectIdx,int rem)
{
  selectIdx++;
  if (rem == 0) {
    return true;
  }
  else if (rem < 0){
    return false;
  }
  if (selectIdx > nums.size() - 1) {
    return false;
  }
  
  return countZero(nums,selectIdx, rem - nums[selectIdx]) || countZero(nums,selectIdx, rem) ;
  
}


bool canPartition(vector<int>& nums) {
  
  vector<int> numsf;
  for (int i = 0; i < nums.size(); i++) {
    
    vector<int>::iterator iterator = std::find(numsf.begin(), numsf.end(), nums[i]);
    if (iterator != numsf.end() ) {
      numsf.erase(iterator);
    }
    else {
      numsf.push_back(nums[i]);
    }
  }
  
  int s = 0;
  for (int i = 0 ; i  < numsf.size(); i++) {
    s += numsf[i];
  }
  
  if (s % 2 != 0) {
    return false;
  }
  
  return countZero(numsf, -1, s/2);
}

bool dpCanPartition(vector<int>& nums) {
  int s = 0;
  for (int i = 0 ; i  < nums.size(); i++) {
    s += nums[i];
  }
  
  if (s % 2 != 0) {
    return false;
  }
  
  int half_s = s / 2;
  
//  std::vector<int> dps(12, 0);
  
//  std::vector<std::vector<int> > dp(nums.size(), std::vector<int>(half_s, 0));
  
  int **dp = (int **) malloc(sizeof(int) * nums.size());
  
  for (int i = 0 ; i < nums.size(); i++) {
    int *p = (int*) malloc(sizeof(int) * half_s);
    memset(p, i, sizeof(int) * half_s);
    *(dp + i) = p;
  }
  
//  dp.resize(nums, vector<int>(half_s));
  
//  dp.resize(nums);
//
//  for (int i = 0 ; i < dp.size(); i++) {
//    dp[i].resize(half_s);
//  }
  
//  for (int i = 0; i <= half_s; i++) {
//    std::vector<int> weight;
//    for (int j = 0 ; j <= half_s ; j++ ) {
//      weight.push_back(0);
//    }
//    dp.push_back(weight);
//  }
  
  for (int j = 1 ; j <= half_s; j++) {
    if ( j - nums[1] >= 0) {
      dp[1][j] = nums[1];
    }
  }
  
 for (int i = 2; i < nums.size() ; i++) {
   for (int j = 1; j <= half_s; j++) {
     if (j - nums[i] >= 0) {
        dp[i][j] = std::max(dp[i - 1][j - nums[i]] + nums[i],  dp[i - 1][j]);
      }
      else {
         dp[i][j] = dp[i - 1][j];
      }
    }
  }
  return false;
}

std::vector<string> ftype;
std::vector<int> stypes;
int ssum;

 void coin(int amount, vector<int>& coins, int index) {//设定index，保证递增存入
  if (amount == 0) {
    ssum++;
    
    std::cout<< std::endl;
        for (int i = 0 ; i < stypes.size(); i++) {
          std::cout << " " << stypes[i];
        }
     std::cout<< std::endl;
    
    return;
  }
   for (int i = index; i < coins.size(); i++) {
    if (amount >= coins[i]) {
      amount -= coins[i];
      
      stypes.push_back(coins[i]);
      
      //                array.add(coins[i]);
      coin(amount, coins, i);
      
      stypes.pop_back();
      
      //                array.remove(array.size() - 1);
      amount += coins[i];
    }
  }
}



void chargeToZero(int amount, int coin,int idx, vector<int>& coins, std::vector<int>& types)
{
  
  types.push_back(coin);
  
  amount = amount - coin;
  if (amount == 0) {
    
//    std::cout<< std::endl;
//    for (int i = 1 ; i < types.size(); i++) {
//      std::cout << " " << types[i];
//    }
    
    std::vector<int> all;
    all.assign(types.begin(), types.end());
    sort(all.begin(), all.end());
    
    
    std::stringstream ss;
    copy(all.begin(), all.end(), ostream_iterator<int>(ss, " "));
    string s = ss.str();
    
    
    
    if (std::find(ftype.begin(), ftype.end(), s) == ftype.end()) {
       ftype.push_back(s);
    }
   
    
    std::cout<< std::endl;
    
//    std::cout << "s = " << s << std::endl;
  }
  if (amount < 0) {
    types.pop_back();
    return;
  }
  
  for (int i = idx ; i < coins.size(); i++) {
    chargeToZero(amount ,coins[i], ++idx, coins, types);
  }
  types.pop_back();
}

int mchange(int amount, vector<int>& coins, std::vector<int>& types) {
  ftype.clear();
  chargeToZero( amount, 0 ,0,coins, types);
  return (int)ftype.size();
}


string removeKdigits(string num, int k) {
  
  int length =  num.length();
  const char * p_number = num.c_str();
  const char* p_end = p_number + length;
  int save = length - k;
  
  if (save == 0) {
    return "0";
  }
  
  int total = save;
  
  std::stack<char> values;
  
  while (p_number < p_end) {
    char v = (char)*p_number;
    
    if (total - values.size() == p_end - p_number) {
      values.push(v);
      p_number++;
      continue;
    }
    

    
    while (values.size()> 0 && values.top() > v && (p_end - p_number + values.size() > total )) {
      values.pop();
    }
    
    if (values.size() < total) {
      values.push(v);
    }
    
    p_number++;
  }
  

  
  std::string res;
  
  while (values.size() > 0) {
    std::string::iterator it = res.begin();
    char v = values.top();
    res+=v;
    values.pop();
  }

  res.reserve();
  
  return res.length() != 0 ? res : "0";
}


string removeKdigits3(string num, int k) {
  vector<int> stk(num.size());//单调递增栈
  int top = -1;//栈顶
  if(num.size()==k) return "0";
  string ans;
  for(int i = 0; i < num.size(); i++){
    while(top!=-1&&stk[top]>num[i]&&k) top--,k--;//高位可换成更小的时，则去替换高位值，最多k次
    stk[++top] = num[i];
  }
  while(k--) top--;//若还没删够，则删除末尾的k个数
  int i = 0;
  while(stk[i]=='0'&&i < top) i++;//去除前导零
  while(i <= top) ans.push_back(stk[i++]);
  return ans;
}

string removeKdigits4(string num, int k) {
  stack<char> s;
  for (int i = 0; i < num.size(); i++)
      {
    while (!s.empty() && s.top() > num[i] && k)
        {
      s.pop();
      k--;
        }
    if (s.empty() && num[i] == '0')
      continue;//跳过前置0
    s.push(num[i]);
      }
  string result;
  while (!s.empty())
      {
    if (k > 0)//当还要再移除数字的时候：从此时单调递增栈的top部删去数字
      k--;
    else if (k == 0)//当不用再移除数字的时候：把字符串取出来到result
      result += s.top();
    
    s.pop();
      }
  reverse(result.begin(), result.end());//stl中的reverse函数
  return result == "" ? "0" : result;
}



void deepTree()
{
 
  string num;
  int k;
  num = "132104456789";
  k = 3;
  
//  num = "1432219";
//  k = 3;
  
//  num = "99641436378815361153471302158193420182863684789411484994976484827114595334610042544056442370530816060833617030976813134098793056155103202008549344446519354408307307071055065112738442020228471569394796174150323080161225901964338837341524253243218509500254619223683091799365677720582389568156585225666197123093377871100002481402486219837255411382162499321193416524972275273471969155848742457476556433737281147710021781210134765321761285612276511917324552585569882156635094670362653567596144728653795007023230933817566104488637696450166087905100823699425798763598444326069357052842379918535855296915760054459317433521878778171811081076593166663090948029793113626852462712388116483774713426183911481230884393594249331828165503798269634244430773693033882708000249632850148799859322024693146577635543114657662418998860517525989192973250701631765598465053097616804817344343895016724561947860836117504915797011185132674255278236597746042138768473723059825948301565719437610732907662545499042953499866813741157301003371005200992314265077531029437948931255617153417148822355928318598517533241719641002712204874161001604269216566928220767474713135516717997491363360204764154264989004671363541097433484822118483642107547658581450616821769964767032521138851570822729134762460014265433227201724724004338494552397280090568164786109721571436206198382814849033856987338787473335772666933218810822482848994610491705665155516384799459418594559136827941106387689501641851101743298582575466303864906673788496628288920867422193950180810131396612913851112593807649152972068279299934113463669714575613645929365652921808836725682390026075559320995704880149764583379697505303474550029059828116836469203370428449330442281563135568935742669243344218603994417955703485059862132359688776290378210392955310785874528205203788559715493852405991380290274268143557970398441851157977520689440430265144029789788511042795879174567381358510694749512938934687979305099149575464220629804942550564164786808856897809863824121659548034395539735407069279457678613909222371848892294754933299091164656871086269084324529512544747434123547189729993758337622038098699448815701644934651292719067683227727438808955969543542319197883567369733867364250353136697865107182282929655918362211832327827571354787535611501731943856155003853732339819594939524719169561110698571676562329360803282215467534058504728127731515598941143637827010955579092451405821352126706550438315176049692316210490899702613078702535716735901806171522853021035597316703390478571485677998207922773938829371460838611214446417528913575284776737837046439695408523434414916342979688820197836458637694991540998291690345194205452439239827382953039810367712244590155940394387554911786652478111954297185544106384174592451680875083737874735810068767866214924634885513828808880161930987276602570872860752119813042414550396358433893592777541756673206882876746731707766966268096104320061937913505893028833592137540396064375155513979764728180927083060481127522118240026140625647313783901073938419240249929000962722034273952683635919540169732220854978101308126446671885186032295490845060116567165945677975672981321362161949418405852378788584602802612398876874288293756055559457538271197205867506313677160755990736347314715042607243878693780144368083800080967842966193539823770427967091132770230485036143223363387876244958899577538069175123004651952588711287008791159682042581943812962882375293348462523257081140457567348612069746943329842264291823570671268374580651696311114624358304235261945894627668267192756606441264485628097480920062857007640396910214970556623416565940789636657349735150043836194242061994234044262604284350296258397208287158735477739515615890093167555389262170576609082365199242352356197706754361085079177223144662701424848070607319078068303190442737202186364818021792860690571733432439513976759807778513151206801184300729685910765785586373831699595178352610150383283823456881293647763022411686252640648120690251120902631370825525354213297549430441989419362406888242180413640397005462289002837178086683143441254722528075315187910994986929463063282350677644105312484770818851268755183086729904524488901102287310169865855725358976453628171038414004415469635124255044890245890050115901243603489384920067923087045070616429510114587493955384903357111302068595548921504222171096098548413208088831560744996899783844118318185694142620796984004522106434428513215881883542758888862576036415421097762413907290417004936441609238204617100586876487061497586106631983740139555573272626681186969272113315348553052708453716313010811194726904231406455432865684477036960953564406390115786323388585604716504384778912812410729908949581143722120318954849846535676912868526526501078193502393524062471534154104899815734648650035608611113327222040864146091286020205304970098510045582130989981665393076480660907742469107193219475618455618115516353495211289597815564506193368287178714208989206470099207227171770619580227427772058576958549342547850566371060314330889132466260972915500785842700966615103949831075688522846389635990078358138687466663099265099431775674237640711466272609872329090894406587154198409486434056948991642623725868520261081714501891452704954562834244485695899485150794033902595303371632597184940525684558272222395813587950566598836575728711404672894869851301199508345442816914540274231773573695049117433232750564343477296571911336451338765122801905492189124021699698020217831160061375249740348841211772476455089061870953510480256335713228323198782026742817220321247980121667780800877801219532811542139900480803615083739957513418528009253849655053312995534574307148952727627870318872325094411860749809155407484065987101730385346571248798467212335910821152286411077915790397497756477613051365987943518909759211252763081626026136209474490841118337332773116122063152414208776801671614382203998310801791046109980464795153775904284579208046765170299376571712696359391195309011046580945099118345329164807866461624513459858969478261348365746242842254100449074846018162381649508771205692387943049083877156128753239386498305599949138477358461424273464036997642435352074743094695564535693378173888280633866732018710701060752702258884562187458492514181027419045608607139753797741693225900923436163273291784047946102859573341135995351940672974945745062320931107916232460722010886651827074516009065280667168017782964663521168472263155891094369134584611694802620433621767214124173962636180142978128638945692419270222518432363382128100260544917455244318162619360808797214154001396840051520865249909119773623276044783996235484958441702533661095335337458603732924068113476544273220040621287278168707393471504842692312354782265568742305367773635557008065688109790648713350572351799924638273829816187626279342407486758617884199669669286080608957640162096427744397522103026413782698158732581790000716751490076906346484023835702438474105176931779065689980130347837155056303467742499515965713045957954225592059807462917282749105358673064716135765849677591608061323905019687616579401117839719269327243007586938365568212311638431283680946079388989080798521721770825311237382299640977231722390040018733060008726711369177955792504805871660952275133036361448257222162174106121886956846208577175900217031085260775753651365765038925717954695019720235653672968689019573262654460436772900765775615489257834882352941349073672575670561593061387879337673233294306479935031268311515186416299622966578517978675818927585118344348361158710756313053131716293124192982037977789379782122120656399498488608931743952536041546453299501041577456229618221253519224906611827751220393777623642577532653929191439603183004880021982807536023221789599010502125687724004685177438516674638976736887749480118357141229355178588718777866510629202733751110559334924038607709059709853979249569510212755627954315025008066453716096825677236680969921750877126730256949811077056975031686370565845816981036167892330455103497165407984322792515265566483796338273488042877728447328933645773410093062365682687268013318931065552717013674172822704288279197461978805944285413220284999303849740540429893025407810120053701999064303195562726870079068213843151094378846458471168159763363401468459072474435300433314015701363633705309153196187013664717617975618648227816754951474354742056233896619815305871556180590934191775446450232435064334173434855333465262160341517250209548644211312373841441024747539900101488865742679168673356769004244781832745045012713439497231232255815861738982590755401780194874615548229070120796893835181030047378827641086164272219294123942746140207443292075817414598536256892540490923602419336928186124051416665048479530882042184097629985897052425322145715174649893481917612568426372077919256931921063600255204010662044398922537796993713110889134889921360833579323314386803074533058134342770923839546994120322442157750203621967931319597649960815556196358566683782572730174920215034531104191490057838260392829741446722127017532444082857280503217574522928285094747407153894570747792487061998260753833304433675066923630595212677695003060727653119915126939127827754432456052655283764591328484359469704894122366077507922825301623961196207923544095047285011474898262448957681893278273601046641810135121516552187096005252171171905022763076761687166299014789581539855448453229411352775826042558462563147630238335355859149814380543807473386539264830261256996173935860136236427622918234260408201158550118527706241993700526213016072648406003487895118011337828945314863348154387066988573131543747121745028364818130265528614742576976975564213718421245904443000581698214695522541683926528961160986876871840844632069685227319014872180179370554032205521013345746425253133686231659075343389374580200717637698542920298315739628019867736462368334051114029380922339886663078026309916370486909128253195100898377068612057592121356555290537815049586626181680384845905180029133497372417653664436161971980137048236053329456957495141918670077299206755740534997886723627476115663811233372206043170460623060506091246306386543951687123557178508806912199010111871";
//  k = 1000;
  
  for (int k = 0; k = num.length(); k++) {
    string v = removeKdigits( num,  k);
    std::cout<< "v = " << v << std::endl;
    
    string v1 = removeKdigits3( num,  k);
    std::cout<< "v1 = " << v << std::endl;
    
//    string v2 = removeKdigits4( num,  k);
//    std::cout<< "v2 = " << v << std::endl;
    
    bool res = v == v1;
    
//    bool res2 = v2 == v1;
    std::cout<< "res = " << res << std::endl;
    
    
  }
  
  
//  std::string s = "ab";
//  std::string p = ".*c";
  
//  std::string s = "ab";
//  std::string p = ".*";
  
//  std::string s = "aab";
//  std::string p = "c*a*b";
  
  
//  std::string s = "aaa";
//  std::string p = "a*a";
  
  
// bool out = isMath(s, p);
//  std::cout << "out = " << out << std::endl;
//    createTree();
//  quicksort();
//  generateParenthesis(3);
//  std::vector<string> abc = {"a","b","c"};
//  std::vector<string> values;
//  choose(abc, 2, 0, values);
  
//  std::vector<int> coins = {1,2,5};
//  int amount = 11;
//  int count = findInDP(coins, amount);
//  std::cout<< "count" << count << std::endl;
  
//  [1, 5, 11, 5]
  
//  std::vector<int> nums = { 0, 1,  5,  11,  5 };
//  bool cp = dpCanPartition(nums);
//  std::cout << "cp" << cp << std::endl;
 
  std::vector<int> coins = { 1, 2, 5};
  int amount = 3;
  coin(amount, coins, 0);
  std::cout << "sum = " << ssum << std::endl;
  std::vector<int> types;
//  int amount = 500;
////  types.push_back(0);
  mchange(amount, coins, types);
//  std::cout << "ftype.size() = " <<ftype.size() << std::endl;
////  return;
//  for (int i = 0; i < ftype.size(); i++) {
//    std::cout << "ftype = " << ftype[i] << std::endl;
//  }
  
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




