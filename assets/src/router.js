import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Login from './views/Login.vue'
import Registration from './views/Register.vue'
import RegistrationSuccess from './views/RegisterSuccessful.vue'
import Secret from './views/Secret.vue'

import Sample1 from './views/Sample1.vue'
import Sample2 from './views/Sample2.vue'
import Sample3 from './views/Sample3.vue'

import LoginLayout  from './Login.vue';
import DashboardLayout  from './Dashboard.vue';

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
        path: '/',
        component: LoginLayout,
        children: [
          {
            path: 'login',
            component: Login,
            name: 'Login',
            meta: {description: 'Login page'}
          }, {
            path: 'register',
            component: Registration,
            name: 'Registration',
            meta: {description: 'User registration'}
          }, {
            path: 'registered',
            component: RegistrationSuccess,
            name: 'User Registered',
            meta: {description: 'Show after user successfully registered'}
          },{
            path: '/logout',
              beforeEnter (to, from, next) {
                localStorage.removeItem('jwt');
                next('/login')
              }
          }
        ]
      },
      {
        path: '/',
        component: DashboardLayout,
        children: [
          {
            path: 'secret',
            component: Secret,
            name: 'Secret',
            meta: {description: 'Dashboard page'}
          }, 
          {
            path: '/home',
            name: 'home',
            component: Home
          },
          {
            path: '/sample1',
            name: 'Sample1',
            component: Sample1
          },
          {
            path: '/sample2',
            name: 'Sample2',
            component: Sample2
          },
          {
            path: '/sample3',
            name: 'Sample3',
            component: Sample3
          },
        ]
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