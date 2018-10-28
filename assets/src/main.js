import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false
Vue.config.devtools = true  //remove before deploying to prod

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
