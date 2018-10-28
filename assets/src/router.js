import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Login from './views/Login.vue'
import Registration from './views/Register.vue'
import RegistrationSuccess from './views/RegisterSuccessful.vue'
Vue.use(Router)

function requireAuth (to, from, next) {
  //get value from localstorage
  var secret_token = localStorage.hasOwnProperty('jwt') ? localStorage.getItem('jwt'): '';
  
  if (!secret_token && secret_token.length <= 0 ) {
    //token exists next check if it is valid before proceeding
    next({
      path: '/login',
    })
  } else {
    next()
  }
}

export default new Router({
  routes: [ 
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/registed',
      name: 'registration-success',
      component: RegistrationSuccess
    },

    { path: '/logout',
      beforeEnter (to, from, next) {
        localStorage.removeItem('jwt');
        next('/')
      }
    },
    {
      path: '/register',
      name: 'register',
      component: Registration
    },
    {
      path: '/home',
      name: 'home',
      component: Home
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "about" */ './views/About.vue'),
      beforeEnter:  requireAuth
    }
  ]
})