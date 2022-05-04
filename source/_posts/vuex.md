---
title: vuex从入门到实战
comments: false
top: false
date: 2021-12-12 14:26:45
tags: [前端,vuex]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211213152705.png
---
vuex是一款针对vue.js中复杂的通信场景下衍生的技术插件，他可以有效的帮助我们轻松完成大范围内的组件通信，还不快进来学习😋？

<!-- more -->

### vuex简介

什么是 `vuex`？这是每一个新手小白都很好奇的问题，我们要知道任何一种新技术的产生肯定都是为了解决某种复杂的问题，而vuex就是为了解决大范围内vue组件中通信问题的。这里我们从组件的通信方式入手来逐步了解vuex产生的缘由以及他的作用。

#### 传统组件通信方式

我们回忆一下我们之前学习的组件通信的方式，常用的是父子组件之间的通信，此时父组件通过 `:bind`绑定一个值给子组件，然后子组件通过 `props`接收这个值，此时这个从父组件拿到的值是响应式的，但是仅仅是单向更新，即子组件只能接受到父组件更新的这个值，而子组件是不能修改父组件中的值的，为了能实现子组件向父组件更新这个值，子组件需要通过 `$emit`触发父组件提前为子组件分配并绑定方法实现更新，如下图所示是一个简单的父子组件通信demo:

{% tabs 父子组件传值 %}

<!-- tab Tab/index.vue -->

```vue
<template>
  <div>
    <a
      href="javascript:;"
      @click="changeTab(1)"
      :class="[{ current: curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="changeTab(2)"
      :class="[{ current: curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="changeTab(3)"
      :class="[{ current: curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="changeTab(4)"
      :class="[{ current: curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
export default {
  name: "Tab",
  //接收父组件传递进来的curIdx的值
  props: {
    curIdx: Number,
  },
  //点击触发父组件更新curIdx值
  methods: {
    changeTab(i) {
      this.$emit("changeTab", i);
    },
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

<!-- endtab -->

<!-- tab App.vue -->

```vue
<template>
  <div id="app">
    <!-- 传递给子组件Tab的值以及为他绑定一个方法用来通知父组件更新值 -->
    <Tab :curIdx="curIdx" @changeTab="changeTab" />
    <!-- <Page :curIdx="curIdx"></Page> -->
    <!-- <img src="./assets/logo.png"> -->
    <!-- <router-view/> -->
  </div>
</template>

<script>
import Tab from "@/components/Tab";
// import Page from "@/components/Page";
export default {
  name: "App",
  components: {
    Tab,
    // Page,
  },
  data() {
    return {
      curIdx: 0,
    };
  },
  methods: {
    changeTab(i) {
      this.curIdx = i;
    },
  },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211212153218.png)

此时我们会得到一个如上图简单的父子组件通信的小demo，我们可以点击不同的链接按钮，然后链接按钮被点击后会变成黑色且无下划线，这是通过父组件操控子组件中的curIdx动态的为子组件中的四个a标签绑定 `current`类实现的，同时我们在点击子组件Tab中不同的a标签后会触发 `changeTab`方法来更新父组件中的curIdx值，进一步子组件在通过prop更新自己的curIdx实现的动态绑定current类到对应被点击的a标签的。如果你对这个简单的小demo还无法理解的话请先查看此篇教程：

{% link 父子组件通信, https://www.cnblogs.com/HouJiao/p/12421851.html%}

接下来我们再尝试加入一个兄弟组件通信的场景，假设此时我们不仅仅需要通过curIdx来实时更新渲染Tab子组件中的被选中a标签，同时我们还希望可以通过curIdx实时刷新显示Tab栏下方的 `Content`页面中的内容，那么我们需要再新建一个组件Page同时在App.vue中引入并使用这个子组件如下

{% tabs 兄弟组件传值 %}

<!-- tab Page/index.vue -->

```vue
<template>
  <div>{{ content[curIdx - 1] }}</div>
</template>


<script>
export default {
  name: "Page",
  props: {
    curIdx: Number,
  },
  data() {
    return {
        // 根据prop接收的curIdx动态显示内容
      content: ["页面1", "页面2", "页面3", "页面4"],
    };
  },
};
</script>


<style scoped>
</style>
```

<!-- endtab -->

<!-- tab App.vue -->

```vue
<template>
  <div id="app">
    <!-- 传递给子组件Tab的值以及为他绑定一个方法用来通知父组件更新值 -->
    <Tab :curIdx="curIdx" @changeTab="changeTab" />
    <!-- Page组件也接受这个curIdx值 -->
    <Page :curIdx="curIdx"></Page>
    <!-- <img src="./assets/logo.png"> -->
    <!-- <router-view/> -->
  </div>
</template>

<script>
import Tab from "@/components/Tab";
import Page from "@/components/Page";
export default {
  name: "App",
  components: {
    Tab,
    Page,
  },
  data() {
    return {
      curIdx: 0,
    };
  },
  methods: {
    changeTab(i) {
      this.curIdx = i;
    },
  },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211212153828.png)

此时我们就得到了一个最经典的vue兄弟组件传值的demo,即Tab栏中的a标签被点击后会通过 `$emit`触发changeTab函数来更新父组件中的curIdx值，然后Page组件接收到这个新更新的curIdx值来动态显示内容，这样就实现了点击不同的标签显示对应不同的内容。

##### 思考：上面的例子中父组件的作用？

我们考虑一下上面的实例代码即最传统的兄弟组件的通信方式有没有什么弊端。我们发现父组件完全就是承担了连个兄弟组件中的桥梁作用，父组件自己并不需要使用curIdx值和changeTab方法，但是为了能够让Tab和Page两个兄弟组件通信，又不得不加入这些内容，显然这种实现逻辑很奇怪，为什么不能直接让两个兄弟组件直接通信呢？进一步考虑，如果是两个有共同祖先的兄弟组件通信可就不仅仅是需要父组件承担桥梁身份这么简单了，可能会涉及到更多的祖先组件加入许多没用的东西，即如下图所示的场景：

![](https://langwenchong.gitee.io/figure-bed/20211212154714.png)

很显然这种方式的通信一旦面对较为庞大且复杂的应用场景效率会极低，因此我们需要一个第三方插件能够专业的承担这个桥梁的作用，同时它不仅仅能够实现简单的拥有共同父祖先子组件之间的通信，甚至可以实现任意多个组件之间的通信，此时我们就会用到 `vuex`了！它提供了一个store仓库用来维护所有组件需要通信时用到的数据，并提供对应的方法来为通信的组件实时更新值，这就是vuex的由来，如下图就是它工作的原理：

![](https://langwenchong.gitee.io/figure-bed/20211212155115.png)

我们可以很容易的看出使用 `vuex`的优势：

1. 能够在vuex中集中管理共享的数据，易于开发和后期维护
2. 能够高效地实现组件之间的数据共享，提高开发效率
3. 存储在vuex中的数据都是响应式的，能够实时保持数据与页面的同步

既然vuex的好处那么多，接下来我们就来学习使用vuex吧😀！

#### vuex工作流程

首先我们来学习一下vuex中的几个基本概念，如下图是vuex的一个工作流程：

![](https://langwenchong.gitee.io/figure-bed/20211212155701.png)

- VueComponents：需要进行通信的vue组件，不在vuexAPI范围之内
- State：一个对象，类似于data对象用来存储维护通信需要使用到的所有数据
- Mutations：也是一个对象，类似于methods存储了更新State数据的方法，**只有Mutations中的方法可以更新State中的数据**
- Actions：如果需要异步调用Mutations方法，那么所有的异步操作都要在Actions中完成
- Devtools：热加载插件，不用管
- Getters：除了上图中这些概念，还有一个Getters，他是类似于computed可以根据State中的值进一步封装操作得到一个新数据并返还
- Modules：如果是针对于企业级项目，还有一个Modules属性用来分模块引入并应用vuex，后面我们也会学习到。

{% note info,

要注意除了 `State`剩下的都是复数形式这是因为它可以存储多个方法或者数据，因此是Mutations、Actions、Getters、Modules。

%}

### Vuex应用

#### vuex安装

接下来我们就尝试将上面的例子使用 `vuex`来实现。首先我们需要安装vuex,只需要在终端输入如下命令即可：

```bash
npm install vuex --save
```

安装完成以后为了方便管理，我们在根目录下创建一个新的文件夹为store并在其下新建一个入口文件index.js如下图：

![](https://langwenchong.gitee.io/figure-bed/20211212162744.png)

并在index.js中加入如下内容用来引入并挂在vuex：

```js
import Vue from "vue";
import Vuex from 'vuex'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
  },
  mutations: {
    // 用来定义修改state中数据的方法
  },
  actions: {
    // 异步操作
  },
  modules: {
    // 分模块引入
  }
})

```

现在我们就来使用vuex更改刚刚的代码。

#### state使用

由于我们之前使用的是curIdx来进行的兄弟组件之间的通信，因此很显然这个curIdx就是一个需要vuex维护的值，我们将其定义到vuex的state中而不再在父组件app.vue中定义。同时在Tab中和Page中我们也无需在通过prop来接收这个curIdx值了，而是改用vuex的state来获取这个值，如下图是两种不同的写法。

首先无论是哪种写法我们都需要在store/index.js中声明定义这个curIdx如下：

```js
import Vue from "vue";
import Vuex from 'vuex'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
    curIdx: 0,
  },
  mutations: {
    // 用来定义修改state中数据的方法
  },
  actions: {
    // 异步操作
  },
  modules: {
    // 分模块引入
  }
})
```

然后我们取消父组件中所有的有关传值数据，如下图父组件不再需要定义curIdx了并且引用子组件时也无需在为他们传递一个curIdx了即从父组件的角度来看他根本就不知到curIdx的存在：

```vue
<template>
  <div id="app">
    <!-- 传递给子组件Tab的值以及为他绑定一个方法用来通知父组件更新值 -->
    <!-- <Tab :curIdx="curIdx" @changeTab="changeTab" /> -->
    <!-- 不在需要传递curIdx了 -->
     <Tab @changeTab="changeTab" />
    <!-- Page组件也接受这个curIdx值 -->
    <!-- <Page :curIdx="curIdx"></Page> -->
    <!-- 不在需要传递curIdx了 -->
    <Page ></Page>
    <!-- <img src="./assets/logo.png"> -->
    <!-- <router-view/> -->
  </div>
</template>

<script>
import Tab from "@/components/Tab";
import Page from "@/components/Page";
export default {
  name: "App",
  components: {
    Tab,
    Page,
  },
  // 无需在定义curIdx了
  // data() {
  //   return {
  //     curIdx: 0,
  //   };
  // },
  methods: {
    changeTab(i) {
      this.curIdx = i;
    },
  },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

接下来我们需要修改组件Tab和Page的代码去获取vuex中的curIdx,这里涉及到两种实现方法：

##### 方法一

首先我们为了能够保证全局组件中this中含有 `$store`这个对象，我们需要全局挂载一下store，只需要在main.js中加入如下代码即可：

```js
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

// 首先从store文件夹下引入store(默认回去index.js中获取)
// 因此这里路径写道文件夹即可
import store from '../store'

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>',
  // 在这里挂在store对象
  store
})

```

这里以Tab作为示例，我们可以直接通过 `this.$store.state.curIdx`即可获取到这个值，因此Tab修改后的代码如下

```vue
<template>
  <div>
    <!-- 不在使用prop而是使用this.$store.state.curIdx获取 -->
    <!-- 由于vue中template无需使用this -->
    <!-- 因此直接使用$store.state.curIdx即可 -->
    <a
      href="javascript:;"
      @click="changeTab(1)"
      :class="[{ current: $store.state.curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="changeTab(2)"
      :class="[{ current: $store.state.curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="changeTab(3)"
      :class="[{ current: $store.state.curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="changeTab(4)"
      :class="[{ current: $store.state.curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
export default {
  name: "Tab",
  //接收父组件传递进来的curIdx的值
  // props: {
  //   curIdx: Number,
  // },
  //点击触发父组件更新curIdx值
  methods: {
    changeTab(i) {
      this.$emit("changeTab", i);
    },
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

这样我们就获取到了vuex.store对象中的state对象内存储的curIdx值了，并且这个值也是动态响应变化的，可以实时更新，但是我们会发现这样写有一个小瑕疵就是每一次书写都要加上 `this.$store.state`太麻烦了，因此出现了方法二。

##### 方法二

这里我们以Page为例，方法二使用了 `mapState`辅助函数，这样我们就可以得到一个map对象，输入需要的变量名即可获取到这个state中存储的值，我们将其映射到我们自己的组件上，由于这个值是动态变化的，因此我们需要将他放到 `coputed`下如下

```vue
<template>
  <div>{{ content[curIdx - 1] }}</div>
</template>


<script>
import {mapState} from 'vuex'
export default {
  name: "Page",
  // 不在需要使用prop接受值
  // props: {
  //   curIdx: Number,
  // },
  computed:{
    //要注意其本身是一个计算函数，因此外部有一个括号包裹
    ...mapState({
      // 箭头函数可使代码更简练
      curIdx:state=>state.curIdx,
      // 下面这种书写也可以
      // curIdx:'curIdx',

    }),
    // 当映射的计算属性的名称与 state 的子节点名称相同时，我们也可以给 mapState 传一个字符串数组
    // ...mapState(['curIdx'])
  },
  data() {
    return {
        // 根据prop接收的curIdx动态显示内容
      content: ["页面1", "页面2", "页面3", "页面4"],
    };
  },
};
</script>


<style scoped>
</style>
```

{% note info,

注意如果我们需要在获取到这个state中的值以后进一步和data中的值进行加工，那么此时需要使用到this来执行当前的vue实例，为了能够正确只想，此时就不能在使用箭头函数了比如：

```js
 // 为了能够使用 `this` 获取局部状态，必须使用常规函数
    countPlusLocalState (state) {
      return state.count + this.localCount
    }
  })
```

%}

#### mutations使用

此时我们只是完成了子组件使用vuex中的curIdx,但是我们还需要更新这个curIdx，因此此时我们需要定义一个方法来更新它，此时就会用到mutations，我们在mutations中定义一个新的方法setCurIdx，要注意我们mutations中定义的方法默认的第一个参数永远是state指向state这样我们才能修改state中的值，因此加入setCurIdx后store/index.js代码如下

```js
import Vue from "vue";
import Vuex from 'vuex'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
    curIdx: 1,
  },
  mutations: {
    // 用来定义修改state中数据的方法
    // 用来修改state中的curIdx
    // 默认第一个参数永远是state
    setCurIdx(state, idx) {
      state.curIdx = idx;
    }
  },
  actions: {
    // 异步操作
  },
  modules: {
    // 分模块引入
  }
})

```

同样的子组件调用mutations中函数的方式也有两种如下所示

##### 方法一

我们可以在methods中定义一个新方法，然后通过如下指令触发调用mutations中的方法

```js
//commit的第一个参数是要触发调用的函数名，第二个是传递的参数
this.$store.commit('setCurIdx',idx)
```

此时Tab的代码如下：

```vue
<template>
  <div>
    <!-- 不在使用prop而是使用this.$store.state.curIdx获取 -->
    <!-- 由于vue中template无需使用this -->
    <!-- 因此直接使用$store.state.curIdx即可 -->
    <!-- 由于setCurIdx已经映射为了自己的方法因此直接调用即可 -->
    <a
      href="javascript:;"
      @click="setCurIdx(1)"
      :class="[{ current: $store.state.curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(2)"
      :class="[{ current: $store.state.curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(3)"
      :class="[{ current: $store.state.curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(4)"
      :class="[{ current: $store.state.curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
import { mapMutations } from "vuex";
export default {
  name: "Tab",
  //接收父组件传递进来的curIdx的值
  // props: {
  //   curIdx: Number,
  // },
  //点击触发父组件更新curIdx值
  methods: {

    //  当然也可以不映射，而是直接调用this.$store.mutations.setCurIdx()修改
    setCurIdx(idx) {
      this.$store.commit("setCurIdx", idx);
    },

    //甚至可以
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

**思考：能否不调用mutations中的方法而是直接操作curIdx？**

肯定会有同学想到了一个简单的方法即下面代码可以直接修改state中的数据

```js
this.$store.state.curIdx=idx;
```

一定要注意这种方法是万万不可以的！因为虽然此时可以修改这个值，但是当应用逐渐庞大以后这种不通过mutations修改state中值的操作会难以跟踪，不方便后期bug的查找，因此一定不要这样写！

##### 方法二

另一种方法就是还是通过辅助函数mapMutations来获取到这个方法并调用如下

```vue
<template>
  <div>
    <!-- 不在使用prop而是使用this.$store.state.curIdx获取 -->
    <!-- 由于vue中template无需使用this -->
    <!-- 因此直接使用$store.state.curIdx即可 -->
    <!-- 由于setCurIdx已经映射为了自己的方法因此直接调用即可 -->
    <a
      href="javascript:;"
      @click="setCurIdx(1)"
      :class="[{ current: $store.state.curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(2)"
      :class="[{ current: $store.state.curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(3)"
      :class="[{ current: $store.state.curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="setCurIdx(4)"
      :class="[{ current: $store.state.curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
import { mapMutations } from "vuex";
export default {
  name: "Tab",
  //接收父组件传递进来的curIdx的值
  // props: {
  //   curIdx: Number,
  // },
  //点击触发父组件更新curIdx值
  methods: {
    // 使用映射的方法获取setCurIdx方法
    ...mapMutations(['setCurIdx']),
    // changeTab(i) {
    //   this.$emit("changeTab", i);
    // },

    //我们甚至可以进一步封装将setCurIdx改个名字
    // ...mapMutations(['setCurIdx']),
    // changeTab(idx){
    //   this.setCurIdx(idx);
    // }
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

**思考：如果需要传递多个参数怎么办？**

此时并不是在commit（）方法后面追加多个参数，而是将所有的数据打包封装成一个对象传递，这个对象又称为 `payload`，学名 `提交载荷`。如下

{% tabs 多参数传递 %}

<!-- tab store/index.js -->

```js
// ...
mutations: {
  increment (state, payload) {
    state.count += payload.amount1;
     state.count += payload.amount2;
  }
}

```

<!-- endtab -->

<!-- tab vue组件调用 -->

```js
store.commit('increment', {
  amount1: 10,
  amount2:20
})
```

<!-- endtab -->

{% endtabs %}

{% note info,

当然，当只有一个参数时直接使用即可。

%}

现在我们再来看一下父组件App.vue的代码，会发现他已经没有任何有关兄弟组件通信的代码了，即此时父组件无需在承担这个桥梁者的身份了，更加简洁优雅。第三方桥梁者身份由vuex来提供了。

```vue
<template>
  <div id="app">
    <!-- 传递给子组件Tab的值以及为他绑定一个方法用来通知父组件更新值 -->
    <!-- <Tab :curIdx="curIdx" @changeTab="changeTab" /> -->
    <!-- 不在需要传递curIdx了 -->
     <!-- <Tab @changeTab="changeTab" /> -->
     <!-- 也无需在为子组件提供方法了 -->
     <Tab />
    <!-- Page组件也接受这个curIdx值 -->
    <!-- <Page :curIdx="curIdx"></Page> -->
    <!-- 不在需要传递curIdx了 -->
    <Page ></Page>
    <!-- <img src="./assets/logo.png"> -->
    <!-- <router-view/> -->
  </div>
</template>

<script>
import Tab from "@/components/Tab";
import Page from "@/components/Page";
export default {
  name: "App",
  components: {
    Tab,
    Page,
  },
  // 无需在定义curIdx了
  // data() {
  //   return {
  //     curIdx: 0,
  //   };
  // },
  // 无需在定义这个方法了
  // methods: {
  //   changeTab(i) {
  //     this.curIdx = i;
  //   },
  // },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

#### getters使用

实际上getters很好理解，他就是把对数据的多重操作不再在组件中使用computed进行封装返还，而是可以在vuex中使用getters即可得到。还是之前的那个例子，现在我希望下方的页面可以实时显示一句话即 `当前显示的时第curIdx个标签对应的页面的内容`。这句话很明显需要随时跟着curIdx变动更新，我们第一想法就是获取到这个curIdx然后再在page组件中新声明一个计算元素来生成这句话，但是我们其实可以完全在getters就是先这个功能，这样类似需求的组件就无需再重复写这种计算方法了，而是都可以通过getters统一拿到这个随时变化的字符串，首先我们需要在store/index.js中声明一个getters方法

```js
import Vue from "vue";
import Vuex from 'vuex'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
    curIdx: 1,
  },
  getters:{
    //   形参和mutations类似，第一个永远是state,第二个是payload
    content(state){
        return `当前显示的时第${state.curIdx}个标签对应的页面的内容`
    }
  },
  mutations: {
    // 用来定义修改state中数据的方法
    // 用来修改state中的curIdx
    // 默认第一个参数永远是state
    setCurIdx(state, idx) {
      state.curIdx = idx;
    }
  },
  actions: {
    // 异步操作
  },
  modules: {
    // 分模块引入
  }
})

```

类似的，gettes中的方法返还的值和state中的值一样也有两种接受方法

##### 方法一

第一种就是直接在html中双括号中引入即可，由于vuex中的数据也是动态响应的，因此从getters中获取的数据也是动态的，当源数据发生了变化，他也会跟着变化。如下

```vue
<template>
  <!-- <div>{{ content[curIdx - 1] }}</div> -->
  <div>{{ this.$store.getters.content }}</div>
</template>


<script>
import { mapState } from "vuex";
export default {
  name: "Page",
  // 不在需要使用prop接受值
  // props: {
  //   curIdx: Number,
  // },
  computed: {
    //要注意其本身是一个计算函数，因此外部有一个括号包裹
    ...mapState({
      // 箭头函数可使代码更简练
      curIdx: (state) => state.curIdx,
      // 下面这种书写也可以
      // curIdx:'curIdx',
    }),
    // 当映射的计算属性的名称与 state 的子节点名称相同时，我们也可以给 mapState 传一个字符串数组
    // ...mapState(['curIdx'])
  },
  data() {
    return {
      // 根据prop接收的curIdx动态显示内容
      content: ["页面1", "页面2", "页面3", "页面4"],
    };
  },
};
</script>


<style scoped>
</style>
```

最终得到的效果图就是下方的内容会实时根据上方被选中的a标签发生变化

![](https://langwenchong.gitee.io/figure-bed/20211212195342.png)

##### 方法二

当然我们也可以借助 `mapGetters`辅助函数，同样的由于同时动态变化的，我们需要将其映射到computed属性下，此时组件就可以任意使用这个值了。如下所示

```vue
<template>
  <!-- <div>{{ content[curIdx - 1] }}</div> -->
  <!-- <div>{{ this.$store.getters.content }}</div> -->
  <div>{{msg}}</div>
</template>


<script>
import { mapState } from "vuex";
import {mapGetters} from 'vuex'
export default {
  name: "Page",
  // 不在需要使用prop接受值
  // props: {
  //   curIdx: Number,
  // },
  computed: {
    //要注意其本身是一个计算函数，因此外部有一个括号包裹
    ...mapState({
      // 箭头函数可使代码更简练
      curIdx: (state) => state.curIdx,
      // 下面这种书写也可以
      // curIdx:'curIdx',
    }),
    // 当映射的计算属性的名称与 state 的子节点名称相同时，我们也可以给 mapState 传一个字符串数组
    // ...mapState(['curIdx'])
    // 由于下方已经存在了一个content数组，为了不重名我们需要修改一下这个getters返还的值名称为msg
    ...mapGetters({
      msg:'content'
    })
  },
  data() {
    return {
      // 根据prop接收的curIdx动态显示内容
      content: ["页面1", "页面2", "页面3", "页面4"],
    };
  },
};
</script>


<style scoped>
</style>
```

#### actions使用

首先我们要知道actions的作用时用来处理异步操作的，但是什么是异步操作呢？所谓异步就是当执行这个代码以后程序并不会等待其成功结束并返还结果以后再继续向下走，而是这个异步操作自己去一边运行而主程序继续向下执行后面的代码，当之前的代码完成后再处理返还结果，这就是异步，而同步就是必须等待之前的代码成功运行并返还以后再向下执行代码。很显然setTimeout以及主流的接口调用获取数据的代码都是异步操作，这是因为以防出现阻塞以及页面长时间加载空白的问题。但是为什么这些异步操作要在actions中执行而不能再mutations中执行呢？这是因为vue官方插件专门提供了一个调试区域可以实时跟踪并显示vuex中state的值，但是如果mutations中的方法出现异步操作可能会造成跟踪出现异常。

如果你还没有vuex官方插件，可以点击下方链接前往极简插件商城下载

{% link vue插件下载, https://chrome.zzzmh.cn/info?token=nhdogjmejiglipccpnnnanhbledajbpd%}

这里我们举一个小例子，加入现在我们并不像setCurIdx的值立刻更新，而是等待1s后在更新。现在我们将延时函数setTimeout写到mutations内部如下

![](https://langwenchong.gitee.io/figure-bed/20211212201139.png)

实际上此时vuex内部的curIdx就4，但是这个插件跟踪出现了异常，为了避免这种情况的发生，我们需要将异步操作放置到actions中，但是actions中并不能直接操作state中的数据，因此他需要等待1s以后调用mutations中的方法进行state中curIdx值的更新，如下：

```js
import Vue from "vue";
import Vuex from 'vuex'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
    curIdx: 1,
  },
  getters: {
    //   形参和mutations类似，第一个永远是state,第二个是payload
    content(state) {
      return `当前显示的时第${state.curIdx}个标签对应的页面的内容`
    }
  },
  mutations: {
    // 用来定义修改state中数据的方法
    // 用来修改state中的curIdx
    // 默认第一个参数永远是state
    setCurIdx(state, idx) {
      state.curIdx = idx;
      //   z这种异步操作在mutations中要避免
      //   setTimeout(()=>{
      //     state.curIdx = idx;
      //   }, 1000)
    }
  },
  actions: {
    // 异步操作
    // 注意第一个形参不是state而是context即this.$store因此后面可以跟commit调用mutattions中的函数
    updateCurIdx(context, idx) {
      setTimeout(() => {
        context.commit('setCurIdx', idx);
      },1000)
    }
  },
  modules: {
    // 分模块引入
  }
})

```

此时我们还需要更改Tab中的代码让其不再直接调用setCurIdx()而是调用updateCurIdx()，这里同样有两种方法。

##### 方法一

直接通过 `this.$store.dispatch.updateCurIdx()`实现，这里的dispatch作用和mutations中的commit类似，意为调用触发vuex中指定的方法，因此同样第一个参数是方法名，第二个参数是传值对象payload。此时Tab组件代码修改为

![](https://langwenchong.gitee.io/figure-bed/20211212202617.png)

##### 方法二

类似的就是借用 `mapActions`辅助函数啦，如下映射到methods即可了

```vue
<template>
  <div>
    <!-- 不在使用prop而是使用this.$store.state.curIdx获取 -->
    <!-- 由于vue中template无需使用this -->
    <!-- 因此直接使用$store.state.curIdx即可 -->
    <!-- 由于setCurIdx已经映射为了自己的方法因此直接调用即可 -->
    <a
      href="javascript:;"
      @click="updateCurIdx(1)"
      :class="[{ current: $store.state.curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(2)"
      :class="[{ current: $store.state.curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(3)"
      :class="[{ current: $store.state.curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(4)"
      :class="[{ current: $store.state.curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
import { mapMutations } from "vuex";
import {mapActions} from 'vuex'
export default {
  name: "Tab",
  //接收父组件传递进来的curIdx的值
  // props: {
  //   curIdx: Number,
  // },
  //点击触发父组件更新curIdx值
  methods: {
    // 使用映射的方法获取setCurIdx方法
    ...mapMutations(["setCurIdx"]),
    // 映射引入actions
    ...mapActions(['updateCurIdx']),
    // changeTab(i) {
    //   this.$emit("changeTab", i);
    // },

    //  当然也可以不映射，而是直接调用this.$store.mutations.setCurIdx()修改
    // setCurIdx(idx) {
    //   this.$store.commit("setCurIdx", idx);
    // },

    //我们甚至可以进一步封装将setCurIdx改个名字
    // ...mapMutations(['setCurIdx']),
    // changeTab(idx){
    //   this.setCurIdx(idx);
    // }

    // updateCurIdx(idx) {
    //   this.$store.dispatch("updateCurIdx", idx);
    // },
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

##### 应用实战

但是实际上我们大部分场景用不到setTimeout异步函数来操作vuex中的数据，更常见的是通过fetch、ajax或者axios拿去数据来为vuex中的值进行初始化，由于这些操作都是异步的，因此我们需要在actions中执行这些请求操作，获取到响应请求数据后再通过调用mutations中的方法来为state中的值进行初始化赋值。现在我们假设一开始并不知道哪一个a标签被选中，即curIdx值并不确定，我们需要通过一个api从后台去获取这个初始值，此时我们就会用到异步请求函数，假设curIdx初始值是3，我们现在需要调用接口 `/init`来获取到这个初始curIdx值，由于我们没有后台，因此使用axios+mock.js的方式来演示，首先我们需要安装axios

```bash
npm install axios --save
```

然后我们在main.js中全局引入axios并挂载到vue的原型上，这样我们在任意位置处都可以使用axios请求函数。

```js
// 引入axios
import axios from 'axios';
// 挂载到vue原型链上
Vue.prototype.axios = axios;
```

然后我们再在根目录下创建一个axios文件夹并且在文件夹下创建index.js用来返还使用接口请求函数同时创建一个api.js用来存放具体的请求函数内容如下图

![](https://langwenchong.gitee.io/figure-bed/20211212204709.png)

然后我们在两个文件中加入如下代码来向外暴露一个请求数据的方法这样子写的好处是当我们需要进行许多数据的请求时都只需要在这里定义好请求方法，然后组件一行调用这个向外暴露的方法即可，既保证了组件内部没有具体的请求函数内容，简洁优雅，同时所有的具体请求内容都放置到了api.js中方便后期维护（从此不再需要去组件中的各个位置去修改请求代码了😎）

{% tabs axios %}

<!-- tab index.js -->

```js
// 读取api.js内部定义的请求方法
import * as apis from './api.js'
// 暴露给外部以便调用，此时所有的api方法整合到了一起形成一个对象命名为apis
export default apis
```

<!-- endtab -->

<!-- tab api.js -->

```js
import axios from 'axios'
 
// 默认接口头部公有的ip地址，由于这里是本机假请求并使用mock.js拦截返还
// 因此使用本地回环地址127.0.0.1同时默认是80端口
axios.defaults.baseURL = 'http://127.0.0.1:80';
//该地址就叫URL（Uniform Resource Locator,统一资源定位器）
//Axios 是一个基于 promise 的 HTTP 库，可以用在浏览器和 node.js 中。
//API（Application Programming Interface，应用程序接口）

// 没有传递的参数
// 使用gei或者post都可以，我这里使用get请求
export const initData = () => {
    return axios.get('/initData');
}
```

<!-- endtab -->

{% endtabs %}

然后我们再安装mock.js和[axios](https://so.csdn.net/so/search?from=pc_blog_highlight&q=axios)-mock-adapter

```js
npm install mockjs --save
//用来模拟仿真请求返回，可以拦截并解析得到去除ip后的路径
npm install axios-mock-adapter --save-dev         //开发环境依赖
```

然后为了方便管理我们再在根目录下新建一个mock文件夹并新建index.js用来存放所有的mock拦截函数，然后我们再在mock文件夹下创建一个data文件夹，其内部再创建一个data.js用来存储具体的初始化数据如下图：

![](https://langwenchong.gitee.io/figure-bed/20211212205839.png)

我们分别在各个文件中加入如下代码

{% tabs mock.js %}

<!-- tab index.js -->

```js
// 通过axios-mock-adapter生成代理api地址，可以模拟后台的数据返还
import axios from "axios";
import MockAdapter from "axios-mock-adapter";

import {
  initData
} from './data/data.js'

export default {
  // 第一个拦截返还函数
  init() {
    // 新建一个拦截对象
    let mock = new MockAdapter(axios);
    mock.onGet('/initData').reply(
      // 无传进来的参数，因此是无参箭头函数
      () => {
        //   如果时有参数的请求，那么可以在这里进行解析
        // 返还一个Promise对象
        return new Promise(resolve => {
          //   resolve表示成功返还
          //   是一个数组，其中第一个200是返还数据的头部信息状态code
          resolve([200, {
            //   这里供开发者使用
            code: 200,
            // 重点是要将初始的数据拿过来
            initData,
          }]);
        })
      }
    )
  }
}

```

<!-- endtab -->

<!-- tab data/data.js -->

```js
// 设置为常量不能被修改
const initData={
    curIdx:3
}
// 向外暴露
export {initData}
```

<!-- endtab -->

{% endtabs %}

拦截函数完成以后我们同样在main.js中引入

```js
// 引入这个对象
//默认引入mock文件夹下入口js文件index.js返还的对象
import Mock from '../mock'
// 加入init拦截函数
Mock.init();
```

此时我们已经完成了请求axios和拦截响应模块的准备，接下来我们进行演示，首先我们需要自定义一个新的actions函数同时他会调用axios向外暴露的请求函数initData，当请求成功发送后会被mock.js拦截然后返还响应，我们这里可以先打印一下返还信息res如下

```js
import axios from "axios";
import Vue from "vue";
import Vuex from 'vuex'

//默认引入index.js下的向外暴露的apis对象
// 引入这个这个包含了所有请求函数的对象
import apis from '../axios'
// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: {
    // 用来维护通信使用的数据
    curIdx: 1,
  },
  getters: {
    //   形参和mutations类似，第一个永远是state,第二个是payload
    content(state) {
      return `当前显示的时第${state.curIdx}个标签对应的页面的内容`
    }
  },
  mutations: {
    // 用来定义修改state中数据的方法
    // 用来修改state中的curIdx
    // 默认第一个参数永远是state
    setCurIdx(state, idx) {
      state.curIdx = idx;
      //   z这种异步操作在mutations中要避免
      //   setTimeout(()=>{
      //     state.curIdx = idx;
      //   }, 1000)
    }
  },
  actions: {
    // 异步操作
    // 注意第一个形参不是state而是context即this.$store因此后面可以跟commit调用mutattions中的函数
    updateCurIdx(context, idx) {
      setTimeout(() => {
        context.commit('setCurIdx', idx);
      }, 1000)
    },
    init() {
      // 调用它的initData()方法进行初始化
      apis.initData().then(res => {
        console.log(res)
      });
    }
  },
  modules: {
    // 分模块引入
  }
})

```

然后我们在Tab组件中的created钩子函数下触发这个actions函数，如果能够成功被拦截那么控制台将会打印返还信息如下

```vue
<template>
  <div>
    <!-- 不在使用prop而是使用this.$store.state.curIdx获取 -->
    <!-- 由于vue中template无需使用this -->
    <!-- 因此直接使用$store.state.curIdx即可 -->
    <!-- 由于setCurIdx已经映射为了自己的方法因此直接调用即可 -->
    <a
      href="javascript:;"
      @click="updateCurIdx(1)"
      :class="[{ current: $store.state.curIdx === 1 }]"
    >
      选项1</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(2)"
      :class="[{ current: $store.state.curIdx === 2 }]"
    >
      选项2</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(3)"
      :class="[{ current: $store.state.curIdx === 3 }]"
    >
      选项3</a
    >
    <a
      href="javascript:;"
      @click="updateCurIdx(4)"
      :class="[{ current: $store.state.curIdx === 4 }]"
    >
      选项4</a
    >
  </div>
</template>


<script>
import { mapMutations } from "vuex";
import {mapActions} from 'vuex'
export default {
  name: "Tab",
  //调用actions进行curIndex的初始化
  created() {
    this.$store.dispatch("init");
  },
  //接收父组件传递进来的curIdx的值
  // props: {
  //   curIdx: Number,
  // },
  //点击触发父组件更新curIdx值
  methods: {
    // 使用映射的方法获取setCurIdx方法
    ...mapMutations(["setCurIdx"]),
    // 映射引入actions
    ...mapActions(['updateCurIdx']),
    // changeTab(i) {
    //   this.$emit("changeTab", i);
    // },

    //  当然也可以不映射，而是直接调用this.$store.mutations.setCurIdx()修改
    // setCurIdx(idx) {
    //   this.$store.commit("setCurIdx", idx);
    // },

    //我们甚至可以进一步封装将setCurIdx改个名字
    // ...mapMutations(['setCurIdx']),
    // changeTab(idx){
    //   this.setCurIdx(idx);
    // }

    // updateCurIdx(idx) {
    //   this.$store.dispatch("updateCurIdx", idx);
    // },
  },
};
</script>


<style scoped>
a {
  margin-right: 10px;
}
.current {
  color: #000;
  text-decoration: none;
}
</style>
```

控制台出现下图即说明成功！

![](https://langwenchong.gitee.io/figure-bed/20211212215043.png)

很明显data中是我们需要的数据，因此我们在actions中的init函数中进行解析然后调用setCurIdx进行state中的curIdx赋值就行了。

```js
init(context) {
      // 调用它的initData()方法进行初始化
      apis.initData().then(res => {
        console.log(res)
        context.commit('setCurIdx',res.data.initData.curIdx)
      });
    }
```

自此我们就完成了vuex中curIdx的异步调用请求接口进行初始化的工作，我们会发现刷新页面以后默认被选中的标签就是第三个同时下方的内容也是第三个内容

![](https://langwenchong.gitee.io/figure-bed/20211212215538.png)

这就是一个典型的异步请求数据并初始化的流程，同时我们还熟悉了标准的axios和mock.js的使用。

##### 关于异步执行的问题

我们知道js在执行函数时是异步执行的，即解释器在执行触发函数的代码以后并不会像c一样等大函数执行完毕并返还结果再执行接下来的代码，而是让函数先执行，自己继续进行下面代码的解释和运行，即 `异步执行`。我们先看一个简单的例子，如下所示，我们希望在Tab中created声明钩子函数中调用的dispatch触发hello这个action异步函数以后可以等待函数执行完毕后返还true并给suc赋值，我们第一时间想到的代码就是：

{% tabs 异步函数同步等待1 %}

<!-- tab store/actions.js -->

```js
hello(){
    // 1s以后执行打印操作，然后返还true给suc赋值
    setTimeout(()=>{
      console.log(`hello`);
      return true;
    },1000);
  }
```

<!-- endtab -->

<!-- tab Tab/index.vue -->

```js
created() {
    this.$store.dispatch("init");
    var suc = this.$store.dispatch("hello");
    console.log(suc);
  },
```

<!-- endtab -->

{% endtabs %}

我们会发现他返还给suc是一个Promise对象，但是这样并没有能够成功给suc赋值true

![](https://langwenchong.gitee.io/figure-bed/20211217091206.png)

suc被初始化赋值成了一个Promise对象了，但是并没有达到我们的预期效果（我们是希望他变为布尔类型的true值）。可是我们从中可以发现actions函数触发执行完代码以后会返还一个Primise对象,这样的话我们是否可以直接调用then来进行同步等待后的赋值呢？如下所示

```js
created() {
    this.$store.dispatch("init");
    this.$store.dispatch("hello").then(()=>{
      var suc=true;
      console.log(suc)
    })
  },
```

![](https://langwenchong.gitee.io/figure-bed/20211217093610.png)

我们得到了预期的效果，此时我们可以利用Promise对象的特点在执行完成以后在执行then后面的函数进行赋值，即同步等待前面的函数执行完成以后我们再进行后面的代码。但是此时我们并不能接收到hello函数返还的参数，加入我们现在希望hello在返还'success'字符串以后才能给suc赋值true,那么此时我们仅仅使用actions默认返还的Promise对象明显做不到了，此时我们可以手动创建一个Promise返还对象并且使用resolve()函数传递我们要返还的值代码如下：

{% tabs 异步执行同步等待2 %}

<!-- tab  store/actions.js -->

```js
hello() {
    //嵌套在最外面
    return new Promise((resolve, reject) => {
      // 1s以后执行打印操作，然后返还success给suc赋值
      setTimeout(() => {
        console.log(`hello`);
        //手动加入执行完成后的resolve函数
        // 这样后面的then可以捕捉到继续执行函数
        resolve("success");
      }, 1000);
    })
  }
```

<!-- endtab -->

<!-- tab Tab/index.vue -->

```js
created() {
    this.$store.dispatch("init");
    this.$store.dispatch("hello").then((data) => {
      if (data === `success`) {
        var suc = true;
        console.log(suc);
      }
    });
  },
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211217094144.png)

此时我们仅在hello方法返还success字符串变量以后才会对suc赋值为true,这样我们就可以根据不同的返还值执行不同的操作了。

{% note info,

要注意dispatch默认返还的是一个Promise对象，因此我们可以链式执行，同时可以和`async/await`结合使用来等待所有的异步操作完成以后再返还Promise对象。

%}

我们知道async是声明一个函数f为异步函数，那么此时f的返回值将是一个Promise对象，因此后面可以接f.then()来进行链式操作并且在里面进行同步等待后的数据处理操作。同时await就是`async await`的简写，他会阻塞等待后面所接的异步函数执行完resolve后获取resolve返还值才继续执行下面的代码，即`同步等待`。要注意**await只能放在async函数内部使用**

###### 思考：await和.then都可以完成同步等待执行后面的代码操作，那么两者有何区别？

await可以实现正常的表达式赋值，如下两者是等价的

{% tabs 两者区别 %}

<!-- tab .then实现 -->

```js
//f会返还Promise对象，异步函数
async f(){
    ...
    resolve(true)
}
test(){
    f.then((data)=>{
        //接下来给suc赋值true
        var suc=data
    })
}
```

<!-- endtab -->

<!-- tab await实现 -->

```js
async f(){
    ...
     resolve(true)
}
//注意此时test需要声明为async，这样其内部才能使用await
async test(){
    //同样实现了给suc赋值true
    var suc=await f();
}
```

<!-- endtab -->

{% endtabs %}

那么我们在多重actions方法调用的情况下也可以使用这两个关键字完成`等待所有的异步函数执行完成后返还Promise的操作`如下

```js
// 假设 getData() 和 getOtherData() 返回的是 Promise

actions: {
  //actions A会等待getData这个异步函数resolve()后再返还Promise
  async actionA ({ commit }) {
    commit('gotData', await getData())
  },
  async actionB ({ dispatch, commit }) {
    await dispatch('actionA') // 等待 actionA 完成返还Promise
    //同时还要等待getOtherData()方法也resolve()返还Promise
    commit('gotOtherData', await getOtherData())
    //只有如上的所有等待异步函数全部返还后actionB才会返还Promise
  }
}
```

此时我们就实现了actionB同步等待函数内部的两行代码出发的所有异步函数全部执行完成以后再返还Promise的操作了。

#### 文件结构整理

现在我们已经掌握了vuex的基础操作，但是此时的所有有关vuex的属性全部都是存储都一个store/index.js文件下，这样子的目录结构很不合理，只能适用于简单的项目中，为了能够方便管理，并且在项目后期规模日渐庞大的情况下易于维护，我们通常会将这几个属性分别使用一个js文件来存储，然后统一引入到index.js中。这样我们就需要创建几个新的js文件分别是state.js、mutations.js、getters.js、actions.js(当然modules也可以独立存储到一个modules.js中)如下所示

![](https://langwenchong.gitee.io/figure-bed/20211213135123.png)

{% tabs 文件结构整理 %}

<!-- tab index.js -->

```js
import axios from "axios";
import Vue from "vue";
import Vuex from 'vuex'


// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 引入各个属性对象
import state from './state';
import getters from './getters'
import mutations from './mutations'
import actions from './actions'

// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: state,
  getters: getters,
  mutations: mutations,
  actions: actions,
  modules: {
    // 分模块引入
  }
})

```

<!-- endtab -->

<!-- tab state.js -->

```js
export default {
  // 用来维护通信使用的数据
  curIdx: 1,
}

```

<!-- endtab -->

<!-- tab getters.js -->

```js
export default {
  //   形参和mutations类似，第一个永远是state,第二个是payload
  content(state) {
    return `当前显示的时第${state.curIdx}个标签对应的页面的内容`
  }
}

```

<!-- endtab -->

<!-- tab mutations.js -->

```js
export default {
  // 用来定义修改state中数据的方法
  // 用来修改state中的curIdx
  // 默认第一个参数永远是state
  setCurIdx(state, idx) {
    state.curIdx = idx;
    //   z这种异步操作在mutations中要避免
    //   setTimeout(()=>{
    //     state.curIdx = idx;
    //   }, 1000)
  }
}

```

<!-- endtab -->

<!-- tab actions.js -->

```js
//默认引入index.js下的向外暴露的apis对象
// 引入这个这个包含了所有请求函数的对象
import apis from '../axios'

export default {
  // 异步操作
  // 注意第一个形参不是state而是context即this.$store因此后面可以跟commit调用mutattions中的函数
  updateCurIdx(context, idx) {
    setTimeout(() => {
      context.commit('setCurIdx', idx);
    }, 1000)
  },
  init(context) {
    // 调用它的initData()方法进行初始化
    apis.initData().then(res => {
      console.log(res)
      context.commit('setCurIdx', res.data.initData.curIdx)
    });
  }
}

```

<!-- endtab -->

{% endtabs %}

按照如上的文件结构来存储可以方便管理，因为伴随着项目的开发，每一个属性下面都会存在大量的数据、方法。

#### modules使用

接下来我们再学习一下modules属性，它通常会在多人合作的企业项目中使用。我们现在考虑一个问题，某一个项目会根据功能模块进行划分，然后每一个开发人员负责一个模块的划分，此时毋庸置疑几个模块是并行开发的，最后再合并分支形成完整的项目。那么在开发过程中每一个开发人员都肯定会用到vuex，此时可能开发人员小明使用了一个count变量，并且还定义了setCount方法，而开发人员小红也自己定义了一个count变量，并且也定义了setCount方法，那么合并以后很明显会出现一个问题，即count到底属于哪一个功能模块？因此在合作开发中为了避免多个人使用的vuex存在大量重名变量而不知道归属的情况就引入了modules概念。它很好理解，解决的办法类似于vue中组件的使用，每一个人的vuex都有一个自己的文件夹存储自己需要的东西，然后我们按照模块导入使用即可，那么为了区分不同vuex模块中的同名变量和同名方法很明显我们需要为每一个模块都起一个独特的名字即 `命名空间`。

现在我们以一个例子来讲解如何使用modules，假设现在我们有两个加法器组件counter1和counter2，他们都使用了模块对应的vuex中的count变量，并且可以调用自己对应的vuex中mutations存储的addCount方法进行加操作，此时很显然我们希望两个加法器的count和setCount互不干扰，此时我们就需要使用modules属性了，首先我们需要建立两个新的vuex模块，只需要在store文件夹下建立两个新文件夹counter1和counter2同时这两个文件夹都有完整的vuex结构如下

![](https://langwenchong.gitee.io/figure-bed/20211213141247.png)

首先给出counter1模块下的代码

{% tabs counter1%}

<!-- tab counter1/index.js -->

```js
import mutations from "./mutations";
import state from "./state";

// 要注意返还仅仅是一个对象，而不是new Vuex.store
// Vuex.store只会有一个
export default {
  //开启命名空间。那么调用它的属性时需要加上名字前缀counter1
  namespaced: true,
  state: state,
  mutations: mutations,
}

```

<!-- endtab -->

<!-- tab counter1/state.js -->

```js
export default{
    count:0,
}
```

<!-- endtab -->

<!-- tab counter1/mutations.js -->

```js
export default {
  setCount(state, num) {
    state.count += num;
  }
}

```

<!-- endtab -->

{% endtabs %}

然后我们再给出counter2模块下的代码

{% tabs counter2 %}

<!-- tab counter2/index.js -->

```js
import mutations from "./mutations";
import state from "./state";

// 要注意返还仅仅是一个对象，而不是new Vuex.store
// Vuex.store只会有一个
export default {
  //开启命名空间。那么调用它的属性时需要加上名字前缀counter2
  namespaced: true,
  state: state,
  mutations: mutations,
}

```

<!-- endtab -->

<!-- tab counter2/state.js -->

```js
export default{
    count:2,
}
```

<!-- endtab -->

<!-- tab counter2/mutations.js -->

```js
export default {
    setCount(state, num) {
      state.count += num;
    }
  }
  
```

<!-- endtab -->

{% endtabs %}

{% note info,

首先要注意模块的index.js返还的仅仅是个对象而不是store对象，同时命名空间属性是 `namespaced`要设置为true

%}

我们会发现这两个模块的数据和方法名称是相同的，但是我们为这两个模块的counter设置的初始值略有不同。然后我们将这两个模块引入到vuex中，只需要再store/index.js中引入这两个modules即可

```js
import axios from "axios";
import Vue from "vue";
import Vuex from 'vuex'


// 由于是插件，因此需要将其挂载到vue上
Vue.use(Vuex)

// 引入各个属性对象
import state from './state';
import getters from './getters'
import mutations from './mutations'
import actions from './actions'
// 引入counter1和counter2两个模块
import counter1 from './counter1'
import counter2 from './counter2'
// 注意返还的是一个vuex的仓库对象
export default new Vuex.Store({
  // 里面包含之前介绍的几个属性
  state: state,
  getters: getters,
  mutations: mutations,
  actions: actions,
  modules: {
    // 分模块引入
    counter1,
    counter2,
  }
})

```

此时我们再来编写两个加法器Counter1和Counter2他们分别使用对应vuex模块下的变量和方法。

{% tabs 加法器 %}

<!-- tab Counter1/index.vue -->

```js
<template>
  <div>
    <h2>Counter1</h2>
    <div>Counter1:{{ count }}</div>
    <button @click="setCount(1)">add</button>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
export default {
  name: "Counter1",
  computed: {
    //   注意，此时要额外再传一个参数即命名空间这里是counter1
    // 后面的写法是一样的，数组或者对象形式都可以
    ...mapState("counter1", ["count"]),
  },
  methods: {
    ...mapMutations("counter1", ["setCount"]),
  },
};
</script>


<style scoped>
</style>
```

<!-- endtab -->

<!-- tab Counter2/index.vue -->

```vue
<template>
  <div>
    <h2>Counter2</h2>
    <div>counter1:{{ count }}</div>
    <button @click="setCount(2)">add</button>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
export default {
  name: "Counter2",
  computed: {
    //   注意，此时要额外再传一个参数即命名空间这里是counter1
    // 后面的写法是一样的，数组或者对象形式都可以
    ...mapState("counter2", ["count"]),
  },
  methods: {
    ...mapMutations("counter2", ["setCount"]),
  },
};
</script>


<style scoped>
</style>
```

<!-- endtab -->

{% endtabs %}

这里的两个加法器也基本一样，但是要注意他们的映射辅助函数传进去的命名空间是不同的，同时我们规定加法器1每次按按钮只进行加一，而加法器2每一次按按钮是加二。然后我们再在App.vue中引入并使用这两个加法器

```vue
<template>
  <div id="app">
    <!-- 传递给子组件Tab的值以及为他绑定一个方法用来通知父组件更新值 -->
    <!-- <Tab :curIdx="curIdx" @changeTab="changeTab" /> -->
    <!-- 不在需要传递curIdx了 -->
    <!-- <Tab @changeTab="changeTab" /> -->
    <!-- 也无需在为子组件提供方法了 -->
    <Tab />
    <!-- Page组件也接受这个curIdx值 -->
    <!-- <Page :curIdx="curIdx"></Page> -->
    <!-- 不在需要传递curIdx了 -->
    <Page></Page>
    <!-- <img src="./assets/logo.png"> -->
    <!-- <router-view/> -->
    <Counter1></Counter1>
    <Counter2></Counter2>
  </div>
</template>

<script>
import Tab from "@/components/Tab";
import Page from "@/components/Page";
// 引入两个加法器
import Counter1 from "@/components/Counter1";
import Counter2 from "@/components/Counter2";
export default {
  name: "App",
  components: {
    Tab,
    Page,
    Counter1,
    Counter2,
  },
  // 无需在定义curIdx了
  // data() {
  //   return {
  //     curIdx: 0,
  //   };
  // },
  // 无需在定义这个方法了
  // methods: {
  //   changeTab(i) {
  //     this.curIdx = i;
  //   },
  // },
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
}
</style>

```

最后我们即可得到如下效果图，会发现上下两个加法器之间数据互不干扰

![](https://langwenchong.gitee.io/figure-bed/20211213145428.png)

### 总结

自此我们基本上就掌握了大部分的vuex技能，同时用demo学习实战了如何进行vuex分模块的操作。最后强烈建议虽然映射的写法比较难以理解，但是理解后使用映射的方法更加优雅且易于维护，再真正的大型项目中强推分模块使用vuex！

如果您还有任何疑惑可以参考官方文档

{% link vuex文档, https://vuex.vuejs.org/zh/#%E4%BB%80%E4%B9%88%E6%98%AF-%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86%E6%A8%A1%E5%BC%8F%}

同时这里给出上面博客演示时使用的代码，整理不易，如果喜欢还请转载时带上署名😣

{% link vuex代码仓库, https://github.com/Langwenchong/vuex-demo %}
