//
//  dyLibHello.c
//  dyLibTest
//
//  Created by 尹凡 on 12/4/18.
//  Copyright © 2018 fanyin. All rights reserved.
//

#include "dyLibHello.h"
char* getDylibName() {
  char* name = "hello world";
  printf("out put name = %s",name);
  return name;
}
