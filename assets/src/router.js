import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Login from './views/Login.vue'
import Registration from './views/Register.vue'
import RegistrationSuccess from './views/RegisterSuccessful.vue'
import Dashboard from './views/Dashboard.vue'

import Sample1 from './views/Sample1.vue'
import Sample2 from './views/Sample2.vue'
import Sample3 from './views/Sample3.vue'

import LoginLayout  from './Login.vue';
import DashboardLayout  from './Dashboard.vue';

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [ 
      {
        path: '/',
        redirect: '/dashboard'
      },

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
            path: 'dashboard',
            component: Dashboard,
            name: 'Dashboard',
            beforeEnter: (to, from, next) => {
              const token = localStorage.getItem("jwt");
              if (token) next('/dashboard');
              else next('/login');
            },  
            meta: {description: 'Dashboard page'}
          }, 
          {
            path: '/home',
            name: 'home',
            beforeEnter: (to, from, next) => {
              const token = localStorage.getItem("jwt");
              if (token) next('/home');
              else next('/login');
            },  
            component: Home
          },
          {
            path: '/sample1',
            name: 'Sample1',
            beforeEnter: (to, from, next) => {
              const token = localStorage.getItem("jwt");
              if (token) next('/sample1');
              else next('/login');
            },  
            component: Sample1
          },
          {
            path: '/sample2',
            name: 'Sample2',
            beforeEnter: (to, from, next) => {
              const token = localStorage.getItem("jwt");
              if (token) next('/sample2');
              else next('/login');
            },  
            component: Sample2
          },
          {
            path: '/sample3',
            name: 'Sample3',
            beforeEnter: (to, from, next) => {
              const token = localStorage.getItem("jwt");
              if (token) next('/sample3');
              else next('/login');
            },  
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
      }
    ]
})