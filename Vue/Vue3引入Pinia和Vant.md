### 1. **引入 Pinia**

Pinia 是 Vue 3 官方推荐的状态管理库，轻量且易用。它可以帮助你在组件之间共享状态。

#### 1.1. 安装 Pinia

首先，在项目根目录下安装 Pinia：

```bash
pnpm install pinia
```

#### 1.2. 配置 Pinia

在项目的主入口文件 `main.js`（或 `main.ts`）中配置 Pinia。

```javascript
// main.js
import { createApp } from 'vue';
import { createPinia } from 'pinia';
import App from './App.vue';

const app = createApp(App);

// 创建 Pinia 实例
const pinia = createPinia();

// 在应用中注册 Pinia
app.use(pinia);

app.mount('#app');
```

#### 1.3. 创建一个 Pinia Store

在 `src/store` 文件夹下创建一个新的 store，比如 `store.js` 或 `store.ts`。

```javascript
// store.js
import { defineStore } from 'pinia';

// 创建一个名为 useMainStore 的 store
export const useMainStore = defineStore('main', {
  state: () => ({
    counter: 0,
    message: 'Hello, Pinia!'
  }),
  actions: {
    increment() {
      this.counter++;
    }
  }
});
```

#### 1.4. 在组件中使用 Pinia

在组件中使用 `useMainStore` 来访问和修改状态。

```vue
<!-- ExampleComponent.vue -->
<template>
  <div>
    <p>{{ store.counter }}</p>
    <button @click="store.increment">Increment</button>
  </div>
</template>

<script>
import { useMainStore } from './store';

export default {
  setup() {
    // 使用 store
    const store = useMainStore();
    return { store };
  }
};
</script>
```

### 2. **引入 Vant**

Vant 是一个专注于移动端的 Vue 3 UI 组件库。引入 Vant 后可以直接使用它提供的各种组件。

#### 2.1. 安装 Vant

在项目根目录下安装 Vant：

```bash
pnpm install vant
```

#### 2.2. 全局引入 Vant 组件库

在 `main.js` 中引入 Vant，并全局注册 Vant 组件库。

```javascript
// main.js
import { createApp } from 'vue';
import App from './App.vue';
import { createPinia } from 'pinia';
import Vant from 'vant';
import 'vant/lib/index.css'; // 引入 Vant 样式

const app = createApp(App);

app.use(createPinia());
app.use(Vant);

app.mount('#app');
```

#### 2.3. 使用 Vant 组件

在 Vue 组件中直接使用 Vant 组件，比如 `Button` 和 `Dialog`。

```vue
<!-- ExampleComponent.vue -->
<template>
  <div>
    <van-button type="primary" @click="showDialog = true">Show Dialog</van-button>
    <van-dialog v-model:show="showDialog" title="Hello" show-cancel-button>
      Welcome to Vant!
    </van-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showDialog: false
    };
  }
};
</script>
```

### 3. **按需引入 Vant 组件（可选）**

如果不想全局引入所有的 Vant 组件，可以按需引入组件，这样可以减少打包体积。

#### 3.1. 安装按需引入插件

```bash
pnpm install babel-plugin-import -D
```

#### 3.2. 配置 Babel

在 `babel.config.js` 中配置按需引入 Vant 组件。

```javascript
// babel.config.js
module.exports = {
  presets: ['@vue/cli-plugin-babel/preset'],
  plugins: [
    [
      'import',
      {
        libraryName: 'vant',
        libraryDirectory: 'es',
        style: true
      },
      'vant'
    ]
  ]
};
```

#### 3.3. 按需引入 Vant 组件

在需要使用的组件文件中按需引入所需要的 Vant 组件。

```vue
<!-- ExampleComponent.vue -->
<template>
  <div>
    <van-button type="primary" @click="showDialog = true">Show Dialog</van-button>
    <van-dialog v-model:show="showDialog" title="Hello" show-cancel-button>
      Welcome to Vant!
    </van-dialog>
  </div>
</template>

<script>
import { Button, Dialog } from 'vant';

export default {
  components: {
    'van-button': Button,
    'van-dialog': Dialog
  },
  data() {
    return {
      showDialog: false
    };
  }
};
</script>
```

### 总结

- **Pinia**：用于管理 Vue 应用中的全局状态，它比 Vuex 更简单轻量，适合 Vue 3。
- **Vant**：用于移动端开发的 UI 组件库，提供丰富的组件，提升开发效率。

通过引入 Pinia 和 Vant，你可以轻松实现状态管理和使用精美的移动端组件，让 Vue 项目的开发更加高效。